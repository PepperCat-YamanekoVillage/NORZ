// RLC/RL/RRC/RR/SLA/SRA/SRL (IX/IY+d) / BIT/SET/RES b,(IX/IY+d)
// 23(49)
module DECODER_op_XIX4_1(
        input wire not_enable,
        input wire is_Y,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [11:0] _decodedXPT,
        output wire enable_bit,
        output wire PR_Write_Dtex,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PI_SelectAd_DtexDt,
        output wire PA_Select_Dt_low,
        output wire PA_Select_Dt_high,
        output wire PR_Write_Dt,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd, // >
        output wire P2_Reset_XIX4,
        output wire P2_Reset_XIY4,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectAd_ALU,
        output wire PI_SelectDt_Dt,
        output wire PA_Select_OPold_low,
        output wire PA_ADD,
        output wire PA_Select_IX_high,
        output wire PA_Select_IY_high
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    wire _t00xx;
    wire _t01xx;
    wire _t10xx;

    DECODER_2bit_decoder t_ddxx( // 5
        .notEnable(not_enable),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out00(_t00xx),
        .out01(_t01xx),
        .out1x(_t10xx)
    );

    wire _nott00xx = _t00xx ~| _t00xx;
    wire _nott01xx = _t01xx ~| _t01xx;
    wire _nott10xx = _t10xx ~| _t10xx;

    assign _decodedXPT[3] = _nott00xx ~| notXPT[0];

    DECODER_2bit_decoder t_01dd( // 8
        .notEnable(_nott01xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7])
    );

    DECODER_2bit_decoder t_10dd( // 8
        .notEnable(_nott10xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[8]),
        .out01(_decodedXPT[9]),
        .out10(_decodedXPT[10]),
        .out11(_decodedXPT[11])
    );

    // 3

    assign PR_Write_Dtex = _decodedXPT[3];

    // 5

    assign PC_R0 = _decodedXPT[5];

    // 6

    assign PC_R1 = _decodedXPT[6];

    // 7

    assign PC_R2 = _decodedXPT[7];

    // 5~7

    assign PI_SelectAd_DtexDt = _nott01xx ~| _decodedXPT[4];

    // 8

    assign enable_bit = _decodedXPT[8];

    wire _notdecodedXPT8 = _decodedXPT[8] ~| _decodedXPT[8];

    wire _t8_RRR;
    wire _t8_BIT;
    wire _t8_RRRBIT;
    wire _t8_RESSET;

    DECODER_2bit_decoder d_ddxxxxxx( // 5
        .notEnable(_notdecodedXPT8),
        .In(Source[7:6]),
        .notIn(notSource[7:6]),
        .out00(_t8_RRR),
        .out01(_t8_BIT),
        .out0x(_t8_RRRBIT),
        .out1x(_t8_RESSET)
    );

    assign PA_Select_Dt_low = _t8_RRRBIT;
    assign PA_Select_Dt_high = _t8_RESSET;

    wire _t_notBIT = _notdecodedXPT8 ~| _t8_BIT;

    assign PR_Write_Dt = (_t_notBIT | _decodedXPT[3] |  _decodedXPT[7]); // 4

    // end

    assign PR_Reset_XPT = (_t8_BIT | _decodedXPT[11]); // 2
    assign P2_Set_CM1 = PR_Reset_XPT;
    assign Pa_Ophd = PR_Reset_XPT;

    wire _not_is_Y = is_Y ~| is_Y;

    wire _not_end = PR_Reset_XPT ~| PR_Reset_XPT;

    assign P2_Reset_XIX4 = _not_end ~| is_Y;
    assign P2_Reset_XIY4 = _not_end ~| _not_is_Y;

    // 9

    assign PC_W0 = _decodedXPT[9];

    // 10

    assign PC_W1 = _decodedXPT[10];

    // 11

    assign PC_W2 = _decodedXPT[11];

    // 9~11

    assign PI_SelectAd_ALU = _nott10xx ~| _decodedXPT[8];
    assign PI_SelectDt_Dt = PI_SelectAd_ALU;

    // 3or9~11

    assign PA_Select_OPold_low = (PI_SelectAd_ALU | _decodedXPT[3]); // 2
    assign PA_ADD = PA_Select_OPold_low;

    wire _nott3or9_11 = PA_Select_OPold_low ~| PA_Select_OPold_low;

    assign PA_Select_IX_high =  _nott3or9_11 ~| is_Y;
    assign PA_Select_IY_high =  _nott3or9_11 ~| _not_is_Y;

endmodule
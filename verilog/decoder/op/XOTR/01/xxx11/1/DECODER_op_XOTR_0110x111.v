// RRD/RLD
// 13(32)
module DECODER_op_XOTR_0110x111(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [13:0] _decodedXPT,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Write_Dt,
        output wire PA_Select_A_low, // <
        output wire PA_Select_Dt_high,
        output wire PR_Write_A,
        output wire PR_InvertIn,
        output wire PF_Write_Z,
        output wire PF_Write_PV,
        output wire PF_Write_S,
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Select_Z_bit24,
        output wire PF_Select_PV_bit27,
        output wire PF_Select_S_bit7,
        output wire PF_Select_N_bit16,
        output wire PF_Select_H_bit16, // >
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_XOTR,
        output wire Pa_Ophd, //>
        output wire PI_SelectDt_Dt,
        output wire PI_SelectAd_HL,
        output wire PA_RRD,
        output wire PA_RLD
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _t01xx;
    wire _t10xx;
    wire _t11xx;

    DECODER_2bit_decoder t_ddxx( // 7
        .notEnable(_not_enable),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out01(_t01xx),
        .out10(_t10xx),
        .out11(_t11xx)
    );

    wire _nott01xx = _t01xx ~| _t01xx;

    wire _t6or7;

    DECODER_2bit_decoder t_01dd( // 8
        .notEnable(_nott01xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7]),
        .out1x(_t6or7)
    );

    wire _nott10xx = _t10xx ~| _t10xx;

    assign _decodedXPT[11] = ~(_nott10xx | notXPT[1] | notXPT[0]); // 5

    wire _nott11xx = _t11xx ~| _t11xx;

    DECODER_1bit_decoder t_10dd(
        .notEnable(_nott11xx),
        .In(XPT[0]),
        .notIn(notXPT[0]),
        .out0(_decodedXPT[12]),
        .out1(_decodedXPT[13])
    );

    // 4

    assign PC_R0 = _decodedXPT[4];

    // 5

    assign PC_R1 = _decodedXPT[5];

    // 6

    assign PC_R2 = _decodedXPT[6];

    // 6or7

    assign PR_Write_Dt = _t6or7;

    // 7

    assign PA_Select_A_low = _decodedXPT[7];
    assign PA_Select_Dt_high = _decodedXPT[7];
    assign PR_Write_A = _decodedXPT[7];
    assign PR_InvertIn = _decodedXPT[7];
    assign PF_Write_Z = _decodedXPT[7];
    assign PF_Write_PV = _decodedXPT[7];
    assign PF_Write_S = _decodedXPT[7];
    assign PF_Write_N = _decodedXPT[7];
    assign PF_Write_H = _decodedXPT[7];
    assign PF_Select_Z_bit24 = _decodedXPT[7];
    assign PF_Select_PV_bit27 = _decodedXPT[7];
    assign PF_Select_S_bit7 = _decodedXPT[7];
    assign PF_Select_N_bit16 = _decodedXPT[7];
    assign PF_Select_H_bit16 = _decodedXPT[7];

    wire _notdecodedXPT7 = _decodedXPT[7] ~| _decodedXPT[7];

    DECODER_1bit_decoder d_0110d111(
        .notEnable(_notdecodedXPT7),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(PA_RRD),
        .out1(PA_RLD)
    );

    // 11

    assign PC_W0 = _decodedXPT[11];

    // 12

    assign PC_W1 = _decodedXPT[12];

    // 13

    assign PC_W2 = _decodedXPT[13];

    assign PR_Reset_XPT = _decodedXPT[13];
    assign P2_Set_CM1 = _decodedXPT[13];
    assign P2_Reset_XOTR = _decodedXPT[13];
    assign Pa_Ophd = _decodedXPT[13];

    // 11~13

    wire _t11_13 = (_decodedXPT[11] | _t11xx); // 2

    assign PI_SelectDt_Dt = _t11_13;

    // 4~6 or 11~13

    wire _t4_6 = _nott01xx ~| _decodedXPT[7];

    assign PI_SelectAd_HL = (_t4_6 | _t11_13); // 2

endmodule
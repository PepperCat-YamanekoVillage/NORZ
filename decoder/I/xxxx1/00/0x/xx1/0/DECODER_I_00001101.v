// LD HL,(nn)
// 16(29)
module DECODER_I_00001101(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        output wire [8:0] _decodedXPT,
        output wire PI_SelectAd_OPOPold,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Write_L,
        output wire PI_SelectAdt1,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_ITABLE,
        output wire PR_Write_H,
        output wire PR_InvertIn,
        output wire Pa_Ophd // >
    );

    // wire [3:0] notXPT = ~XPT;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _t00xx;
    wire _t01xx;

    DECODER_2bit_decoder t_ddxx( // 5
        .notEnable(_not_enable),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out00(_t00xx),
        .out01(_t01xx),
        .out1x(_decodedXPT[8])
    );

    wire _nott00xx = _t00xx ~| _t00xx;

    assign _decodedXPT[3] = _nott00xx ~| notXPT[0];

    wire _nott01xx = _t01xx ~| _t01xx;

    wire _t4or5;
    wire _t6or7;

    DECODER_2bit_decoder t_01dd( // 8
        .notEnable(_nott01xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7]),
        .out0x(_t4or5),
        .out1x(_t6or7)
    );

    // 3~8

    assign PI_SelectAd_OPOPold = (_decodedXPT[3] |_t01xx | _decodedXPT[8]); // 4

    // 3or6

    assign PC_R0 = (_decodedXPT[3] | _decodedXPT[6]); // 2

    // 4or7

    assign PC_R1 = (_decodedXPT[4] | _decodedXPT[7]); // 2

    // 5or8

    assign PC_R2 = (_decodedXPT[5] | _decodedXPT[8]); // 2

    // 5

    assign PR_Write_L = _decodedXPT[5];

    // 6~8

    assign PI_SelectAdt1 = (_t6or7 | _decodedXPT[8]); // 2

    // 8

    assign PR_Reset_XPT = _decodedXPT[8];
    assign P2_Set_CM1 = _decodedXPT[8];
    assign P2_Reset_ITABLE = _decodedXPT[8];
    assign PR_Write_H = _decodedXPT[8];
    assign PR_InvertIn = _decodedXPT[8];
    assign Pa_Ophd = _decodedXPT[8];

endmodule
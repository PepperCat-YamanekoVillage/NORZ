// LD (nn),HL
// 19(34)
module DECODER_I_0000001(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire [8:0] _decodedXPT,
        output wire P2_Set_CMR,
        output wire P2_Set_ILDlnnlHL_1,
        output wire PR_Reset_XPT,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_L,
        output wire PI_SelectDt_H, // <
        output wire PI_SelectAdt1, // >
        output wire PI_SelectAd_OPOPold,
        output wire P2_Set_CM1, // <
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd // >
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _0;
    wire _1;

    DECODER_1bit_decoder d_0000001d(
        .notEnable(_not_enable),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(_0),
        .out1(_1)
    );

    //
    // XPT
    //

    wire _not1 = _1 ~| _1;

    wire _t00xx;
    wire _t01xx;

    DECODER_2bit_decoder t_ddxx( // 5
        .notEnable(_not1),
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
        .out0x(_t4or5),
        .out1x(_t6or7),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7])
    );

    //
    // _0
    //

    assign P2_Set_CMR = _0;
    assign P2_Set_ILDlnnlHL_1 = _0;

    // _0or_1_8

    assign PR_Reset_XPT = (_0 | _decodedXPT[8]); // 2

    //
    // _1
    //

    // 3or6

    assign PC_W0 = (_decodedXPT[3] | _decodedXPT[6]); // 2

    // 4or7

    assign PC_W1 = (_decodedXPT[4] | _decodedXPT[7]); // 2

    // 5or8

    assign PC_W2 = (_decodedXPT[5] | _decodedXPT[8]); // 2

    // 3~5

    assign PI_SelectDt_L = (_decodedXPT[3] | _t4or5); // 2

    // 6~8

    assign PI_SelectDt_H = (_decodedXPT[8] | _t6or7); // 2
    assign PI_SelectAdt1 = PI_SelectDt_H;

    // 3~8

    assign PI_SelectAd_OPOPold = (PI_SelectDt_L | PI_SelectDt_H); // 2

    // 8

    assign P2_Set_CM1 = _decodedXPT[8];
    assign P2_Reset_ITABLE = _decodedXPT[8];
    assign Pa_Ophd = _decodedXPT[8];

endmodule

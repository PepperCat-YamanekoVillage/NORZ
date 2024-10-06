// LD (nn),dd
// 32(63)
module DECODER_I_10000(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire [8:0] _decodedXPT,
        output wire P2_Set_CMR,
        output wire P2_Set_ILDlnnldd_BC_1,
        output wire P2_Set_ILDlnnldd_DE_1,
        output wire P2_Set_ILDlnnldd_HL_1,
        output wire P2_Set_ILDlnnldd_SP_1,
        output wire PR_Reset_XPT,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_C,
        output wire PI_SelectDt_E,
        output wire PI_SelectDt_L,
        output wire PI_SelectDt_SP_low,
        output wire PI_SelectDt_B,
        output wire PI_SelectDt_D,
        output wire PI_SelectDt_H,
        output wire PI_SelectDt_SP_high,
        output wire PI_SelectAdt1,
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

    wire _100000xx;
    wire _100001xx;

    DECODER_1bit_decoder d_10000dxx(
        .notEnable(_not_enable),
        .In(ITABLE[2]),
        .notIn(notITABLE[2]),
        .out0(_100000xx),
        .out1(_100001xx)
    );

    wire _not100000xx = _100000xx ~| _100000xx;
    wire _not100001xx = _100001xx ~| _100001xx;

    wire _10000000; // _0
    wire _10000001;
    wire _10000010;
    wire _10000011;

    DECODER_2bit_decoder d_100000dd( // 8
        .notEnable(_not100000xx),
        .In(ITABLE[1:0]),
        .notIn(notITABLE[1:0]),
        .out00(_10000000),
        .out01(_10000001),
        .out10(_10000010),
        .out11(_10000011)
    );

    wire _10000100; // _1
    wire _10000101; 
    wire _10000110;
    wire _10000111;

    DECODER_2bit_decoder d_100001dd( // 8
        .notEnable(_not100001xx),
        .In(ITABLE[1:0]),
        .notIn(notITABLE[1:0]),
        .out00(_10000100),
        .out01(_10000101),
        .out10(_10000110),
        .out11(_10000111)
    );

    //
    // XPT
    //

    wire _t00xx;
    wire _t01xx;

    DECODER_2bit_decoder t_ddxx( // 5
        .notEnable(_not100001xx),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out00(_t00xx),
        .out01(_t01xx),
        .out1x(_decodedXPT[8])
    );

    wire _not_t00xx = _t00xx ~| _t00xx;

    assign _decodedXPT[3] = _not_t00xx ~| notXPT[0];

    wire _4or5;
    wire _6or7;

    wire _nott01xx = _t01xx ~| _t01xx;

    DECODER_2bit_decoder t_01dd( // 8
        .notEnable(_nott01xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out0x(_4or5),
        .out1x(_6or7),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7])
    );

    //
    // _0
    // 

    assign P2_Set_CMR = _100000xx;

    assign P2_Set_ILDlnnldd_BC_1 = _10000000;
    assign P2_Set_ILDlnnldd_DE_1 = _10000001;
    assign P2_Set_ILDlnnldd_HL_1 = _10000010;
    assign P2_Set_ILDlnnldd_SP_1 = _10000011;

    // _0_2or_1_8

    wire _not_0_2or_1_8 = _100000xx ~| _decodedXPT[8];
    wire _0_2or_1_8 = _not_0_2or_1_8 ~| _not_0_2or_1_8;

    assign PR_Reset_XPT = _0_2or_1_8;

    //
    // _1
    //

    wire _not10000100 = _10000100 ~| _10000100;
    wire _not10000101 = _10000101 ~| _10000101;
    wire _not10000110 = _10000110 ~| _10000110;
    wire _not10000111 = _10000111 ~| _10000111;

    wire _4or5;
    wire _6or7;

    assign PC_W0 = (_decodedXPT[3] | _decodedXPT[6]); // 2
    assign PC_W1 = (_decodedXPT[4] | _decodedXPT[7]); // 2
    assign PC_W2 = (_decodedXPT[5] | _decodedXPT[8]); // 2

    // 3~5

    wire _not3_5 = _decodedXPT[3] ~| _4or5;

    assign PI_SelectDt_C = _not3_5 ~| _not10000100;
    assign PI_SelectDt_E = _not3_5 ~| _not10000101;
    assign PI_SelectDt_L = _not3_5 ~| _not10000110;
    assign PI_SelectDt_SP_low = _not3_5 ~| _not10000111;

    // 6~8

    wire _not6_8 = _decodedXPT[8] ~| _6or7;

    assign PI_SelectDt_B = _not6_8 ~| _not10000100;
    assign PI_SelectDt_D = _not6_8 ~| _not10000101;
    assign PI_SelectDt_H = _not6_8 ~| _not10000110;
    assign PI_SelectDt_SP_high = _not6_8 ~| _not10000111;

    wire _6_8 = _not6_8 ~| _not6_8;

    assign PI_SelectAdt1 = _6_8;

    // 3~8

    wire _3_5 = _not3_5 ~| _not3_5;

    assign PI_SelectAd_OPOPold = (_3_5 | _6_8); // 2

    // 8

    assign P2_Set_CM1 = _decodedXPT[8];
    assign P2_Reset_ITABLE = _decodedXPT[8];
    assign Pa_Ophd = _decodedXPT[8];


endmodule
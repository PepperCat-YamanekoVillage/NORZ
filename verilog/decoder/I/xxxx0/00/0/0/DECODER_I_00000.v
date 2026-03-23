// 25(97)
module DECODER_I_00000(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire not_is00000000,
        output wire PI_SelectAd_HL,
        output wire PI_SelectDt_OP,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1, // <
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd, // >
        output wire P2_Set_CMR,
        output wire P2_Set_ILDlnnlHL_1,
        output wire PI_SelectDt_L,
        output wire PI_SelectDt_H,
        output wire PI_SelectAdt1,
        output wire PI_SelectAd_OPOPold,
        output wire P2_Set_ILDAlnnl_1,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Write_A,
        output wire PR_InvertIn,
        output wire P2_Set_CMA,
        output wire P2_Set_IJPnn_1,
        output wire PA_Select_OPxx_low,
        output wire PA_NOP,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _0000000x;
    wire _0000001x;
    wire _0000010x;
    wire _0000011x;

    DECODER_2bit_decoder d_00000ddx( // 8
        .notEnable(_not_enable),
        .In(ITABLE[2:1]),
        .notIn(notITABLE[2:1]),
        .out00(_0000000x),
        .out01(_0000001x),
        .out10(_0000010x),
        .out11(_0000011x)
    );

    wire _not0000000x = _0000000x ~| _0000000x;

    wire _00000000;
    wire _00000001;

    DECODER_1bit_decoder d_0000000d(
        .notEnable(_not0000000x),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(_00000000),
        .out1(_00000001)
    );

    assign not_is00000000 = _00000000 ~| _00000000;

    wire _PC_W0_001;
    wire _PC_W1_001;
    wire _PC_W2_001;
    wire _PR_Reset_XPT_001; // <
    wire _P2_Set_CM1_001;
    wire _P2_Reset_ITABLE_001;
    wire _Pa_Ophd_001; // >

    DECODER_I_00000001 d00000001(
        .enable(_00000001),
        .XPT(XPT),
        .notXPT(notXPT),
        .PI_SelectAd_HL(PI_SelectAd_HL),
        .PI_SelectDt_OP(PI_SelectDt_OP),
        .PC_W0(_PC_W0_001),
        .PC_W1(_PC_W1_001),
        .PC_W2(_PC_W2_001),
        .PR_Reset_XPT(_PR_Reset_XPT_001), // <
        .P2_Set_CM1(_P2_Set_CM1_001),
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_001),
        .Pa_Ophd(_Pa_Ophd_001) // >
    );

    wire _P2_Set_CMR_01x;
    wire _PR_Reset_XPT_01x;
    wire _PC_W0_01x;
    wire _PC_W1_01x;
    wire _PC_W2_01x;
    wire _PI_SelectAd_OPOPold_01x;
    wire _P2_Set_CM1_01x; // <
    wire _P2_Reset_ITABLE_01x;
    wire _Pa_Ophd_01x; // >

    DECODER_I_0000001 d0000001(
        .enable(_0000001x),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .P2_Set_CMR(_P2_Set_CMR_01x),
        .P2_Set_ILDlnnlHL_1(P2_Set_ILDlnnlHL_1),
        .PR_Reset_XPT(_PR_Reset_XPT_01x),
        .PC_W0(_PC_W0_01x),
        .PC_W1(_PC_W1_01x),
        .PC_W2(_PC_W2_01x),
        .PI_SelectDt_L(PI_SelectDt_L),
        .PI_SelectDt_H(PI_SelectDt_H), // <
        .PI_SelectAdt1(PI_SelectAdt1), // >
        .PI_SelectAd_OPOPold(_PI_SelectAd_OPOPold_01x),
        .P2_Set_CM1(_P2_Set_CM1_01x), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_01x),
        .Pa_Ophd(_Pa_Ophd_01x) // >
    );

    wire _P2_Set_CMR_10x;
    wire _PR_Reset_XPT_10x;
    wire _PI_SelectAd_OPOPold_10x;
    wire _P2_Set_CM1_10x; // <
    wire _P2_Reset_ITABLE_10x;
    wire _PR_InvertIn_10x;
    wire _Pa_Ophd_10x; // >

    DECODER_I_0000010 d0000010(
        .enable(_0000010x),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .P2_Set_CMR(_P2_Set_CMR_10x),
        .P2_Set_ILDAlnnl_1(P2_Set_ILDAlnnl_1),
        .PR_Reset_XPT(_PR_Reset_XPT_10x),
        .PI_SelectAd_OPOPold(_PI_SelectAd_OPOPold_10x),
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .P2_Set_CM1(_P2_Set_CM1_10x), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_10x),
        .PR_Write_A(PR_Write_A),
        .PR_InvertIn(_PR_InvertIn_10x),
        .Pa_Ophd(_Pa_Ophd_10x) // >
    );

    wire _PR_Reset_XPT_11x;
    wire _P2_Set_CM1_11x; // <
    wire _P2_Reset_ITABLE_11x;
    wire _PR_InvertIn_11x;
    wire _Pa_Ophd_11x; // >

    DECODER_I_0000011 d0000011(
        .enable(_0000011x),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PR_Reset_XPT(_PR_Reset_XPT_11x),
        .P2_Set_CMA(P2_Set_CMA),
        .P2_Set_IJPnn_1(P2_Set_IJPnn_1),
        .P2_Set_CM1(_P2_Set_CM1_11x), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_11x),
        .PA_Select_OPxx_low(PA_Select_OPxx_low),
        .PA_NOP(PA_NOP),
        .PR_Write_PC_high(PR_Write_PC_high),
        .PR_Write_PC_low(PR_Write_PC_low),
        .PR_InvertIn(_PR_InvertIn_11x),
        .Pa_Ophd(_Pa_Ophd_11x) // >
    );

    assign PC_W0 = (_PC_W0_001 | _PC_W0_01x); // 2
    assign PC_W1 = (_PC_W1_001 | _PC_W1_01x); // 2
    assign PC_W2 = (_PC_W2_001 | _PC_W2_01x); // 2

    assign P2_Set_CMR = (_P2_Set_CMR_01x | _P2_Set_CMR_10x); // 2

    assign PI_SelectAd_OPOPold = (_PI_SelectAd_OPOPold_01x | _PI_SelectAd_OPOPold_10x); // 2

    assign PR_Reset_XPT = (_PR_Reset_XPT_001 | _PR_Reset_XPT_01x | _PR_Reset_XPT_10x | _PR_Reset_XPT_11x); // 6

    assign PR_InvertIn = (_PR_InvertIn_10x | _PR_InvertIn_11x); // 2

    assign P2_Set_CM1 = (PR_InvertIn | _P2_Set_CM1_001 | _P2_Set_CM1_01x); // 4
    assign P2_Reset_ITABLE = P2_Set_CM1;
    assign Pa_Ophd = P2_Set_CM1;

endmodule

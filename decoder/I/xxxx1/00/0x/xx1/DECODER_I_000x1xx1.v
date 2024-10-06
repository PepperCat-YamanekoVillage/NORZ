// 25(153)
module DECODER_I_000x1xx1(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire PI_SelectAd_OPOPold,
        output wire PI_SelectDt_A,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd, // >
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Write_L,
        output wire PI_SelectAdt1,
        output wire PR_Write_H,
        output wire PR_InvertIn,
        output wire PR_Write_IX_high,
        output wire PR_Write_IY_high,
        output wire PR_Dec_SP,
        output wire PI_SelectDt_PC_high,
        output wire PI_SelectAd_SP,
        output wire PI_SelectDt_PC_low,
        output wire PA_Select_OPOPold_low,
        output wire PA_NOP,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low,
        output wire PR_Write_IX_low,
        output wire PR_Write_IY_low
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _00001xx1;
    wire _00011xx1;

    DECODER_1bit_decoder d_000d1xx1(
        .notEnable(_not_enable),
        .In(ITABLE[4]),
        .notIn(notITABLE[4]),
        .out0(_00001xx1),
        .out1(_00011xx1),
    );

    wire _PI_SelectAd_OPOPold_0;
    wire _PC_W0_0;
    wire _PC_W1_0;
    wire _PC_W2_0;
    wire _PR_Reset_XPT_0; // <
    wire _P2_Set_CM1_0;
    wire _P2_Reset_ITABLE_0;
    wire _Pa_Ophd_0; // >
    wire _PC_R0_0;
    wire _PC_R1_0;
    wire _PC_R2_0;
    wire _PI_SelectAdt1_0;
    wire _PR_InvertIn_0;
    wire _PR_Write_IX_high_0;
    wire _PR_Write_IY_high_0;

    DECODER_I_00001xx1 d00001xx1(
        .enable(_00001xx1),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PI_SelectAd_OPOPold(_PI_SelectAd_OPOPold_0),
        .PI_SelectDt_A(PI_SelectDt_A),
        .PC_W0(_PC_W0_0),
        .PC_W1(_PC_W1_0),
        .PC_W2(_PC_W2_0),
        .PR_Reset_XPT(_PR_Reset_XPT_0), // <
        .P2_Set_CM1(_P2_Set_CM1_0),
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_0),
        .Pa_Ophd(_Pa_Ophd_0), // >
        .PC_R0(_PC_R0_0),
        .PC_R1(_PC_R1_0),
        .PC_R2(_PC_R2_0),
        .PR_Write_L(PR_Write_L),
        .PI_SelectAdt1(_PI_SelectAdt1_0),
        .PR_Write_H(PR_Write_H),
        .PR_InvertIn(_PR_InvertIn_0),
        .PR_Write_IX_high(_PR_Write_IX_high_0),
        .PR_Write_IY_high(_PR_Write_IY_high_0)
    );

    wire _PI_SelectAd_OPOPold_1;
    wire _PC_W0_1;
    wire _PC_W1_1;
    wire _PC_W2_1;
    wire _PR_Reset_XPT_1; // <
    wire _P2_Set_CM1_1;
    wire _P2_Reset_ITABLE_1;
    wire _Pa_Ophd_1; // >
    wire _PC_R0_1;
    wire _PC_R1_1;
    wire _PC_R2_1;
    wire _PI_SelectAdt1_1;
    wire _PR_InvertIn_1;
    wire _PR_Write_IX_high_1;
    wire _PR_Write_IY_high_1;

    DECODER_I_00011xx1 d00011xx1(
        .enable(_00011xx1),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PR_Dec_SP(PR_Dec_SP),
        .PI_SelectDt_PC_high(PI_SelectDt_PC_high),
        .PI_SelectAd_SP(PI_SelectAd_SP),
        .PC_W0(_PC_W0_1),
        .PC_W1(_PC_W1_1),
        .PC_W2(_PC_W2_1),
        .PI_SelectDt_PC_low(PI_SelectDt_PC_low),
        .PR_Reset_XPT(_PR_Reset_XPT_1), // <
        .P2_Set_CM1(_P2_Set_CM1_1),
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_1),
        .Pa_Ophd(_Pa_Ophd_1), // >
        .PA_Select_OPOPold_low(PA_Select_OPOPold_low),
        .PA_NOP(PA_NOP),
        .PR_Write_PC_high(PR_Write_PC_high),
        .PR_Write_PC_low(PR_Write_PC_low),
        .PI_SelectAd_OPOPold(_PI_SelectAd_OPOPold_1),
        .PC_R0(_PC_R0_1),
        .PC_R1(_PC_R1_1),
        .PC_R2(_PC_R2_1),
        .PR_Write_IX_low(PR_Write_IX_low),
        .PR_Write_IY_low(PR_Write_IY_low),
        .PR_Write_IX_high(_PR_Write_IX_high_1),
        .PR_Write_IY_high(_PR_Write_IY_high_1),
        .PI_SelectAdt1(_PI_SelectAdt1_1),
        .PR_InvertIn(_PR_InvertIn_1)
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2
    assign P2_Set_CM1 = PR_Reset_XPT;
    assign P2_Reset_ITABLE = PR_Reset_XPT;
    assign Pa_Ophd = PR_Reset_XPT;

    assign PI_SelectAd_OPOPold = (_PI_SelectAd_OPOPold_0 | _PI_SelectAd_OPOPold_1); // 2
    assign PC_W0 = (_PC_W0_0 | _PC_W0_1); // 2
    assign PC_W1 = (_PC_W1_0 | _PC_W1_1); // 2
    assign PC_W2 = (_PC_W2_0 | _PC_W2_1); // 2
    assign PC_R0 = (_PC_R0_0 | _PC_R0_1); // 2
    assign PC_R1 = (_PC_R1_0 | _PC_R1_1); // 2
    assign PC_R2 = (_PC_R2_0 | _PC_R2_1); // 2
    assign PI_SelectAdt1 = (_PI_SelectAdt1_0 | _PI_SelectAdt1_1); // 2
    assign PR_InvertIn = (_PR_InvertIn_0 | _PR_InvertIn_1); // 2
    assign PR_Write_IX_high = (_PR_Write_IX_high_0 | _PR_Write_IX_high_1); // 2
    assign PR_Write_IY_high = (_PR_Write_IY_high_0 | _PR_Write_IY_high_1); // 2

endmodule
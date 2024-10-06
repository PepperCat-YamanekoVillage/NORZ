// 3(72)
module DECODER_I_00011xx1(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire PR_Dec_SP,
        output wire PI_SelectDt_PC_high,
        output wire PI_SelectAd_SP,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_PC_low,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd, // >
        output wire PA_Select_OPOPold_low,
        output wire PA_NOP,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low,
        output wire PI_SelectAd_OPOPold,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Write_IX_low,
        output wire PR_Write_IY_low,
        output wire PR_Write_IX_high,
        output wire PR_Write_IY_high,
        output wire PI_SelectAdt1,
        output wire PR_InvertIn
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _00011x01;
    wire _00011x11;

    DECODER_1bit_decoder d_00011xd1(
        .notEnable(_not_enable),
        .In(ITABLE[1]),
        .notIn(notITABLE[1]),
        .out0(_00011x01),
        .out1(_00011x11),
    );

    wire _PR_Reset_XPT_0; // <
    wire _P2_Set_CM1_0;
    wire _P2_Reset_ITABLE_0;
    wire _Pa_Ophd_0; // >

    DECODER_I_00011101 d00011101(
        .enable(_00011x01),
        .XPT(XPT),
        .notXPT(notXPT),
        .PR_Dec_SP(PR_Dec_SP),
        .PI_SelectDt_PC_high(PI_SelectDt_PC_high),
        .PI_SelectAd_SP(PI_SelectAd_SP),
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .PI_SelectDt_PC_low(PI_SelectDt_PC_low),
        .PR_Reset_XPT(_PR_Reset_XPT_0), // <
        .P2_Set_CM1(_P2_Set_CM1_0),
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_0),
        .PA_Select_OPOPold_low(PA_Select_OPOPold_low),
        .PA_NOP(PA_NOP),
        .PR_Write_PC_high(PR_Write_PC_high),
        .PR_Write_PC_low(PR_Write_PC_low),
        .Pa_Ophd(_Pa_Ophd_0) // >
    );

    wire _PR_Reset_XPT_1; // <
    wire _P2_Set_CM1_1;
    wire _P2_Reset_ITABLE_1;
    wire _Pa_Ophd_1; // >

    DECODER_I_00011x11 d00011x11(
        .enable(_00011x11),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PI_SelectAd_OPOPold(PI_SelectAd_OPOPold),
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PR_Write_IX_low(PR_Write_IX_low),
        .PR_Write_IY_low(PR_Write_IY_low),
        .PR_Write_IX_high(PR_Write_IX_high),
        .PR_Write_IY_high(PR_Write_IY_high),
        .PI_SelectAdt1(PI_SelectAdt1),
        .PR_Reset_XPT(_PR_Reset_XPT_1), // <
        .P2_Set_CM1(_P2_Set_CM1_1),
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_1),
        .PR_InvertIn(PR_InvertIn),
        .Pa_Ophd(_Pa_Ophd_1) // >
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_0); // 2
    assign P2_Set_CM1 = PR_Reset_XPT;
    assign P2_Reset_ITABLE = PR_Reset_XPT;
    assign Pa_Ophd = PR_Reset_XPT;

endmodule
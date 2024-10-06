// 7(180)
module DECODER_I_000x1(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire PR_Reset_XPT,
        output wire P2_Set_CMR,
        output wire PR_Write_IX_low,
        output wire PR_Write_IY_low,
        output wire P2_Set_ILDlnnlA_1,
        output wire P2_Set_ILDIXnn_1,
        output wire P2_Set_ILDHLlnnl_1,
        output wire P2_Set_ILDIYnn_1,
        output wire P2_Set_ILDIXlnnl_1,
        output wire P2_Set_ILDIYlnnl_1,
        output wire P2_Set_ICALLnn_1,
        output wire PI_SelectAd_OPOPold,
        output wire PI_SelectDt_A,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire P2_Set_CM1, // <
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
        output wire PR_Write_PC_low
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _000x1xx0;
    wire _000x1xx1;

    DECODER_1bit_decoder d_000x1xxd(
        .notEnable(_not_enable),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(_000x1xx0),
        .out1(_000x1xx1),
    );

    wire _PR_Reset_XPT_0;
    wire _PR_Write_IX_low_0;
    wire _PR_Write_IY_low_0;

    DECODER_I_000x1xx0 d000x1xx0(
        .enable(_000x1xx0),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PR_Reset_XPT(_PR_Reset_XPT_0),
        .P2_Set_CMR(P2_Set_CMR),
        .PR_Write_IX_low(_PR_Write_IX_low_0),
        .PR_Write_IY_low(_PR_Write_IY_low_0),
        .P2_Set_ILDlnnlA_1(P2_Set_ILDlnnlA_1),
        .P2_Set_ILDIXnn_1(P2_Set_ILDIXnn_1),
        .P2_Set_ILDHLlnnl_1(P2_Set_ILDHLlnnl_1),
        .P2_Set_ILDIYnn_1(P2_Set_ILDIYnn_1),
        .P2_Set_ILDIXlnnl_1(P2_Set_ILDIXlnnl_1),
        .P2_Set_ILDIYlnnl_1(P2_Set_ILDIYlnnl_1),
        .P2_Set_ICALLnn_1(P2_Set_ICALLnn_1)
    );

    wire _PR_Reset_XPT_1;
    wire _PR_Write_IX_low_1;
    wire _PR_Write_IY_low_1;

    DECODER_I_000x1xx1 d000x1xx1(
        .enable(_000x1xx1),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PI_SelectAd_OPOPold(PI_SelectAd_OPOPold),
        .PI_SelectDt_A(PI_SelectDt_A),
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .PR_Reset_XPT(_PR_Reset_XPT_1), // <
        .P2_Set_CM1(P2_Set_CM1),
        .P2_Reset_ITABLE(P2_Reset_ITABLE),
        .Pa_Ophd(Pa_Ophd), // >
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PR_Write_L(PR_Write_L),
        .PI_SelectAdt1(PI_SelectAdt1),
        .PR_Write_H(PR_Write_H),
        .PR_InvertIn(PR_InvertIn),
        .PR_Write_IX_high(PR_Write_IX_high),
        .PR_Write_IY_high(PR_Write_IY_high),
        .PR_Dec_SP(PR_Dec_SP),
        .PI_SelectDt_PC_high(PI_SelectDt_PC_high),
        .PI_SelectAd_SP(PI_SelectAd_SP),
        .PI_SelectDt_PC_low(PI_SelectDt_PC_low),
        .PA_Select_OPOPold_low(PA_Select_OPOPold_low),
        .PA_NOP(PA_NOP),
        .PR_Write_PC_high(PR_Write_PC_high),
        .PR_Write_PC_low(PR_Write_PC_low),
        .PR_Write_IX_low(_PR_Write_IX_low_1),
        .PR_Write_IY_low(_PR_Write_IY_low_1)
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2
    assign PR_Write_IX_low = (_PR_Write_IX_low_0 | _PR_Write_IX_low_1); // 2
    assign PR_Write_IY_low = (_PR_Write_IY_low_0 | _PR_Write_IY_low_1); // 2

endmodule
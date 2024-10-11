// 32(340)
module DECODER_I_00xx1(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        input wire Flag_C,
        input wire Flag_Z,
        input wire notIsResultLow0,
        input wire OP7,
        input wire notOP7,
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
        output wire PR_Write_PC_low,
        output wire PC_I0,
        output wire PC_I1,
        output wire PC_I2,
        output wire PC_I3,
        output wire PC_O0,
        output wire PC_O1,
        output wire PC_O2,
        output wire PC_O3,
        output wire PR_Write_A,
        output wire PI_SelectAd_AOP,
        output wire P2_Set_ILDlnnlIX_1,
        output wire P2_Set_ILDlnnlIY_1,
        output wire PI_SelectDt_IX_low,
        output wire PI_SelectDt_IY_low,
        output wire PI_SelectDt_IX_high,
        output wire PI_SelectDt_IY_high,
        output wire PA_Select_PC_high,
        output wire PA_ADD,
        output wire PA_Select_OP_low,
        output wire PA_Select_0xffOP_low,
        output wire PA_Select_B_high,
        output wire PA_Select_0x1_low,
        output wire PA_SUB,
        output wire PR_Write_B
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _000x1xxx;
    wire _001x1xxx;

    DECODER_1bit_decoder d_00dx1xxx(
        .notEnable(_not_enable),
        .In(ITABLE[5]),
        .notIn(notITABLE[5]),
        .out0(_000x1xxx),
        .out1(_001x1xxx)
    );

    wire _not001x1xxx = _001x1xxx ~| _001x1xxx;

    wire _00101xxx;
    wire _00111xxx;
    
    DECODER_1bit_decoder d_001d1xxx(
        .notEnable(_not001x1xxx),
        .In(ITABLE[4]),
        .notIn(notITABLE[4]),
        .out0(_00101xxx),
        .out1(_00111xxx)
    );

    wire _PR_Reset_XPT_0x;
    wire _P2_Set_CMR_0x;
    wire _PI_SelectAd_OPOPold_0x;
    wire _PI_SelectDt_A_0x;
    wire _PC_W0_0x;
    wire _PC_W1_0x;
    wire _PC_W2_0x;
    wire _P2_Set_CM1_0x; // <
    wire _P2_Reset_ITABLE_0x;
    wire _Pa_Ophd_0x; // >
    wire _PI_SelectAdt1_0x;
    wire _PR_InvertIn_0x;
    wire _PR_Write_PC_high_0x;
    wire _PR_Write_PC_low_0x;

    DECODER_I_000x1 d000x1(
        .enable(_000x1xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PR_Reset_XPT(_PR_Reset_XPT_0x),
        .P2_Set_CMR(_P2_Set_CMR_0x),
        .PR_Write_IX_low(PR_Write_IX_low),
        .PR_Write_IY_low(PR_Write_IY_low),
        .P2_Set_ILDlnnlA_1(P2_Set_ILDlnnlA_1),
        .P2_Set_ILDIXnn_1(P2_Set_ILDIXnn_1),
        .P2_Set_ILDHLlnnl_1(P2_Set_ILDHLlnnl_1),
        .P2_Set_ILDIYnn_1(P2_Set_ILDIYnn_1),
        .P2_Set_ILDIXlnnl_1(P2_Set_ILDIXlnnl_1),
        .P2_Set_ILDIYlnnl_1(P2_Set_ILDIYlnnl_1),
        .P2_Set_ICALLnn_1(P2_Set_ICALLnn_1),
        .PI_SelectAd_OPOPold(_PI_SelectAd_OPOPold_0x),
        .PI_SelectDt_A(_PI_SelectDt_A_0x),
        .PC_W0(_PC_W0_0x),
        .PC_W1(_PC_W1_0x),
        .PC_W2(_PC_W2_0x),
        .P2_Set_CM1(_P2_Set_CM1_0x), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_0x),
        .Pa_Ophd(_Pa_Ophd_0x), // >
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PR_Write_L(PR_Write_L),
        .PI_SelectAdt1(_PI_SelectAdt1_0x),
        .PR_Write_H(PR_Write_H),
        .PR_InvertIn(_PR_InvertIn_0x),
        .PR_Write_IX_high(PR_Write_IX_high),
        .PR_Write_IY_high(PR_Write_IY_high),
        .PR_Dec_SP(PR_Dec_SP),
        .PI_SelectDt_PC_high(PI_SelectDt_PC_high),
        .PI_SelectAd_SP(PI_SelectAd_SP),
        .PI_SelectDt_PC_low(PI_SelectDt_PC_low),
        .PA_Select_OPOPold_low(PA_Select_OPOPold_low),
        .PA_NOP(PA_NOP),
        .PR_Write_PC_high(_PR_Write_PC_high_0x),
        .PR_Write_PC_low(_PR_Write_PC_low_0x)
    );

    wire _PR_InvertIn_10;
    wire _PR_Reset_XPT_10;
    wire _P2_Set_CM1_10; // <
    wire _P2_Reset_ITABLE_10;
    wire _Pa_Ophd_10; // >
    wire _PI_SelectDt_A_10;
    wire _P2_Set_CMR_10;
    wire _PI_SelectAdt1_10;
    wire _PI_SelectAd_OPOPold_10;
    wire _PC_W0_10;
    wire _PC_W1_10;
    wire _PC_W2_10;

    DECODER_I_00101 d00101(
        .enable(_00101xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PC_I0(PC_I0),
        .PC_I1(PC_I1),
        .PC_I2(PC_I2),
        .PC_I3(PC_I3),
        .PC_O0(PC_O0),
        .PC_O1(PC_O1),
        .PC_O2(PC_O2),
        .PC_O3(PC_O3),
        .PR_Write_A(PR_Write_A),
        .PR_InvertIn(_PR_InvertIn_10),
        .PI_SelectAd_AOP(PI_SelectAd_AOP),
        .PR_Reset_XPT(_PR_Reset_XPT_10),
        .P2_Set_CM1(_P2_Set_CM1_10), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_10),
        .Pa_Ophd(_Pa_Ophd_10), // >
        .PI_SelectDt_A(_PI_SelectDt_A_10),
        .P2_Set_ILDlnnlIX_1(P2_Set_ILDlnnlIX_1),
        .P2_Set_ILDlnnlIY_1(P2_Set_ILDlnnlIY_1),
        .P2_Set_CMR(_P2_Set_CMR_10),
        .PI_SelectDt_IX_low(PI_SelectDt_IX_low),
        .PI_SelectDt_IY_low(PI_SelectDt_IY_low),
        .PI_SelectDt_IX_high(PI_SelectDt_IX_high),
        .PI_SelectDt_IY_high(PI_SelectDt_IY_high),
        .PI_SelectAdt1(_PI_SelectAdt1_10),
        .PI_SelectAd_OPOPold(_PI_SelectAd_OPOPold_10),
        .PC_W0(_PC_W0_10),
        .PC_W1(_PC_W1_10),
        .PC_W2(_PC_W2_10)
    );

    wire _PR_Reset_XPT_11;
    wire _P2_Set_CM1_11; // <
    wire _P2_Reset_ITABLE_11;
    wire _Pa_Ophd_11; // >
    wire _PR_Write_PC_high_11;
    wire _PR_Write_PC_low_11;
    wire _PR_InvertIn_11;

    DECODER_I_00111 d00111(
        .enable(_00111xxx),
        .Flag_C(Flag_C),
        .Flag_Z(Flag_Z),
        .notIsResultLow0(notIsResultLow0),
        .OP7(OP7),
        .notOP7(notOP7),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PR_Reset_XPT(_PR_Reset_XPT_11), // <
        .P2_Set_CM1(_P2_Set_CM1_11),
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_11),
        .Pa_Ophd(_Pa_Ophd_11), // >
        .PA_Select_PC_high(PA_Select_PC_high), // <
        .PR_Write_PC_high(_PR_Write_PC_high_11),
        .PR_Write_PC_low(_PR_Write_PC_low_11),
        .PA_ADD(PA_ADD), // >
        .PA_Select_OP_low(PA_Select_OP_low),
        .PA_Select_0xffOP_low(PA_Select_0xffOP_low),
        .PA_Select_B_high(PA_Select_B_high), // <
        .PA_Select_0x1_low(PA_Select_0x1_low),
        .PA_SUB(PA_SUB),
        .PR_Write_B(PR_Write_B),
        .PR_InvertIn(_PR_InvertIn_11) // >
    );

    assign P2_Set_CM1 = (_P2_Set_CM1_0x | _P2_Set_CM1_10 | _P2_Set_CM1_11); // 4
    assign P2_Reset_ITABLE = P2_Set_CM1;
    assign Pa_Ophd = P2_Set_CM1;

    assign PR_Reset_XPT = (_PR_Reset_XPT_0x | _PR_Reset_XPT_10 | _PR_Reset_XPT_11); // 4
    assign PR_InvertIn = (_PR_InvertIn_0x | _PR_InvertIn_10 | _PR_InvertIn_11); // 4

    assign P2_Set_CMR = (_P2_Set_CMR_0x | _P2_Set_CMR_10); // 2
    assign PI_SelectAd_OPOPold = (_PI_SelectAd_OPOPold_0x | _PI_SelectAd_OPOPold_10); // 2
    assign PI_SelectDt_A = (_PI_SelectDt_A_0x | _PI_SelectDt_A_10); // 2
    assign PC_W0 = (_PC_W0_0x | _PC_W0_10); // 2
    assign PC_W1 = (_PC_W1_0x | _PC_W1_10); // 2
    assign PC_W2 = (_PC_W2_0x | _PC_W2_10); // 2
    assign PI_SelectAdt1 = (_PI_SelectAdt1_0x | _PI_SelectAdt1_10); // 2
    assign PR_Write_PC_high = (_PR_Write_PC_high_0x | _PR_Write_PC_high_11); // 2
    assign PR_Write_PC_low = (_PR_Write_PC_low_0x | _PR_Write_PC_low_11); // 2

endmodule
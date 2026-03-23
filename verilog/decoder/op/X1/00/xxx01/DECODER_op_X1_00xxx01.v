// 5(58)
module DECODER_op_X1_00xxx01(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1, // <
        output wire Pa_Ophd, // >
        output wire PI_SelectAd_BC,
        output wire PI_SelectAd_DE,
        output wire PI_SelectDt_A,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PR_Write_A, // <
        output wire PR_InvertIn, // >
        output wire P2_Set_CMR,
        output wire P2_Set_ILDlnnlHL_0,
        output wire P2_Set_ILDHLlnnl_0,
        output wire P2_Set_ILDlnnlA_0,
        output wire P2_Set_ILDAlnnl_0,
        output wire PA_Select_0x1_low,
        output wire PA_ADD,
        output wire PA_SUB,
        output wire PA_Select_BC_high, // <
        output wire PR_Write_B,
        output wire PR_Write_C, // >
        output wire PA_Select_DE_high, // <
        output wire PR_Write_D,
        output wire PR_Write_E, // >
        output wire PA_Select_HL_high, // <
        output wire PR_Write_H,
        output wire PR_Write_L, // >
        output wire PA_Select_SP_high, // <
        output wire PR_Write_SP_high,
        output wire PR_Write_SP_low // >
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decooder
    //

    wire _not_enable = enable ~| enable;

    wire _00xxx010;
    wire _00xxx011;

    DECODER_1bit_decoder d_00xxx01d(
        .notEnable(_not_enable),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_00xxx010),
        .out1(_00xxx011)
    );

    wire _PR_Reset_XPT_0;
    wire _P2_Set_CM1_0; // <
    wire _Pa_Ophd_0; // >

    DECODER_op_X1_00xxx010 d00xxx010(
        .enable(_00xxx010),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_0),
        .P2_Set_CM1(_P2_Set_CM1_0), // <
        .Pa_Ophd(_Pa_Ophd_0), // >
        .PI_SelectAd_BC(PI_SelectAd_BC),
        .PI_SelectAd_DE(PI_SelectAd_DE),
        .PI_SelectDt_A(PI_SelectDt_A),
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .PR_Write_A(PR_Write_A), // <
        .PR_InvertIn(PR_InvertIn), // >
        .P2_Set_CMR(P2_Set_CMR),
        .P2_Set_ILDlnnlHL_0(P2_Set_ILDlnnlHL_0),
        .P2_Set_ILDHLlnnl_0(P2_Set_ILDHLlnnl_0),
        .P2_Set_ILDlnnlA_0(P2_Set_ILDlnnlA_0),
        .P2_Set_ILDAlnnl_0(P2_Set_ILDAlnnl_0)
    );

    wire _PR_Reset_XPT_1; // <
    wire _P2_Set_CM1_1;
    wire _Pa_Ophd_1; // >

    DECODER_op_X1_00xxx011 d00xxx011(
        .enable(_00xxx011),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_1), // <
        .P2_Set_CM1(_P2_Set_CM1_1),
        .Pa_Ophd(_Pa_Ophd_1),
        .PA_Select_0x1_low(PA_Select_0x1_low), // >
        .PA_ADD(PA_ADD),
        .PA_SUB(PA_SUB),
        .PA_Select_BC_high(PA_Select_BC_high), // <
        .PR_Write_B(PR_Write_B),
        .PR_Write_C(PR_Write_C), // >
        .PA_Select_DE_high(PA_Select_DE_high), // <
        .PR_Write_D(PR_Write_D),
        .PR_Write_E(PR_Write_E), // >
        .PA_Select_HL_high(PA_Select_HL_high), // <
        .PR_Write_H(PR_Write_H),
        .PR_Write_L(PR_Write_L), // >
        .PA_Select_SP_high(PA_Select_SP_high), // <
        .PR_Write_SP_high(PR_Write_SP_high),
        .PR_Write_SP_low(PR_Write_SP_low) // >
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2

    assign P2_Set_CM1 = (_P2_Set_CM1_0 | _P2_Set_CM1_1); // 2
    assign Pa_Ophd = P2_Set_CM1;

endmodule
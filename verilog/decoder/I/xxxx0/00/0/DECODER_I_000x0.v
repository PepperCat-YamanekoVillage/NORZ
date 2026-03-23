// 9(132)
module DECODER_I_000x0(
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
        output wire PR_Write_PC_low,
        output wire PR_Write_B,
        output wire PR_Write_C,
        output wire PR_Write_D,
        output wire PR_Write_E,
        output wire PR_Write_H,
        output wire PR_Write_L
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _00000xxx;
    wire _00010xxx;

    DECODER_1bit_decoder d_000d0xxx(
        .notEnable(_not_enable),
        .In(ITABLE[4]),
        .notIn(notITABLE[4]),
        .out0(_00000xxx),
        .out1(_00010xxx)
    );

    wire _PR_Reset_XPT_0;
    wire _P2_Set_CM1_0; // <
    wire _P2_Reset_ITABLE_0;
    wire _Pa_Ophd_0; // >
    wire _PR_Write_A_0;
    wire _PR_InvertIn_0;

    DECODER_I_00000 d00000(
        .enable(_00000xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .not_is00000000(not_is00000000),
        .PI_SelectAd_HL(PI_SelectAd_HL),
        .PI_SelectDt_OP(PI_SelectDt_OP),
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .PR_Reset_XPT(_PR_Reset_XPT_0),
        .P2_Set_CM1(_P2_Set_CM1_0), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_0),
        .Pa_Ophd(_Pa_Ophd_0), // >
        .P2_Set_CMR(P2_Set_CMR),
        .P2_Set_ILDlnnlHL_1(P2_Set_ILDlnnlHL_1),
        .PI_SelectDt_L(PI_SelectDt_L),
        .PI_SelectDt_H(PI_SelectDt_H),
        .PI_SelectAdt1(PI_SelectAdt1),
        .PI_SelectAd_OPOPold(PI_SelectAd_OPOPold),
        .P2_Set_ILDAlnnl_1(P2_Set_ILDAlnnl_1),
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PR_Write_A(_PR_Write_A_0),
        .PR_InvertIn(_PR_InvertIn_0),
        .P2_Set_CMA(P2_Set_CMA),
        .P2_Set_IJPnn_1(P2_Set_IJPnn_1),
        .PA_Select_OPxx_low(PA_Select_OPxx_low),
        .PA_NOP(PA_NOP),
        .PR_Write_PC_high(PR_Write_PC_high),
        .PR_Write_PC_low(PR_Write_PC_low)
    );

    wire _PR_Reset_XPT_1; // <
    wire _P2_Set_CM1_1;
    wire _P2_Reset_ITABLE_1;
    wire _Pa_Ophd_1; // >
    wire _PR_Write_A_1;
    wire _PR_InvertIn_1;

    DECODER_I_00010 d00010(
        .enable(_00010xxx),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PR_Write_A(_PR_Write_A_1),
        .PR_Write_B(PR_Write_B),
        .PR_Write_C(PR_Write_C),
        .PR_Write_D(PR_Write_D),
        .PR_Write_E(PR_Write_E),
        .PR_Write_H(PR_Write_H),
        .PR_Write_L(PR_Write_L),
        .PR_Reset_XPT(_PR_Reset_XPT_1), // <
        .P2_Set_CM1(_P2_Set_CM1_1),
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_1),
        .Pa_Ophd(_Pa_Ophd_1), // >
        .PR_InvertIn(_PR_InvertIn_1)
    );

    assign P2_Set_CM1 = (_P2_Set_CM1_0 | _P2_Set_CM1_1); // 2
    assign P2_Reset_ITABLE = P2_Set_CM1;
    assign Pa_Ophd = P2_Set_CM1;

    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2
    assign PR_Write_A = (_PR_Write_A_0 | _PR_Write_A_1); // 2
    assign PR_InvertIn = (_PR_InvertIn_0 | _PR_InvertIn_1); // 2

endmodule
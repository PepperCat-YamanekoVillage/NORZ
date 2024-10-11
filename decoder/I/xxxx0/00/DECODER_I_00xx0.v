// 27(217)
module DECODER_I_00xx0(
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
        output wire PA_Select_OP_high,
        output wire PA_NOP,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low,
        output wire PR_Write_B,
        output wire PR_Write_C,
        output wire PR_Write_D,
        output wire PR_Write_E,
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PA_Select_IX_high,
        output wire PA_Select_IY_high,
        output wire PA_Select_OP_low,
        output wire PA_ADD,
        output wire PR_Write_Dt,
        output wire PR_Write_Dtex,
        output wire PI_SelectAd_DtexDt
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _000x0xxx;
    wire _001x0xxx;

    DECODER_1bit_decoder d_00dx0xxx(
        .notEnable(_not_enable),
        .In(ITABLE[5]),
        .notIn(notITABLE[5]),
        .out0(_000x0xxx),
        .out1(_001x0xxx)
    );

    wire _PR_Reset_XPT_0;
    wire _P2_Set_CM1_0; // <
    wire _P2_Reset_ITABLE_0;
    wire _Pa_Ophd_0; // >
    wire _PC_R0_0;
    wire _PC_R1_0;
    wire _PC_R2_0;
    wire _PR_Write_A_0;
    wire _PR_InvertIn_0;
    wire _PR_Write_B_0;
    wire _PR_Write_C_0;
    wire _PR_Write_D_0;
    wire _PR_Write_E_0;
    wire _PR_Write_H_0;
    wire _PR_Write_L_0;

    DECODER_I_000x0 d000x0(
        .enable(_000x0xxx),
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
        .PC_R0(_PC_R0_0),
        .PC_R1(_PC_R1_0),
        .PC_R2(_PC_R2_0),
        .PR_Write_A(_PR_Write_A_0),
        .PR_InvertIn(_PR_InvertIn_0),
        .P2_Set_CMA(P2_Set_CMA),
        .P2_Set_IJPnn_1(P2_Set_IJPnn_1),
        .PA_Select_OP_high(PA_Select_OP_high),
        .PA_NOP(PA_NOP),
        .PR_Write_PC_high(PR_Write_PC_high),
        .PR_Write_PC_low(PR_Write_PC_low),
        .PR_Write_B(_PR_Write_B_0),
        .PR_Write_C(_PR_Write_C_0),
        .PR_Write_D(_PR_Write_D_0),
        .PR_Write_E(_PR_Write_E_0),
        .PR_Write_H(_PR_Write_H_0),
        .PR_Write_L(_PR_Write_L_0)
    );

    wire _PR_Reset_XPT_1; // <
    wire _P2_Set_CM1_1;
    wire _P2_Reset_ITABLE_1;
    wire _Pa_Ophd_1; // >
    wire _PC_R0_1;
    wire _PC_R1_1;
    wire _PC_R2_1;
    wire _PR_Write_A_1;
    wire _PR_InvertIn_1;
    wire _PR_Write_B_1;
    wire _PR_Write_C_1;
    wire _PR_Write_D_1;
    wire _PR_Write_E_1;
    wire _PR_Write_H_1;
    wire _PR_Write_L_1;

    DECODER_I_001x0 d001x0(
        .enable(_001x0xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PA_Select_IX_high(PA_Select_IX_high),
        .PA_Select_IY_high(PA_Select_IY_high),
        .PA_Select_OP_low(PA_Select_OP_low), // <
        .PA_ADD(PA_ADD),
        .PR_Write_Dt(PR_Write_Dt),
        .PR_Write_Dtex(PR_Write_Dtex), // >
        .PI_SelectAd_DtexDt(PI_SelectAd_DtexDt),
        .PC_R0(_PC_R0_1),
        .PC_R1(_PC_R1_1),
        .PC_R2(_PC_R2_1),
        .PR_Reset_XPT(_PR_Reset_XPT_1), // <
        .P2_Set_CM1(_P2_Set_CM1_1),
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_1),
        .Pa_Ophd(_Pa_Ophd_1), // >
        .PR_Write_A(_PR_Write_A_1),
        .PR_Write_B(_PR_Write_B_1),
        .PR_Write_C(_PR_Write_C_1),
        .PR_Write_D(_PR_Write_D_1),
        .PR_Write_E(_PR_Write_E_1),
        .PR_Write_H(_PR_Write_H_1),
        .PR_Write_L(_PR_Write_L_1),
        .PR_InvertIn(_PR_InvertIn_1)
    );

    assign P2_Set_CM1 = (_P2_Set_CM1_0 | _P2_Set_CM1_1); // 2
    assign P2_Reset_ITABLE = P2_Set_CM1;
    assign Pa_Ophd = P2_Set_CM1;

    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2
    assign PC_R0 = (_PC_R0_0 | _PC_R0_1); // 2
    assign PC_R1 = (_PC_R1_0 | _PC_R1_1); // 2
    assign PC_R2 = (_PC_R2_0 | _PC_R2_1); // 2
    assign PR_Write_A = (_PR_Write_A_0 | _PR_Write_A_1); // 2
    assign PR_Write_B = (_PR_Write_B_0 | _PR_Write_B_1); // 2
    assign PR_Write_C = (_PR_Write_C_0 | _PR_Write_C_1); // 2
    assign PR_Write_D = (_PR_Write_D_0 | _PR_Write_D_1); // 2
    assign PR_Write_E = (_PR_Write_E_0 | _PR_Write_E_1); // 2
    assign PR_Write_H = (_PR_Write_H_0 | _PR_Write_H_1); // 2
    assign PR_Write_L = (_PR_Write_L_0 | _PR_Write_L_1); // 2
    assign PR_InvertIn = (_PR_InvertIn_0 | _PR_InvertIn_1); // 2

endmodule
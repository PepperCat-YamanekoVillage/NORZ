// 93(578)
module DECODER_I_xxxx0(
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
        output wire PR_Write_L,
        output wire PA_Select_IX_high,
        output wire PA_Select_IY_high,
        output wire PA_Select_OP_low,
        output wire PA_ADD,
        output wire PR_Write_Dt,
        output wire PR_Write_Dtex,
        output wire PI_SelectAd_DtexDt,
        output wire P2_Set_ILDddnn_BC_1,
        output wire P2_Set_ILDddnn_DE_1,
        output wire P2_Set_ILDddnn_HL_1,
        output wire P2_Set_ILDddnn_SP_1,
        output wire PR_Write_SP_low,
        output wire PR_Write_SP_high,
        output wire P2_Set_ILDddlnnl_BC_1,
        output wire P2_Set_ILDddlnnl_DE_1,
        output wire P2_Set_ILDddlnnl_HL_1,
        output wire P2_Set_ILDddlnnl_SP_1,
        output wire PI_SelectDt_A,
        output wire PI_SelectDt_B,
        output wire PI_SelectDt_D,
        output wire PI_SelectDt_C,
        output wire PI_SelectDt_E,
        output wire P2_Set_ILDlnnldd_BC_1,
        output wire P2_Set_ILDlnnldd_DE_1,
        output wire P2_Set_ILDlnnldd_HL_1,
        output wire P2_Set_ILDlnnldd_SP_1,
        output wire PI_SelectDt_SP_low,
        output wire PI_SelectDt_SP_high,
        output wire PA_Select_A_high,
        output wire PF_Write_S,
        output wire PF_Select_S_bit7,
        output wire PF_Write_Z,
        output wire PF_Select_Z_bit24,
        output wire PF_Write_H,
        output wire PF_Write_PV,
        output wire PF_Write_N,
        output wire PF_Write_C,
        output wire PA_ADC,
        output wire PA_SUB,
        output wire PA_SBC,
        output wire PA_AND,
        output wire PA_OR,
        output wire PA_XOR,
        output wire PF_Select_H_bit22,
        output wire PF_Select_N_bit17,
        output wire PF_Select_C_bit26,
        output wire PF_Select_H_bit21,
        output wire PF_Select_C_bit23,
        output wire PF_Select_H_bit16,
        output wire PF_Select_PV_bit27,
        output wire PF_Select_C_bit16,
        output wire PF_Select_H_bit17,
        output wire PF_Select_N_bit16,
        output wire PF_Select_PV_bit25
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _00xx0xxx;
    wire _01xx0xxx;
    wire _10xx0xxx;
    wire _11xx0xxx;

    DECODER_2bit_decoder d_ddxx0xxx( // 8
        .notEnable(_not_enable),
        .In(ITABLE[7:6]),
        .notIn(notITABLE[7:6]),
        .out00(_00xx0xxx),
        .out01(_01xx0xxx),
        .out10(_10xx0xxx),
        .out11(_11xx0xxx)
    );

    wire _PC_W0_00;
    wire _PC_W1_00;
    wire _PC_W2_00;
    wire _PR_Reset_XPT_00;
    wire _P2_Set_CM1_00; // <
    wire _P2_Reset_ITABLE_00;
    wire _Pa_Ophd_00; // <
    wire _P2_Set_CMR_00;
    wire _PI_SelectDt_L_00;
    wire _PI_SelectDt_H_00;
    wire _PI_SelectAdt1_00;
    wire _PI_SelectAd_OPOPold_00;
    wire _PC_R0_00;
    wire _PC_R1_00;
    wire _PC_R2_00;
    wire _PR_Write_A_00;
    wire _PR_InvertIn_00;
    wire _PR_Write_B_00;
    wire _PR_Write_C_00;
    wire _PR_Write_D_00;
    wire _PR_Write_E_00;
    wire _PR_Write_H_00;
    wire _PR_Write_L_00;
    wire _PA_Select_IX_high_00;
    wire _PA_Select_IY_high_00;
    wire _PA_Select_OP_low_00;
    wire _PA_ADD_00;
    wire _PR_Write_Dt_00;
    wire _PR_Write_Dtex_00;
    wire _PI_SelectAd_DtexDt_00;

    DECODER_I_00xx0 d00xx0(
        .enable(_00xx0xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .not_is00000000(not_is00000000),
        .PI_SelectAd_HL(PI_SelectAd_HL),
        .PI_SelectDt_OP(PI_SelectDt_OP),
        .PC_W0(_PC_W0_00),
        .PC_W1(_PC_W1_00),
        .PC_W2(_PC_W2_00),
        .PR_Reset_XPT(_PR_Reset_XPT_00),
        .P2_Set_CM1(_P2_Set_CM1_00), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_00),
        .Pa_Ophd(_Pa_Ophd_00), // >
        .P2_Set_CMR(_P2_Set_CMR_00),
        .P2_Set_ILDlnnlHL_1(P2_Set_ILDlnnlHL_1),
        .PI_SelectDt_L(_PI_SelectDt_L_00),
        .PI_SelectDt_H(_PI_SelectDt_H_00),
        .PI_SelectAdt1(_PI_SelectAdt1_00),
        .PI_SelectAd_OPOPold(_PI_SelectAd_OPOPold_00),
        .P2_Set_ILDAlnnl_1(P2_Set_ILDAlnnl_1),
        .PC_R0(_PC_R0_00),
        .PC_R1(_PC_R1_00),
        .PC_R2(_PC_R2_00),
        .PR_Write_A(_PR_Write_A_00),
        .PR_InvertIn(_PR_InvertIn_00),
        .P2_Set_CMA(P2_Set_CMA),
        .P2_Set_IJPnn_1(P2_Set_IJPnn_1),
        .PA_Select_OPxx_low(PA_Select_OPxx_low),
        .PA_NOP(PA_NOP),
        .PR_Write_PC_high(PR_Write_PC_high),
        .PR_Write_PC_low(PR_Write_PC_low),
        .PR_Write_B(_PR_Write_B_00),
        .PR_Write_C(_PR_Write_C_00),
        .PR_Write_D(_PR_Write_D_00),
        .PR_Write_E(_PR_Write_E_00),
        .PR_Write_H(_PR_Write_H_00),
        .PR_Write_L(_PR_Write_L_00),
        .PA_Select_IX_high(_PA_Select_IX_high_00),
        .PA_Select_IY_high(_PA_Select_IY_high_00),
        .PA_Select_OP_low(_PA_Select_OP_low_00),
        .PA_ADD(_PA_ADD_00),
        .PR_Write_Dt(_PR_Write_Dt_00),
        .PR_Write_Dtex(_PR_Write_Dtex_00),
        .PI_SelectAd_DtexDt(_PI_SelectAd_DtexDt_00)
    );

    wire _P2_Set_CMR_01;
    wire _PR_Write_C_01;
    wire _PR_Write_E_01;
    wire _PR_Write_L_01;
    wire _PR_Reset_XPT_01;
    wire _P2_Set_CM1_01; // <
    wire _P2_Reset_ITABLE_01;
    wire _Pa_Ophd_01; // >
    wire _PR_InvertIn_01;
    wire _PR_Write_B_01;
    wire _PR_Write_D_01;
    wire _PR_Write_H_01;
    wire _PI_SelectAd_OPOPold_01;
    wire _PC_R0_01;
    wire _PC_R1_01;
    wire _PC_R2_01;
    wire _PI_SelectAdt1_01;
    wire _PA_Select_IX_high_01;
    wire _PA_Select_IY_high_01;
    wire _PA_Select_OP_low_01;
    wire _PA_ADD_01;
    wire _PR_Write_Dt_01;
    wire _PR_Write_Dtex_01;
    wire _PI_SelectAd_DtexDt_01;
    wire _PI_SelectDt_B_01;
    wire _PI_SelectDt_C_01;
    wire _PI_SelectDt_D_01;
    wire _PI_SelectDt_E_01;
    wire _PI_SelectDt_H_01;
    wire _PI_SelectDt_L_01;
    wire _PC_W0_01;
    wire _PC_W1_01;
    wire _PC_W2_01;

    DECODER_I_01xx0 d01xx0(
        .enable(_01xx0xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .P2_Set_CMR(_P2_Set_CMR_01),
        .P2_Set_ILDddnn_BC_1(P2_Set_ILDddnn_BC_1),
        .P2_Set_ILDddnn_DE_1(P2_Set_ILDddnn_DE_1),
        .P2_Set_ILDddnn_HL_1(P2_Set_ILDddnn_HL_1),
        .P2_Set_ILDddnn_SP_1(P2_Set_ILDddnn_SP_1),
        .PR_Write_C(_PR_Write_C_01),
        .PR_Write_E(_PR_Write_E_01),
        .PR_Write_L(_PR_Write_L_01),
        .PR_Write_SP_low(PR_Write_SP_low),
        .PR_Reset_XPT(_PR_Reset_XPT_01),
        .P2_Set_CM1(_P2_Set_CM1_01), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_01),
        .Pa_Ophd(_Pa_Ophd_01), // >
        .PR_InvertIn(_PR_InvertIn_01),
        .PR_Write_B(_PR_Write_B_01),
        .PR_Write_D(_PR_Write_D_01),
        .PR_Write_H(_PR_Write_H_01),
        .PR_Write_SP_high(PR_Write_SP_high),
        .P2_Set_ILDddlnnl_BC_1(P2_Set_ILDddlnnl_BC_1),
        .P2_Set_ILDddlnnl_DE_1(P2_Set_ILDddlnnl_DE_1),
        .P2_Set_ILDddlnnl_HL_1(P2_Set_ILDddlnnl_HL_1),
        .P2_Set_ILDddlnnl_SP_1(P2_Set_ILDddlnnl_SP_1),
        .PI_SelectAd_OPOPold(_PI_SelectAd_OPOPold_01),
        .PC_R0(_PC_R0_01),
        .PC_R1(_PC_R1_01),
        .PC_R2(_PC_R2_01),
        .PI_SelectAdt1(_PI_SelectAdt1_01),
        .PA_Select_IX_high(_PA_Select_IX_high_01),
        .PA_Select_IY_high(_PA_Select_IY_high_01),
        .PA_Select_OP_low(_PA_Select_OP_low_01), // <
        .PA_ADD(_PA_ADD_01),
        .PR_Write_Dt(_PR_Write_Dt_01),
        .PR_Write_Dtex(_PR_Write_Dtex_01), // >
        .PI_SelectAd_DtexDt(_PI_SelectAd_DtexDt_01),
        .PI_SelectDt_A(PI_SelectDt_A),
        .PI_SelectDt_B(_PI_SelectDt_B_01),
        .PI_SelectDt_C(_PI_SelectDt_C_01),
        .PI_SelectDt_D(_PI_SelectDt_D_01),
        .PI_SelectDt_E(_PI_SelectDt_E_01),
        .PI_SelectDt_H(_PI_SelectDt_H_01),
        .PI_SelectDt_L(_PI_SelectDt_L_01),
        .PC_W0(_PC_W0_01),
        .PC_W1(_PC_W1_01),
        .PC_W2(_PC_W2_01)
    );

    wire _P2_Set_CMR_10;
    wire _PR_Reset_XPT_10;
    wire _PC_W0_10;
    wire _PC_W1_10;
    wire _PC_W2_10;
    wire _PI_SelectDt_B_10;
    wire _PI_SelectDt_C_10;
    wire _PI_SelectDt_D_10;
    wire _PI_SelectDt_E_10;
    wire _PI_SelectDt_H_10;
    wire _PI_SelectDt_L_10;
    wire _PI_SelectAdt1_10;
    wire _PI_SelectAd_OPOPold_10;
    wire _P2_Set_CM1_10; // <
    wire _P2_Reset_ITABLE_10;
    wire _Pa_Ophd_10; // >

    DECODER_I_10000 d10xx0(
        .enable(_10xx0xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .P2_Set_CMR(_P2_Set_CMR_10),
        .P2_Set_ILDlnnldd_BC_1(P2_Set_ILDlnnldd_BC_1),
        .P2_Set_ILDlnnldd_DE_1(P2_Set_ILDlnnldd_DE_1),
        .P2_Set_ILDlnnldd_HL_1(P2_Set_ILDlnnldd_HL_1),
        .P2_Set_ILDlnnldd_SP_1(P2_Set_ILDlnnldd_SP_1),
        .PR_Reset_XPT(_PR_Reset_XPT_10),
        .PC_W0(_PC_W0_10),
        .PC_W1(_PC_W1_10),
        .PC_W2(_PC_W2_10),
        .PI_SelectDt_C(_PI_SelectDt_C_10),
        .PI_SelectDt_E(_PI_SelectDt_E_10),
        .PI_SelectDt_L(_PI_SelectDt_L_10),
        .PI_SelectDt_SP_low(PI_SelectDt_SP_low),
        .PI_SelectDt_B(_PI_SelectDt_B_10),
        .PI_SelectDt_D(_PI_SelectDt_D_10),
        .PI_SelectDt_H(_PI_SelectDt_H_10),
        .PI_SelectDt_SP_high(PI_SelectDt_SP_high),
        .PI_SelectAdt1(_PI_SelectAdt1_10),
        .PI_SelectAd_OPOPold(_PI_SelectAd_OPOPold_10),
        .P2_Set_CM1(_P2_Set_CM1_10), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_10),
        .Pa_Ophd(_Pa_Ophd_10) // >
    );

    wire _P2_Reset_ITABLE_11; // <
    wire _PR_Reset_XPT_11;
    wire _P2_Set_CM1_11;
    wire _PR_InvertIn_11;
    wire _Pa_Ophd_11; // >
    wire _PR_Write_A_11;
    wire _PA_ADD_11;

    DECODER_I_11110 d11xx0(
        .enable(_11xx0xxx),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_11), // <
        .PR_Reset_XPT(_PR_Reset_XPT_11),
        .P2_Set_CM1(_P2_Set_CM1_11),
        .PA_Select_A_high(PA_Select_A_high),
        .PR_InvertIn(_PR_InvertIn_11),
        .PF_Write_S(PF_Write_S),
        .PF_Select_S_bit7(PF_Select_S_bit7),
        .PF_Write_Z(PF_Write_Z),
        .PF_Select_Z_bit24(PF_Select_Z_bit24),
        .PF_Write_H(PF_Write_H),
        .PF_Write_PV(PF_Write_PV),
        .PF_Write_N(PF_Write_N),
        .PF_Write_C(PF_Write_C),
        .Pa_Ophd(_Pa_Ophd_11), // >
        .PR_Write_A(_PR_Write_A_11),
        .PA_ADD(_PA_ADD_11),
        .PA_ADC(PA_ADC),
        .PA_SUB(PA_SUB),
        .PA_SBC(PA_SBC),
        .PA_AND(PA_AND),
        .PA_OR(PA_OR),
        .PA_XOR(PA_XOR),
        .PF_Select_H_bit22(PF_Select_H_bit22), // <
        .PF_Select_N_bit17(PF_Select_N_bit17),
        .PF_Select_C_bit26(PF_Select_C_bit26), // >
        .PF_Select_H_bit21(PF_Select_H_bit21), // <
        .PF_Select_C_bit23(PF_Select_C_bit23), // >
        .PF_Select_H_bit16(PF_Select_H_bit16),
        .PF_Select_PV_bit27(PF_Select_PV_bit27), // <
        .PF_Select_C_bit16(PF_Select_C_bit16), // >
        .PF_Select_H_bit17(PF_Select_H_bit17),
        .PF_Select_N_bit16(PF_Select_N_bit16),
        .PF_Select_PV_bit25(PF_Select_PV_bit25)
    );

    assign P2_Set_CM1 = (_P2_Set_CM1_00 | _P2_Set_CM1_01 | _P2_Set_CM1_10 | _P2_Set_CM1_11); // 6
    assign P2_Reset_ITABLE = P2_Set_CM1;
    assign Pa_Ophd = P2_Set_CM1;

    assign PC_W0 = (_PC_W0_00 | _PC_W0_01 | _PC_W0_10); // 4
    assign PC_W1 = (_PC_W1_00 | _PC_W1_01 | _PC_W1_10); // 4
    assign PC_W2 = (_PC_W2_00 | _PC_W2_01 | _PC_W2_10); // 4
    assign PR_Reset_XPT = (_PR_Reset_XPT_00 | _PR_Reset_XPT_01 | _PR_Reset_XPT_10 | _PR_Reset_XPT_11); // 6
    assign P2_Set_CMR = (_P2_Set_CMR_00 | _P2_Set_CMR_01 | _P2_Set_CMR_10); // 4
    assign PI_SelectDt_L = (_PI_SelectDt_L_00 | _PI_SelectDt_L_01 | _PI_SelectDt_L_10); // 4
    assign PI_SelectDt_H = (_PI_SelectDt_H_00 | _PI_SelectDt_H_01 | _PI_SelectDt_H_10); // 4
    assign PI_SelectAdt1 = (_PI_SelectAdt1_00 | _PI_SelectAdt1_01 | _PI_SelectAdt1_10); // 4
    assign PI_SelectAd_OPOPold = (_PI_SelectAd_OPOPold_00 | _PI_SelectAd_OPOPold_01 | _PI_SelectAd_OPOPold_10); // 4
    assign PC_R0 = (_PC_R0_00 | _PC_R0_01); // 2
    assign PC_R1 = (_PC_R1_00 | _PC_R1_01); // 2
    assign PC_R2 = (_PC_R2_00 | _PC_R2_01); // 2
    assign PR_Write_A = (_PR_Write_A_00 | _PR_Write_A_11); // 2
    assign PR_InvertIn = (_PR_InvertIn_00 | _PR_InvertIn_01 | _PR_InvertIn_11); // 4
    assign PR_Write_B = (_PR_Write_B_00 | _PR_Write_B_01); // 2
    assign PR_Write_C = (_PR_Write_C_00 | _PR_Write_C_01); // 2
    assign PR_Write_D = (_PR_Write_D_00 | _PR_Write_D_01); // 2
    assign PR_Write_E = (_PR_Write_E_00 | _PR_Write_E_01); // 2
    assign PR_Write_H = (_PR_Write_H_00 | _PR_Write_H_01); // 2
    assign PR_Write_L = (_PR_Write_L_00 | _PR_Write_L_01); // 2
    assign PA_Select_IX_high = (_PA_Select_IX_high_00 | _PA_Select_IX_high_01); // 2
    assign PA_Select_IY_high = (_PA_Select_IY_high_00 | _PA_Select_IY_high_01); // 2
    assign PA_Select_OP_low = (_PA_Select_OP_low_00 | _PA_Select_OP_low_01); // 2
    assign PA_ADD = (_PA_ADD_00 | _PA_ADD_01 | _PA_ADD_11); // 4
    assign PR_Write_Dt = (_PR_Write_Dt_00 | _PR_Write_Dt_01); // 2
    assign PR_Write_Dtex = (_PR_Write_Dtex_00 | _PR_Write_Dtex_01); // 2
    assign PI_SelectAd_DtexDt = (_PI_SelectAd_DtexDt_00 | _PI_SelectAd_DtexDt_01); // 2
    assign PI_SelectDt_B = (_PI_SelectDt_B_01 | _PI_SelectDt_B_10); // 2
    assign PI_SelectDt_C = (_PI_SelectDt_C_01 | _PI_SelectDt_C_10); // 2
    assign PI_SelectDt_D = (_PI_SelectDt_D_01 | _PI_SelectDt_D_10); // 2
    assign PI_SelectDt_E = (_PI_SelectDt_E_01 | _PI_SelectDt_E_10); // 2

endmodule
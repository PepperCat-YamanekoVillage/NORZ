// 95(622)
module DECODER_op_XOTR(
        input wire not_enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        input wire Flag_PV,
        input wire notFlag_Z,
        output wire PR_Inc_PC,
        output wire PI_SelectAd_BC,
        output wire PI_SelectDt_B,
        output wire PI_SelectDt_C,
        output wire PI_SelectDt_D,
        output wire PI_SelectDt_E,
        output wire PI_SelectDt_H,
        output wire PI_SelectDt_L,
        output wire PI_SelectDt_A,
        output wire PC_I0,
        output wire PC_I1,
        output wire PC_I2,
        output wire PC_I3,
        output wire PC_O0,
        output wire PC_O1,
        output wire PC_O2,
        output wire PC_O3,
        output wire PR_Reset_XPT, // <
        output wire P2_Reset_XOTR, // >
        output wire P2_Set_CM1, // <
        output wire Pa_Ophd, // >
        output wire PF_Write_Z,
        output wire PF_Write_PV,
        output wire PF_Write_S,
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Select_Z_bit24,
        output wire PF_Select_PV_bit27,
        output wire PF_Select_S_bit7,
        output wire PF_Select_N_bit16,
        output wire PF_Select_H_bit16,
        output wire PR_Write_B,
        output wire PR_Write_C,
        output wire PR_Write_D,
        output wire PR_Write_E,
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PR_Write_A,
        output wire PR_InvertIn,
        output wire PA_Select_HL_high,
        output wire PF_Write_C,
        output wire PF_Select_Z_bit34,
        output wire PF_Select_PV_bit33,
        output wire PF_Select_S_bit15,
        output wire PA_SBC,
        output wire PF_Select_C_bit36,
        output wire PF_Select_N_bit17,
        output wire PF_Select_H_bit35,
        output wire PA_ADC,
        output wire PF_Select_C_bit32,
        output wire PF_Select_H_bit31,
        output wire PA_Select_BC_low,
        output wire PA_Select_DE_low,
        output wire PA_Select_HL_low,
        output wire PA_Select_SP_low,
        output wire P2_Set_ILDlnnldd_BC_0,
        output wire P2_Set_ILDlnnldd_DE_0,
        output wire P2_Set_ILDlnnldd_HL_0,
        output wire P2_Set_ILDlnnldd_SP_0,
        output wire P2_Set_ILDddlnnl_BC_0,
        output wire P2_Set_ILDddlnnl_DE_0,
        output wire P2_Set_ILDddlnnl_HL_0,
        output wire P2_Set_ILDddlnnl_SP_0,
        output wire PA_Select_A_low,
        output wire PA_SUB,
        output wire PF_Select_C_bit26,
        output wire PF_Select_PV_bit25,
        output wire PF_Select_H_bit22,
        output wire PI_SelectAd_SP,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Inc_SP,
        output wire PR_Write_PC_low,
        output wire PR_Write_PC_high,
        output wire P2_RestoreIFF,
        output wire P2_IM0,
        output wire P2_IM1,
        output wire P2_IM2,
        output wire PA_NOP,
        output wire PR_Write_I,
        output wire PR_Write_R,
        output wire PF_Select_Z_bit19,
        output wire PF_Select_PV_bit18,
        output wire PA_Select_I_low,
        output wire PA_Select_R_low,
        output wire PR_Write_Dt,
        output wire PA_Select_Dt_high,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_Dt,
        output wire PI_SelectAd_HL,
        output wire PA_RRD,
        output wire PA_RLD,
        output wire PA_Select_BC_high,
        output wire PF_Select_PV_bit20,
        output wire PA_Select_PC_high,
        output wire PA_Select_0x1_low,
        output wire PA_ADD,
        output wire PI_SelectAd_DE,
        output wire PA_Select_DE_high,
        output wire PA_Select_A_high,
        output wire PA_Select_Dt_low,
        output wire PA_Select_B_high,
        output wire P2_Set_CMR
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    // t00010
    wire _decodedXPT2 = ~(not_enable | XPT[4] | XPT[3] | XPT[2] | notXPT[1] | XPT[0]); // 9
    assign PR_Inc_PC = _decodedXPT2;

    //
    // decoder
    //

    wire _01xxxxxx;
    wire _10xxxxxx;

    DECODER_1bit_decoder d_dxxxxxxx(
        .notEnable(not_enable),
        .In(Source[7]),
        .notIn(notSource[7]),
        .out0(_01xxxxxx),
        .out1(_10xxxxxx)
    );

    wire _PI_SelectAd_BC_0;
    wire _PC_I0_0;
    wire _PC_I1_0;
    wire _PC_I2_0;
    wire _PC_I3_0;
    wire _PC_O0_0;
    wire _PC_O1_0;
    wire _PC_O2_0;
    wire _PC_O3_0;
    wire _PR_Reset_XPT_0; // <
    wire _P2_Reset_XOTR_0; // >
    wire _P2_Set_CM1_0; // <
    wire _Pa_Ophd_0; // >
    wire _PF_Write_Z_0; // <
    wire _PF_Write_PV_0;
    wire _PF_Write_S_0;
    wire _PF_Write_N_0;
    wire _PF_Write_H_0; // >
    wire _PF_Select_Z_bit24_0;
    wire _PF_Select_S_bit7_0;
    wire _PF_Select_N_bit16_0;
    wire _PF_Select_H_bit16_0;
    wire _PR_Write_B_0;
    wire _PR_Write_C_0;
    wire _PR_Write_D_0;
    wire _PR_Write_E_0;
    wire _PR_Write_H_0;
    wire _PR_Write_L_0;
    wire _PA_Select_HL_high_0;
    wire _PF_Select_N_bit17_0;
    wire _PA_SUB_0;
    wire _PF_Select_H_bit22_0;
    wire _PC_R0_0;
    wire _PC_R1_0;
    wire _PC_R2_0;
    wire _PR_Write_PC_low_0;
    wire _PR_Write_PC_high_0;
    wire _PF_Select_Z_bit19_0;
    wire _PR_Write_Dt_0;
    wire _PC_W0_0;
    wire _PC_W1_0;
    wire _PC_W2_0;
    wire _PI_SelectDt_Dt_0;
    wire _PI_SelectAd_HL_0;
    wire _PR_InvertIn_0;

    DECODER_op_XOTR_01 d01(
        .enable(_01xxxxxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PI_SelectAd_BC(_PI_SelectAd_BC_0),
        .PI_SelectDt_B(PI_SelectDt_B),
        .PI_SelectDt_C(PI_SelectDt_C),
        .PI_SelectDt_D(PI_SelectDt_D),
        .PI_SelectDt_E(PI_SelectDt_E),
        .PI_SelectDt_H(PI_SelectDt_H),
        .PI_SelectDt_L(PI_SelectDt_L),
        .PI_SelectDt_A(PI_SelectDt_A),
        .PC_I0(_PC_I0_0),
        .PC_I1(_PC_I1_0),
        .PC_I2(_PC_I2_0),
        .PC_I3(_PC_I3_0),
        .PC_O0(_PC_O0_0),
        .PC_O1(_PC_O1_0),
        .PC_O2(_PC_O2_0),
        .PC_O3(_PC_O3_0),
        .PR_Reset_XPT(_PR_Reset_XPT_0), // <
        .P2_Reset_XOTR(_P2_Reset_XOTR_0), // >
        .P2_Set_CM1(_P2_Set_CM1_0), // <
        .Pa_Ophd(_Pa_Ophd_0), // >
        .PF_Write_Z(_PF_Write_Z_0), // <
        .PF_Write_PV(_PF_Write_PV_0),
        .PF_Write_S(_PF_Write_S_0),
        .PF_Write_N(_PF_Write_N_0),
        .PF_Write_H(_PF_Write_H_0), // >
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_0),
        .PF_Select_PV_bit27(PF_Select_PV_bit27),
        .PF_Select_S_bit7(_PF_Select_S_bit7_0),
        .PF_Select_N_bit16(_PF_Select_N_bit16_0),
        .PF_Select_H_bit16(_PF_Select_H_bit16_0),
        .PR_Write_B(_PR_Write_B_0),
        .PR_Write_C(_PR_Write_C_0),
        .PR_Write_D(_PR_Write_D_0),
        .PR_Write_E(_PR_Write_E_0),
        .PR_Write_H(_PR_Write_H_0),
        .PR_Write_L(_PR_Write_L_0),
        .PR_Write_A(PR_Write_A),
        .PR_InvertIn(_PR_InvertIn_0),
        .PA_Select_HL_high(_PA_Select_HL_high_0),
        .PF_Write_C(PF_Write_C),
        .PF_Select_Z_bit34(PF_Select_Z_bit34),
        .PF_Select_PV_bit33(PF_Select_PV_bit33),
        .PF_Select_S_bit15(PF_Select_S_bit15),
        .PA_SBC(PA_SBC),
        .PF_Select_C_bit36(PF_Select_C_bit36),
        .PF_Select_N_bit17(_PF_Select_N_bit17_0),
        .PF_Select_H_bit35(PF_Select_H_bit35),
        .PA_ADC(PA_ADC),
        .PF_Select_C_bit32(PF_Select_C_bit32),
        .PF_Select_H_bit31(PF_Select_H_bit31),
        .PA_Select_BC_low(PA_Select_BC_low),
        .PA_Select_DE_low(PA_Select_DE_low),
        .PA_Select_HL_low(PA_Select_HL_low),
        .PA_Select_SP_low(PA_Select_SP_low),
        .P2_Set_ILDlnnldd_BC_0(P2_Set_ILDlnnldd_BC_0),
        .P2_Set_ILDlnnldd_DE_0(P2_Set_ILDlnnldd_DE_0),
        .P2_Set_ILDlnnldd_HL_0(P2_Set_ILDlnnldd_HL_0),
        .P2_Set_ILDlnnldd_SP_0(P2_Set_ILDlnnldd_SP_0),
        .P2_Set_ILDddlnnl_BC_0(P2_Set_ILDddlnnl_BC_0),
        .P2_Set_ILDddlnnl_DE_0(P2_Set_ILDddlnnl_DE_0),
        .P2_Set_ILDddlnnl_HL_0(P2_Set_ILDddlnnl_HL_0),
        .P2_Set_ILDddlnnl_SP_0(P2_Set_ILDddlnnl_SP_0),
        .PA_Select_A_low(PA_Select_A_low),
        .PA_SUB(_PA_SUB_0),
        .PF_Select_C_bit26(PF_Select_C_bit26),
        .PF_Select_PV_bit25(PF_Select_PV_bit25),
        .PF_Select_H_bit22(_PF_Select_H_bit22_0),
        .PI_SelectAd_SP(PI_SelectAd_SP),
        .PC_R0(_PC_R0_0),
        .PC_R1(_PC_R1_0),
        .PC_R2(_PC_R2_0),
        .PR_Inc_SP(PR_Inc_SP),
        .PR_Write_PC_low(_PR_Write_PC_low_0),
        .PR_Write_PC_high(_PR_Write_PC_high_0),
        .P2_RestoreIFF(P2_RestoreIFF),
        .P2_IM0(P2_IM0),
        .P2_IM1(P2_IM1),
        .P2_IM2(P2_IM2),
        .PA_NOP(PA_NOP),
        .PR_Write_I(PR_Write_I),
        .PR_Write_R(PR_Write_R),
        .PF_Select_Z_bit19(_PF_Select_Z_bit19_0),
        .PF_Select_PV_bit18(PF_Select_PV_bit18),
        .PA_Select_I_low(PA_Select_I_low),
        .PA_Select_R_low(PA_Select_R_low),
        .PR_Write_Dt(_PR_Write_Dt_0),
        .PA_Select_Dt_high(PA_Select_Dt_high),
        .PC_W0(_PC_W0_0),
        .PC_W1(_PC_W1_0),
        .PC_W2(_PC_W2_0),
        .PI_SelectDt_Dt(_PI_SelectDt_Dt_0),
        .PI_SelectAd_HL(_PI_SelectAd_HL_0),
        .PA_RRD(PA_RRD),
        .PA_RLD(PA_RLD),
        .P2_Set_CMR(P2_Set_CMR)
    );

    wire _PI_SelectAd_BC_1;
    wire _PC_I0_1;
    wire _PC_I1_1;
    wire _PC_I2_1;
    wire _PC_I3_1;
    wire _PC_O0_1;
    wire _PC_O1_1;
    wire _PC_O2_1;
    wire _PC_O3_1;
    wire _PR_Reset_XPT_1; // <
    wire _P2_Reset_XOTR_1;
    wire _P2_Set_CM1_1;
    wire _Pa_Ophd_1; // >
    wire _PF_Write_Z_1;
    wire _PF_Write_PV_1;
    wire _PF_Write_S_1;
    wire _PF_Write_N_1;
    wire _PF_Write_H_1;
    wire _PF_Select_Z_bit24_1;
    wire _PF_Select_S_bit7_1;
    wire _PF_Select_N_bit16_1;
    wire _PF_Select_H_bit16_1;
    wire _PR_Write_B_1;
    wire _PR_Write_C_1;
    wire _PR_Write_D_1;
    wire _PR_Write_E_1;
    wire _PR_Write_H_1; // <
    wire _PR_Write_L_1;
    wire _PA_Select_HL_high_1; // >
    wire _PF_Select_N_bit17_1;
    wire _PA_SUB_1;
    wire _PF_Select_H_bit22_1;
    wire _PC_R0_1;
    wire _PC_R1_1;
    wire _PC_R2_1;
    wire _PR_Write_PC_low_1;
    wire _PR_Write_PC_high_1;
    wire _PF_Select_Z_bit19_1;
    wire _PR_Write_Dt_1;
    wire _PC_W0_1;
    wire _PC_W1_1;
    wire _PC_W2_1;
    wire _PI_SelectDt_Dt_1;
    wire _PI_SelectAd_HL_1;
    wire _PR_InvertIn_1;

    DECODER_op_XOTR_10 d10(
        .enable(_10xxxxxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .Flag_PV(Flag_PV),
        .notFlag_Z(notFlag_Z),
        .PR_Reset_XPT(_PR_Reset_XPT_1), // <
        .P2_Set_CM1(_P2_Set_CM1_1),
        .P2_Reset_XOTR(_P2_Reset_XOTR_1),
        .Pa_Ophd(_Pa_Ophd_1), // >
        .PA_Select_HL_high(_PA_Select_HL_high_1), // <
        .PR_Write_H(_PR_Write_H_1),
        .PR_Write_L(_PR_Write_L_1), // >
        .PA_Select_BC_high(PA_Select_BC_high), // <
        .PR_Write_C(_PR_Write_C_1),
        .PF_Write_PV(_PF_Write_PV_1),
        .PF_Select_PV_bit20(PF_Select_PV_bit20), // >
        .PA_Select_PC_high(PA_Select_PC_high),
        .PA_Select_0x1_low(PA_Select_0x1_low),
        .PA_SUB(_PA_SUB_1),
        .PR_Write_PC_high(_PR_Write_PC_high_1),
        .PR_Write_PC_low(_PR_Write_PC_low_1),
        .PA_ADD(PA_ADD),
        .PC_R0(_PC_R0_1),
        .PC_R1(_PC_R1_1),
        .PC_R2(_PC_R2_1),
        .PI_SelectAd_HL(_PI_SelectAd_HL_1),
        .PR_Write_Dt(_PR_Write_Dt_1),
        .PC_W0(_PC_W0_1),
        .PC_W1(_PC_W1_1),
        .PC_W2(_PC_W2_1),
        .PI_SelectAd_DE(PI_SelectAd_DE),
        .PI_SelectDt_Dt(_PI_SelectDt_Dt_1),
        .PA_Select_DE_high(PA_Select_DE_high),
        .PR_Write_D(_PR_Write_D_1),
        .PR_Write_E(_PR_Write_E_1),
        .PR_Write_B(_PR_Write_B_1),
        .PF_Write_N(_PF_Write_N_1),
        .PF_Write_H(_PF_Write_H_1),
        .PF_Select_N_bit16(_PF_Select_N_bit16_1),
        .PF_Select_H_bit16(_PF_Select_H_bit16_1),
        .PA_Select_A_high(PA_Select_A_high),
        .PA_Select_Dt_low(PA_Select_Dt_low),
        .PF_Write_Z(_PF_Write_Z_1),
        .PF_Write_S(_PF_Write_S_1),
        .PF_Select_Z_bit19(_PF_Select_Z_bit19_1),
        .PF_Select_S_bit7(_PF_Select_S_bit7_1),
        .PF_Select_H_bit22(_PF_Select_H_bit22_1),
        .PF_Select_N_bit17(_PF_Select_N_bit17_1),
        .PC_I0(_PC_I0_1),
        .PC_I1(_PC_I1_1),
        .PC_I2(_PC_I2_1),
        .PC_I3(_PC_I3_1),
        .PI_SelectAd_BC(_PI_SelectAd_BC_1),
        .PA_Select_B_high(PA_Select_B_high),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_1),
        .PC_O0(_PC_O0_1),
        .PC_O1(_PC_O1_1),
        .PC_O2(_PC_O2_1),
        .PC_O3(_PC_O3_1),
        .PR_InvertIn(_PR_InvertIn_1)
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2 
    assign P2_Reset_XOTR = PR_Reset_XPT;

    assign P2_Set_CM1 = (_P2_Set_CM1_0 | _P2_Set_CM1_1); // 2 
    assign Pa_Ophd = P2_Set_CM1;

    assign PI_SelectAd_BC = (_PI_SelectAd_BC_0 | _PI_SelectAd_BC_1); // 2
    assign PC_I0 = (_PC_I0_0 | _PC_I0_1); // 2
    assign PC_I1 = (_PC_I1_0 | _PC_I1_1); // 2
    assign PC_I2 = (_PC_I2_0 | _PC_I2_1); // 2
    assign PC_I3 = (_PC_I3_0 | _PC_I3_1); // 2
    assign PC_O0 = (_PC_O0_0 | _PC_O0_1); // 2
    assign PC_O1 = (_PC_O1_0 | _PC_O1_1); // 2
    assign PC_O2 = (_PC_O2_0 | _PC_O2_1); // 2
    assign PC_O3 = (_PC_O3_0 | _PC_O3_1); // 2
    assign PF_Write_Z = (_PF_Write_Z_0 | _PF_Write_Z_1); // 2
    assign PF_Write_PV = (_PF_Write_PV_0 | _PF_Write_PV_1); // 2
    assign PF_Write_S = (_PF_Write_S_0 | _PF_Write_S_1); // 2
    assign PF_Write_N = (_PF_Write_N_0 | _PF_Write_N_1); // 2
    assign PF_Write_H = (_PF_Write_H_0 | _PF_Write_H_1); // 2
    assign PF_Select_Z_bit24 = (_PF_Select_Z_bit24_0 | _PF_Select_Z_bit24_1); // 2
    assign PF_Select_S_bit7 = (_PF_Select_S_bit7_0 | _PF_Select_S_bit7_1); // 2
    assign PF_Select_N_bit16 = (_PF_Select_N_bit16_0 | _PF_Select_N_bit16_1); // 2
    assign PF_Select_H_bit16 = (_PF_Select_H_bit16_0 | _PF_Select_H_bit16_1); // 2
    assign PR_Write_B = (_PR_Write_B_0 | _PR_Write_B_1); // 2
    assign PR_Write_C = (_PR_Write_C_0 | _PR_Write_C_1); // 2
    assign PR_Write_D = (_PR_Write_D_0 | _PR_Write_D_1); // 2
    assign PR_Write_E = (_PR_Write_E_0 | _PR_Write_E_1); // 2
    assign PR_Write_H = (_PR_Write_H_0 | _PR_Write_H_1); // 2
    assign PR_Write_L = (_PR_Write_L_0 | _PR_Write_L_1); // 2
    assign PA_Select_HL_high = (_PA_Select_HL_high_0 | _PA_Select_HL_high_1); // 2
    assign PF_Select_N_bit17 = (_PF_Select_N_bit17_0 | _PF_Select_N_bit17_1); // 2
    assign PA_SUB = (_PA_SUB_0 | _PA_SUB_1); // 2
    assign PF_Select_H_bit22 = (_PF_Select_H_bit22_0 | _PF_Select_H_bit22_1); // 2
    assign PC_R0 = (_PC_R0_0 | _PC_R0_1); // 2
    assign PC_R1 = (_PC_R1_0 | _PC_R1_1); // 2
    assign PC_R2 = (_PC_R2_0 | _PC_R2_1); // 2
    assign PR_Write_PC_low = (_PR_Write_PC_low_0 | _PR_Write_PC_low_1); // 2
    assign PR_Write_PC_high = (_PR_Write_PC_high_0 | _PR_Write_PC_high_1); // 2
    assign PF_Select_Z_bit19 = (_PF_Select_Z_bit19_0 | _PF_Select_Z_bit19_1); // 2
    assign PR_Write_Dt = (_PR_Write_Dt_0 | _PR_Write_Dt_1); // 2
    assign PC_W0 = (_PC_W0_0 | _PC_W0_1); // 2
    assign PC_W1 = (_PC_W1_0 | _PC_W1_1); // 2
    assign PC_W2 = (_PC_W2_0 | _PC_W2_1); // 2
    assign PI_SelectDt_Dt = (_PI_SelectDt_Dt_0 | _PI_SelectDt_Dt_1); // 2
    assign PI_SelectAd_HL = (_PI_SelectAd_HL_0 | _PI_SelectAd_HL_1); // 2
    assign PR_InvertIn = (_PR_InvertIn_0 | _PR_InvertIn_1); // 2

endmodule
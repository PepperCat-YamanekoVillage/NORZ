// 47(276)
module DECODER_op_XOTR_01(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
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
        output wire PF_Write_Z, // <
        output wire PF_Write_PV,
        output wire PF_Write_S,
        output wire PF_Write_N,
        output wire PF_Write_H, // >
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
        output wire P2_Set_CMR
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _01xxx00x;
    wire _01xxx01x;
    wire _01xxx10x;
    wire _01xxx11x;

    DECODER_2bit_decoder d_01xxxddx( // 8
        .notEnable(_not_enable),
        .In(Source[2:1]),
        .notIn(notSource[2:1]),
        .out00(_01xxx00x),
        .out01(_01xxx01x),
        .out10(_01xxx10x),
        .out11(_01xxx11x)
    );

    wire _PR_Reset_XPT_00; // <
    wire _P2_Set_CM1_00;
    wire _P2_Reset_XOTR_00;
    wire _Pa_Ophd_00; // >
    wire _PF_Write_Z_00; // <
    wire _PF_Write_PV_00;
    wire _PF_Write_S_00;
    wire _PF_Write_N_00;
    wire _PF_Write_H_00;
    wire _PF_Select_Z_bit24_00;
    wire _PF_Select_PV_bit27_00;
    wire _PF_Select_S_bit7_00;
    wire _PF_Select_N_bit16_00;
    wire _PF_Select_H_bit16_00; // >
    wire _PR_Write_H_00;
    wire _PR_Write_L_00;
    wire _PR_Write_A_00;
    wire _PR_InvertIn_00;

    DECODER_op_XOTR_01xxx00 d01xxx00(
        .enable(_01xxx00x),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PI_SelectAd_BC(PI_SelectAd_BC),
        .PI_SelectDt_B(PI_SelectDt_B),
        .PI_SelectDt_C(PI_SelectDt_C),
        .PI_SelectDt_D(PI_SelectDt_D),
        .PI_SelectDt_E(PI_SelectDt_E),
        .PI_SelectDt_H(PI_SelectDt_H),
        .PI_SelectDt_L(PI_SelectDt_L),
        .PI_SelectDt_A(PI_SelectDt_A),
        .PC_I0(PC_I0),
        .PC_I1(PC_I1),
        .PC_I2(PC_I2),
        .PC_I3(PC_I3),
        .PC_O0(PC_O0),
        .PC_O1(PC_O1),
        .PC_O2(PC_O2),
        .PC_O3(PC_O3),
        .PR_Reset_XPT(_PR_Reset_XPT_00), // <
        .P2_Set_CM1(_P2_Set_CM1_00),
        .P2_Reset_XOTR(_P2_Reset_XOTR_00),
        .Pa_Ophd(_Pa_Ophd_00), // >
        .PF_Write_Z(_PF_Write_Z_00), // <
        .PF_Write_PV(_PF_Write_PV_00),
        .PF_Write_S(_PF_Write_S_00),
        .PF_Write_N(_PF_Write_N_00),
        .PF_Write_H(_PF_Write_H_00),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_00),
        .PF_Select_PV_bit27(_PF_Select_PV_bit27_00),
        .PF_Select_S_bit7(_PF_Select_S_bit7_00),
        .PF_Select_N_bit16(_PF_Select_N_bit16_00),
        .PF_Select_H_bit16(_PF_Select_H_bit16_00), // >
        .PR_Write_B(PR_Write_B),
        .PR_Write_C(PR_Write_C),
        .PR_Write_D(PR_Write_D),
        .PR_Write_E(PR_Write_E),
        .PR_Write_H(_PR_Write_H_00),
        .PR_Write_L(_PR_Write_L_00),
        .PR_Write_A(_PR_Write_A_00),
        .PR_InvertIn(_PR_InvertIn_00)
    );

    wire _PR_Write_H_01; // <
    wire _PR_Write_L_01;
    wire _PF_Write_C_01;
    wire _PF_Write_Z_01;
    wire _PF_Write_PV_01;
    wire _PF_Write_S_01;
    wire _PF_Write_N_01;
    wire _PF_Write_H_01; // >
    wire _PF_Select_N_bit17_01;
    wire _PF_Select_N_bit16_01;
    wire _PR_Reset_XPT_01; // <
    wire _P2_Reset_XOTR_01; // >
    wire _P2_Set_CM1_01; // <
    wire _Pa_Ophd_01; // >

    DECODER_op_XOTR_01xxx01 d01xxx01(
        .enable(_01xxx01x),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PA_Select_HL_high(PA_Select_HL_high), // <
        .PR_Write_H(_PR_Write_H_01),
        .PR_Write_L(_PR_Write_L_01),
        .PF_Write_C(_PF_Write_C_01),
        .PF_Write_Z(_PF_Write_Z_01),
        .PF_Write_PV(_PF_Write_PV_01),
        .PF_Write_S(_PF_Write_S_01),
        .PF_Write_N(_PF_Write_N_01),
        .PF_Write_H(_PF_Write_H_01),
        .PF_Select_Z_bit34(PF_Select_Z_bit34),
        .PF_Select_PV_bit33(PF_Select_PV_bit33),
        .PF_Select_S_bit15(PF_Select_S_bit15), // >
        .PA_SBC(PA_SBC),
        .PF_Select_C_bit36(PF_Select_C_bit36),
        .PF_Select_N_bit17(_PF_Select_N_bit17_01),
        .PF_Select_H_bit35(PF_Select_H_bit35),
        .PA_ADC(PA_ADC),
        .PF_Select_C_bit32(PF_Select_C_bit32),
        .PF_Select_N_bit16(_PF_Select_N_bit16_01),
        .PF_Select_H_bit31(PF_Select_H_bit31),
        .PA_Select_BC_low(PA_Select_BC_low),
        .PA_Select_DE_low(PA_Select_DE_low),
        .PA_Select_HL_low(PA_Select_HL_low),
        .PA_Select_SP_low(PA_Select_SP_low),
        .PR_Reset_XPT(_PR_Reset_XPT_01), // <
        .P2_Reset_XOTR(_P2_Reset_XOTR_01), // >
        .P2_Set_CM1(_P2_Set_CM1_01), // <
        .Pa_Ophd(_Pa_Ophd_01), // >
        .P2_Set_ILDlnnldd_BC_0(P2_Set_ILDlnnldd_BC_0),
        .P2_Set_ILDlnnldd_DE_0(P2_Set_ILDlnnldd_DE_0),
        .P2_Set_ILDlnnldd_HL_0(P2_Set_ILDlnnldd_HL_0),
        .P2_Set_ILDlnnldd_SP_0(P2_Set_ILDlnnldd_SP_0),
        .P2_Set_ILDddlnnl_BC_0(P2_Set_ILDddlnnl_BC_0),
        .P2_Set_ILDddlnnl_DE_0(P2_Set_ILDddlnnl_DE_0),
        .P2_Set_ILDddlnnl_HL_0(P2_Set_ILDddlnnl_HL_0),
        .P2_Set_ILDddlnnl_SP_0(P2_Set_ILDddlnnl_SP_0),
        .P2_Set_CMR(P2_Set_CMR)
    );

    wire _PR_Reset_XPT_10; // <
    wire _P2_Set_CM1_10;
    wire _P2_Reset_XOTR_10;
    wire _PR_InvertIn_10;
    wire _Pa_Ophd_10; // >
    wire _PA_Select_A_low_10; // <
    wire _PR_Write_A_10;
    wire _PF_Write_C_10;
    wire _PF_Write_Z_10;
    wire _PF_Write_PV_10;
    wire _PF_Write_S_10;
    wire _PF_Write_N_10;
    wire _PF_Write_H_10;
    wire _PF_Select_Z_bit24_10;
    wire _PF_Select_S_bit7_10;
    wire _PF_Select_N_bit17_10; // >
    wire _PC_R0_10;
    wire _PC_R1_10;
    wire _PC_R2_10;

    DECODER_op_XOTR_01xxx10 d01xxx10(
        .enable(_01xxx10x),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_10), // <
        .P2_Set_CM1(_P2_Set_CM1_10),
        .P2_Reset_XOTR(_P2_Reset_XOTR_10),
        .Pa_Ophd(_Pa_Ophd_10), // >
        .PA_Select_A_low(_PA_Select_A_low_10), // <
        .PA_SUB(PA_SUB),
        .PR_Write_A(_PR_Write_A_10),
        .PR_InvertIn(_PR_InvertIn_10),
        .PF_Write_C(_PF_Write_C_10),
        .PF_Write_Z(_PF_Write_Z_10),
        .PF_Write_PV(_PF_Write_PV_10),
        .PF_Write_S(_PF_Write_S_10),
        .PF_Write_N(_PF_Write_N_10),
        .PF_Write_H(_PF_Write_H_10),
        .PF_Select_C_bit26(PF_Select_C_bit26),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_10),
        .PF_Select_PV_bit25(PF_Select_PV_bit25),
        .PF_Select_S_bit7(_PF_Select_S_bit7_10),
        .PF_Select_N_bit17(_PF_Select_N_bit17_10),
        .PF_Select_H_bit22(PF_Select_H_bit22), // >
        .PI_SelectAd_SP(PI_SelectAd_SP),
        .PC_R0(_PC_R0_10),
        .PC_R1(_PC_R1_10),
        .PC_R2(_PC_R2_10),
        .PR_Inc_SP(PR_Inc_SP),
        .PR_Write_PC_low(PR_Write_PC_low),
        .PR_Write_PC_high(PR_Write_PC_high),
        .P2_RestoreIFF(P2_RestoreIFF)
    );

    wire _PR_Reset_XPT_11; // <
    wire _P2_Set_CM1_11;
    wire _P2_Reset_XOTR_11;
    wire _Pa_Ophd_11; // >
    wire _PA_Select_A_low_11;
    wire _PR_InvertIn_11;
    wire _PR_Write_A_11; // <
    wire _PF_Write_Z_11;
    wire _PF_Write_PV_11;
    wire _PF_Write_S_11;
    wire _PF_Write_N_11;
    wire _PF_Write_H_11;
    wire _PF_Select_S_bit7_11;
    wire _PF_Select_N_bit16_11;
    wire _PF_Select_H_bit16_11; // >
    wire _PC_R0_11;
    wire _PC_R1_11;
    wire _PC_R2_11;
    wire _PF_Select_Z_bit24_11;
    wire _PF_Select_PV_bit27_11;

    DECODER_op_XOTR_01xxx11 d01xxx11(
        .enable(_01xxx11x),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_11), // <
        .P2_Set_CM1(_P2_Set_CM1_11),
        .P2_Reset_XOTR(_P2_Reset_XOTR_11),
        .Pa_Ophd(_Pa_Ophd_11), // >
        .P2_IM0(P2_IM0),
        .P2_IM1(P2_IM1),
        .P2_IM2(P2_IM2),
        .PA_Select_A_low(_PA_Select_A_low_11),
        .PA_NOP(PA_NOP),
        .PR_Write_I(PR_Write_I),
        .PR_InvertIn(_PR_InvertIn_11),
        .PR_Write_R(PR_Write_R),
        .PR_Write_A(_PR_Write_A_11), // <
        .PF_Write_Z(_PF_Write_Z_11),
        .PF_Write_PV(_PF_Write_PV_11),
        .PF_Write_S(_PF_Write_S_11),
        .PF_Write_N(_PF_Write_N_11),
        .PF_Write_H(_PF_Write_H_11),
        .PF_Select_S_bit7(_PF_Select_S_bit7_11),
        .PF_Select_N_bit16(_PF_Select_N_bit16_11),
        .PF_Select_H_bit16(_PF_Select_H_bit16_11), // >
        .PF_Select_Z_bit19(PF_Select_Z_bit19),
        .PF_Select_PV_bit18(PF_Select_PV_bit18),
        .PA_Select_I_low(PA_Select_I_low),
        .PA_Select_R_low(PA_Select_R_low),
        .PC_R0(_PC_R0_11),
        .PC_R1(_PC_R1_11),
        .PC_R2(_PC_R2_11),
        .PR_Write_Dt(PR_Write_Dt),
        .PA_Select_Dt_high(PA_Select_Dt_high),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_11),
        .PF_Select_PV_bit27(_PF_Select_PV_bit27_11),
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .PI_SelectDt_Dt(PI_SelectDt_Dt),
        .PI_SelectAd_HL(PI_SelectAd_HL),
        .PA_RRD(PA_RRD),
        .PA_RLD(PA_RLD)
    );

    assign PC_R0 = (_PC_R0_10 | _PC_R0_11); // 2
    assign PC_R1 = (_PC_R1_10 | _PC_R1_11); // 2
    assign PC_R2 = (_PC_R2_10 | _PC_R2_11); // 2
    assign PR_Write_H = (_PR_Write_H_00 | _PR_Write_H_01); // 2
    assign PR_Write_L = (_PR_Write_L_00 | _PR_Write_L_01); // 2
    assign PR_InvertIn = (_PR_InvertIn_00 | _PR_InvertIn_10 | _PR_InvertIn_11); // 4
    assign PA_Select_A_low = (_PA_Select_A_low_10 | _PA_Select_A_low_11); // 2
    assign PF_Select_N_bit17 = (_PF_Select_N_bit17_01 | _PF_Select_N_bit17_10); // 2
    assign PF_Select_PV_bit27 = (_PF_Select_PV_bit27_00 | _PF_Select_PV_bit27_11); // 2

    wire _PR_Reset_XPT_ex01 = (_PR_Reset_XPT_00 | _PR_Reset_XPT_10 | _PR_Reset_XPT_11); // 2
    assign PR_Reset_XPT = (_PR_Reset_XPT_ex01 | _PR_Reset_XPT_01); // 2
    assign P2_Reset_XOTR = PR_Reset_XPT;
    assign P2_Set_CM1 = (_PR_Reset_XPT_ex01 | _P2_Set_CM1_01); // 2
    assign Pa_Ophd = P2_Set_CM1;

    wire _PF_03 = (_PF_Select_H_bit16_00 | _PF_Select_H_bit16_11); // 2
    assign PF_Select_H_bit16 = _PF_03;
    assign PF_Select_N_bit16 = (_PF_Select_N_bit16_01 | _PF_03); // 2

    wire _PF_02 = (_PF_Select_Z_bit24_00 | _PF_Select_Z_bit24_10); // 2
    assign PF_Select_Z_bit24 = (_PF_Select_Z_bit24_11 | _PF_02); // 2

    wire _PF_23 = (_PR_Write_A_10 | _PR_Write_A_11); // 2
    assign PR_Write_A = (_PR_Write_A_00 | _PF_23); // 2

    wire _PF_12 = (_PF_Write_C_01 | _PF_Write_C_10); // 2
    assign PF_Write_C = _PF_12;

    wire _PF_023 = (_PF_02 | _PF_03); // 2
    assign PF_Select_S_bit7 = _PF_023;

    wire _PF_0123 = (_PF_023 | _PF_12); // 2
    assign PF_Write_Z = _PF_0123;
    assign PF_Write_PV = _PF_0123;
    assign PF_Write_S = _PF_0123;
    assign PF_Write_N = _PF_0123;
    assign PF_Write_H = _PF_0123;

endmodule
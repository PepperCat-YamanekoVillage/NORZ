// 182(1286)
module DECODER_op_X1(
        input wire not_enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        input wire Flag_H,
        input wire Flag_Z,
        input wire Flag_C,
        input wire Flag_S,
        input wire Flag_N,
        input wire Flag_PV,
        output wire [2:0] _decodedXPT,
        output wire PR_Inc_PC,
        output wire P2_Set_LHALT,
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1,
        output wire Pa_Ophd,
        output wire PR_Ex_AF_AF,
        output wire P2_Set_CMR,
        output wire P2_Set_IDJNZe,
        output wire P2_Set_IJRNZe,
        output wire P2_Set_IJRNCe,
        output wire P2_Set_IJRe,
        output wire P2_Set_IJRZe,
        output wire P2_Set_IJRCe,
        output wire P2_Set_ILDddnn_BC_0,
        output wire P2_Set_ILDddnn_DE_0,
        output wire P2_Set_ILDddnn_HL_0,
        output wire P2_Set_ILDddnn_SP_0,
        output wire PA_ADD,
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PF_Write_C,
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Select_C_bit32,
        output wire PF_Select_N_bit16,
        output wire PF_Select_H_bit31,
        output wire PA_Select_HL_high,
        output wire PA_Select_BC_low,
        output wire PA_Select_DE_low,
        output wire PA_Select_HL_low,
        output wire PA_Select_SP_low,
        output wire PI_SelectAd_BC,
        output wire PI_SelectAd_DE,
        output wire PI_SelectDt_A,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PR_Write_A,
        output wire PR_InvertIn,
        output wire P2_Set_ILDlnnlHL_0,
        output wire P2_Set_ILDHLlnnl_0,
        output wire P2_Set_ILDlnnlA_0,
        output wire P2_Set_ILDAlnnl_0,
        output wire PA_Select_0x1_low,
        output wire PA_SUB,
        output wire PA_Select_BC_high,
        output wire PR_Write_B,
        output wire PR_Write_C,
        output wire PA_Select_DE_high,
        output wire PR_Write_D,
        output wire PR_Write_E,
        output wire PA_Select_SP_high, 
        output wire PR_Write_SP_high, // <
        output wire PR_Write_SP_low, // >
        output wire PA_Select_B_high,
        output wire PA_Select_C_high,
        output wire PA_Select_D_high,
        output wire PA_Select_E_high,
        output wire PA_Select_H_high,
        output wire PA_Select_L_high,
        output wire PA_Select_A_high,
        output wire PF_Write_S,
        output wire PF_Write_Z,
        output wire PF_Write_PV,// <
        output wire PF_Select_S_bit7,
        output wire PF_Select_Z_bit24, // >
        output wire PF_Select_PV_bit25,
        output wire PF_Select_H_bit21,
        output wire PF_Select_H_bit22,
        output wire PF_Select_N_bit17,
        output wire PI_SelectAd_HL,
        output wire PR_Write_Dt,
        output wire PA_Select_Dt_high,
        output wire PI_SelectDt_Dt,
        output wire P2_Set_ILDrn_B,
        output wire P2_Set_ILDrn_C,
        output wire P2_Set_ILDrn_D,
        output wire P2_Set_ILDrn_E,
        output wire P2_Set_ILDrn_H,
        output wire P2_Set_ILDrn_L,
        output wire P2_Set_ILDrn_A,
        output wire P2_Set_ILDlHLln,
        output wire PA_Select_0x99_low,
        output wire PF_Select_S_bit23,
        output wire PF_Select_Z_bit21,
        output wire PF_Select_C_bit29,
        output wire PF_Select_PV_bit27,
        output wire PF_Select_H_bit28,
        output wire PA_Select_0x60_low,
        output wire PA_Select_0x06_low,
        output wire PA_Select_0x66_low,
        output wire PA_Select_A_low,
        output wire PA_RLC,
        output wire PA_RL,
        output wire PA_RRC,
        output wire PA_RR,
        output wire PA_NOT,
        output wire PF_Select_C_bit38,
        output wire PF_Select_C_bit37,
        output wire PF_Select_H_bit16,
        output wire PF_Select_H_bit30,
        output wire PF_Select_H_bit17,
        output wire PF_Select_C_bit0,
        output wire PF_Select_C_bit17,
        output wire PA_Select_F_low,
        output wire PI_SelectDt_B,
        output wire PI_SelectDt_C,
        output wire PI_SelectDt_D,
        output wire PI_SelectDt_E,
        output wire PI_SelectDt_H,
        output wire PI_SelectDt_L,
        output wire PA_NOP,
        output wire PA_Select_B_low,
        output wire PA_Select_C_low,
        output wire PA_Select_D_low,
        output wire PA_Select_E_low,
        output wire PA_Select_H_low,
        output wire PA_Select_L_low,
        output wire PC_RA0,
        output wire PC_RA1,
        output wire PC_RA2,
        output wire PA_ADC,
        output wire PA_SBC,
        output wire PA_AND,
        output wire PA_XOR,
        output wire PA_OR,
        output wire PF_Select_C_bit23,
        output wire PF_Select_C_bit26,
        output wire PF_Select_C_bit16,
        output wire PI_SelectAd_SP,
        output wire PR_Inc_SP,
        output wire PR_Write_PC_low,
        output wire PR_Write_PC_high,
        output wire PR_Exx,
        output wire PR_Write_F,
        output wire PR_Write_Dtex,
        output wire PI_SelectDt_Dtex,
        output wire PI_SelectAdt1,
        output wire P2_Set_XBIT,
        output wire PR_Ex_DE_HL,
        output wire P2_Reset_IFF1, // <
        output wire P2_Reset_IFF2, // >
        output wire P2_Set_IFF1, // <
        output wire P2_Set_IFF2, // >
        output wire P2_Set_IJPccnn_0_0,
        output wire P2_Set_IJPccnn_1_0,
        output wire P2_Set_IJPccnn_2_0,
        output wire P2_Set_IJPccnn_3_0,
        output wire P2_Set_IJPccnn_4_0,
        output wire P2_Set_IJPccnn_5_0,
        output wire P2_Set_IJPccnn_6_0,
        output wire P2_Set_IJPccnn_7_0,
        output wire P2_Set_IJPnn_0,
        output wire P2_Set_IOUTlnlA,
        output wire P2_Set_IINAlnl,
        output wire PR_Dec_SP,
        output wire PI_SelectDt_F,
        output wire P2_Set_ICALLccnn_0_0,
        output wire P2_Set_ICALLccnn_1_0,
        output wire P2_Set_ICALLccnn_2_0,
        output wire P2_Set_ICALLccnn_3_0,
        output wire P2_Set_ICALLccnn_4_0,
        output wire P2_Set_ICALLccnn_5_0,
        output wire P2_Set_ICALLccnn_6_0,
        output wire P2_Set_ICALLccnn_7_0,
        output wire P2_Set_ICALLnn_0,
        output wire P2_Set_XIX,
        output wire P2_Set_XOTR,
        output wire P2_Set_XIY,
        output wire P2_Set_CMA,
        output wire P2_Set_IADDAn,
        output wire P2_Set_IADCAn,
        output wire P2_Set_ISUBAn,
        output wire P2_Set_ISBCAn,
        output wire P2_Set_IANDn,
        output wire P2_Set_IXORn,
        output wire P2_Set_IORn,
        output wire P2_Set_ICPn,
        output wire PI_SelectDt_PC_high,
        output wire PI_SelectDt_PC_low,
        output wire PA_Select_0x8_low,
        output wire PA_Select_0x10_low,
        output wire PA_Select_0x18_low,
        output wire PA_Select_0x20_low,
        output wire PA_Select_0x28_low,
        output wire PA_Select_0x30_low,
        output wire PA_Select_0x38_low
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _01110110 = ~(not_enable | Source[7] | notSource[6] | notSource[5] | notSource[4] | Source[3] | notSource[2] | notSource[1] | Source[0]); // 15
    
    wire _enable_not_halt = not_enable ~| _01110110;
    wire _not_enable_not_halt = _enable_not_halt ~| _enable_not_halt;

    wire _00xxxxxx;
    wire _01xxxxxx;
    wire _10xxxxxx;
    wire _11xxxxxx;

    DECODER_2bit_decoder d_ddxxxxxx( // 8
        .notEnable(_not_enable_not_halt),
        .In(Source[7:6]),
        .notIn(notSource[7:6]),
        .out00(_00xxxxxx),
        .out01(_01xxxxxx),
        .out10(_10xxxxxx),
        .out11(_11xxxxxx)
    );

    //
    // XPT
    //

    // 2

    assign _decodedXPT[2] = ~(_not_enable_not_halt | XPT[4] | XPT[3] | XPT[2] | notXPT[1] | XPT[0]); // 9

    assign PR_Inc_PC = _decodedXPT[2];

    wire _PR_Reset_XPT_halt; // <
    wire _P2_Set_CM1_halt;
    wire _Pa_Ophd_halt; // >

    DECODER_op_X1_01110110 d01110110(
        .enable(_01110110),
        .XPT(XPT),
        .notXPT(notXPT),
        .P2_Set_LHALT(P2_Set_LHALT),
        .PR_Reset_XPT(_PR_Reset_XPT_halt), // <
        .P2_Set_CM1(_P2_Set_CM1_halt),
        .Pa_Ophd(_Pa_Ophd_halt) // >
    );

    wire _PR_Reset_XPT_00;
    wire _P2_Set_CM1_00; // <
    wire _Pa_Ophd_00; // >
    wire _P2_Set_CMR_00;
    wire _PA_ADD_00;
    wire _PR_Write_H_00;
    wire _PR_Write_L_00;
    wire _PF_Write_C_00;
    wire _PF_Write_N_00;
    wire _PF_Write_H_00;
    wire _PF_Select_N_bit16_00;
    wire _PA_Select_HL_low_00;
    wire _PI_SelectDt_A_00;
    wire _PC_R0_00;
    wire _PC_R1_00;
    wire _PC_R2_00;
    wire _PC_W0_00;
    wire _PC_W1_00;
    wire _PC_W2_00;
    wire _PR_Write_A_00;
    wire _PR_InvertIn_00;
    wire _PA_SUB_00;
    wire _PR_Write_B_00;
    wire _PR_Write_C_00;
    wire _PR_Write_D_00;
    wire _PR_Write_E_00;
    wire _PA_Select_A_high_00;
    wire _PF_Write_S_00;
    wire _PF_Write_Z_00;
    wire _PF_Write_PV_00; // <
    wire _PF_Select_S_bit7_00;
    wire _PF_Select_Z_bit24_00; // >
    wire _PF_Select_PV_bit25_00;
    wire _PF_Select_H_bit21_00;
    wire _PF_Select_H_bit22_00;
    wire _PF_Select_N_bit17_00;
    wire _PI_SelectAd_HL_00;
    wire _PR_Write_Dt_00;
    wire _PI_SelectDt_Dt_00;
    wire _PF_Select_PV_bit27_00;
    wire _PA_Select_A_low_00;
    wire _PF_Select_H_bit16_00;
    wire _PF_Select_H_bit17_00;
    wire _PR_Write_SP_high_00; // <
    wire _PR_Write_SP_low_00; // >

    DECODER_op_X1_00 d00(
        .enable(_00xxxxxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .Flag_H(Flag_H),
        .Flag_Z(Flag_Z),
        .Flag_C(Flag_C),
        .Flag_S(Flag_S),
        .Flag_N(Flag_N),
        .PR_Reset_XPT(_PR_Reset_XPT_00),
        .P2_Set_CM1(_P2_Set_CM1_00), // <
        .Pa_Ophd(_Pa_Ophd_00), // >
        .PR_Ex_AF_AF(PR_Ex_AF_AF),
        .P2_Set_CMR(_P2_Set_CMR_00),
        .P2_Set_IDJNZe(P2_Set_IDJNZe),
        .P2_Set_IJRNZe(P2_Set_IJRNZe),
        .P2_Set_IJRNCe(P2_Set_IJRNCe),
        .P2_Set_IJRe(P2_Set_IJRe),
        .P2_Set_IJRZe(P2_Set_IJRZe),
        .P2_Set_IJRCe(P2_Set_IJRCe),
        .P2_Set_ILDddnn_BC_0(P2_Set_ILDddnn_BC_0),
        .P2_Set_ILDddnn_DE_0(P2_Set_ILDddnn_DE_0),
        .P2_Set_ILDddnn_HL_0(P2_Set_ILDddnn_HL_0),
        .P2_Set_ILDddnn_SP_0(P2_Set_ILDddnn_SP_0),
        .PA_ADD(_PA_ADD_00),
        .PR_Write_H(_PR_Write_H_00),
        .PR_Write_L(_PR_Write_L_00),
        .PF_Write_C(_PF_Write_C_00),
        .PF_Write_N(_PF_Write_N_00),
        .PF_Write_H(_PF_Write_H_00),
        .PF_Select_C_bit32(PF_Select_C_bit32),
        .PF_Select_N_bit16(_PF_Select_N_bit16_00),
        .PF_Select_H_bit31(PF_Select_H_bit31),
        .PA_Select_HL_high(PA_Select_HL_high),
        .PA_Select_BC_low(PA_Select_BC_low),
        .PA_Select_DE_low(PA_Select_DE_low),
        .PA_Select_HL_low(_PA_Select_HL_low_00),
        .PA_Select_SP_low(PA_Select_SP_low),
        .PI_SelectAd_BC(PI_SelectAd_BC),
        .PI_SelectAd_DE(PI_SelectAd_DE),
        .PI_SelectDt_A(_PI_SelectDt_A_00),
        .PC_R0(_PC_R0_00),
        .PC_R1(_PC_R1_00),
        .PC_R2(_PC_R2_00),
        .PC_W0(_PC_W0_00),
        .PC_W1(_PC_W1_00),
        .PC_W2(_PC_W2_00),
        .PR_Write_A(_PR_Write_A_00),
        .PR_InvertIn(_PR_InvertIn_00),
        .P2_Set_ILDlnnlHL_0(P2_Set_ILDlnnlHL_0),
        .P2_Set_ILDHLlnnl_0(P2_Set_ILDHLlnnl_0),
        .P2_Set_ILDlnnlA_0(P2_Set_ILDlnnlA_0),
        .P2_Set_ILDAlnnl_0(P2_Set_ILDAlnnl_0),
        .PA_Select_0x1_low(PA_Select_0x1_low),
        .PA_SUB(_PA_SUB_00),
        .PA_Select_BC_high(PA_Select_BC_high),
        .PR_Write_B(_PR_Write_B_00),
        .PR_Write_C(_PR_Write_C_00),
        .PA_Select_DE_high(PA_Select_DE_high),
        .PR_Write_D(_PR_Write_D_00),
        .PR_Write_E(_PR_Write_E_00),
        .PA_Select_SP_high(PA_Select_SP_high), // <
        .PR_Write_SP_high(_PR_Write_SP_high_00),
        .PR_Write_SP_low(_PR_Write_SP_low_00), // >
        .PA_Select_B_high(PA_Select_B_high),
        .PA_Select_C_high(PA_Select_C_high),
        .PA_Select_D_high(PA_Select_D_high),
        .PA_Select_E_high(PA_Select_E_high),
        .PA_Select_H_high(PA_Select_H_high),
        .PA_Select_L_high(PA_Select_L_high),
        .PA_Select_A_high(_PA_Select_A_high_00),
        .PF_Write_S(_PF_Write_S_00),
        .PF_Write_Z(_PF_Write_Z_00),
        .PF_Write_PV(_PF_Write_PV_00), // <
        .PF_Select_S_bit7(_PF_Select_S_bit7_00),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_00), // >
        .PF_Select_PV_bit25(_PF_Select_PV_bit25_00),
        .PF_Select_H_bit21(_PF_Select_H_bit21_00),
        .PF_Select_H_bit22(_PF_Select_H_bit22_00),
        .PF_Select_N_bit17(_PF_Select_N_bit17_00),
        .PI_SelectAd_HL(_PI_SelectAd_HL_00),
        .PR_Write_Dt(_PR_Write_Dt_00),
        .PA_Select_Dt_high(PA_Select_Dt_high),
        .PI_SelectDt_Dt(_PI_SelectDt_Dt_00),
        .P2_Set_ILDrn_B(P2_Set_ILDrn_B),
        .P2_Set_ILDrn_C(P2_Set_ILDrn_C),
        .P2_Set_ILDrn_D(P2_Set_ILDrn_D),
        .P2_Set_ILDrn_E(P2_Set_ILDrn_E),
        .P2_Set_ILDrn_H(P2_Set_ILDrn_H),
        .P2_Set_ILDrn_L(P2_Set_ILDrn_L),
        .P2_Set_ILDrn_A(P2_Set_ILDrn_A),
        .P2_Set_ILDlHLln(P2_Set_ILDlHLln),
        .PA_Select_0x99_low(PA_Select_0x99_low),
        .PF_Select_S_bit23(PF_Select_S_bit23),
        .PF_Select_Z_bit21(PF_Select_Z_bit21),
        .PF_Select_C_bit29(PF_Select_C_bit29),
        .PF_Select_PV_bit27(_PF_Select_PV_bit27_00),
        .PF_Select_H_bit28(PF_Select_H_bit28),
        .PA_Select_0x60_low(PA_Select_0x60_low),
        .PA_Select_0x06_low(PA_Select_0x06_low),
        .PA_Select_0x66_low(PA_Select_0x66_low),
        .PA_Select_A_low(_PA_Select_A_low_00),
        .PA_RLC(PA_RLC),
        .PA_RL(PA_RL),
        .PA_RRC(PA_RRC),
        .PA_RR(PA_RR),
        .PA_NOT(PA_NOT),
        .PF_Select_C_bit38(PF_Select_C_bit38),
        .PF_Select_C_bit37(PF_Select_C_bit37),
        .PF_Select_H_bit16(_PF_Select_H_bit16_00),
        .PF_Select_H_bit30(PF_Select_H_bit30),
        .PF_Select_H_bit17(_PF_Select_H_bit17_00),
        .PF_Select_C_bit0(PF_Select_C_bit0),
        .PF_Select_C_bit17(PF_Select_C_bit17),
        .PA_Select_F_low(PA_Select_F_low)
    );

    wire _PI_SelectAd_HL_01;
    wire _PC_R0_01;
    wire _PC_R1_01;
    wire _PC_R2_01;
    wire _PR_Reset_XPT_01; // <
    wire _P2_Set_CM1_01;
    wire _Pa_Ophd_01; // >
    wire _PR_Write_B_01;
    wire _PR_Write_C_01;
    wire _PR_Write_D_01;
    wire _PR_Write_E_01;
    wire _PR_Write_H_01;
    wire _PR_Write_L_01;
    wire _PR_Write_A_01;
    wire _PR_InvertIn_01;
    wire _PC_W0_01;
    wire _PC_W1_01;
    wire _PC_W2_01;
    wire _PI_SelectDt_B_01;
    wire _PI_SelectDt_C_01;
    wire _PI_SelectDt_D_01;
    wire _PI_SelectDt_E_01;
    wire _PI_SelectDt_H_01;
    wire _PI_SelectDt_L_01;
    wire _PI_SelectDt_A_01;
    wire _PA_NOP_01;
    wire _PA_Select_B_low_01;
    wire _PA_Select_C_low_01;
    wire _PA_Select_D_low_01;
    wire _PA_Select_E_low_01;
    wire _PA_Select_H_low_01;
    wire _PA_Select_L_low_01;
    wire _PA_Select_A_low_01;

    DECODER_op_X1_01 d01(
        .enable(_01xxxxxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PI_SelectAd_HL(_PI_SelectAd_HL_01),
        .PC_R0(_PC_R0_01),
        .PC_R1(_PC_R1_01),
        .PC_R2(_PC_R2_01),
        .PR_Reset_XPT(_PR_Reset_XPT_01), // <
        .P2_Set_CM1(_P2_Set_CM1_01),
        .Pa_Ophd(_Pa_Ophd_01), // >
        .PR_Write_B(_PR_Write_B_01),
        .PR_Write_C(_PR_Write_C_01),
        .PR_Write_D(_PR_Write_D_01),
        .PR_Write_E(_PR_Write_E_01),
        .PR_Write_H(_PR_Write_H_01),
        .PR_Write_L(_PR_Write_L_01),
        .PR_Write_A(_PR_Write_A_01),
        .PR_InvertIn(_PR_InvertIn_01),
        .PC_W0(_PC_W0_01),
        .PC_W1(_PC_W1_01),
        .PC_W2(_PC_W2_01),
        .PI_SelectDt_B(_PI_SelectDt_B_01),
        .PI_SelectDt_C(_PI_SelectDt_C_01),
        .PI_SelectDt_D(_PI_SelectDt_D_01),
        .PI_SelectDt_E(_PI_SelectDt_E_01),
        .PI_SelectDt_H(_PI_SelectDt_H_01),
        .PI_SelectDt_L(_PI_SelectDt_L_01),
        .PI_SelectDt_A(_PI_SelectDt_A_01),
        .PA_NOP(_PA_NOP_01),
        .PA_Select_B_low(_PA_Select_B_low_01),
        .PA_Select_C_low(_PA_Select_C_low_01),
        .PA_Select_D_low(_PA_Select_D_low_01),
        .PA_Select_E_low(_PA_Select_E_low_01),
        .PA_Select_H_low(_PA_Select_H_low_01),
        .PA_Select_L_low(_PA_Select_L_low_01),
        .PA_Select_A_low(_PA_Select_A_low_01)
    );

    wire _PI_SelectAd_HL_10;
    wire _PA_Select_B_low_10;
    wire _PA_Select_C_low_10;
    wire _PA_Select_D_low_10;
    wire _PA_Select_E_low_10;
    wire _PA_Select_H_low_10;
    wire _PA_Select_L_low_10;
    wire _PA_Select_A_low_10;
    wire _PR_Reset_XPT_10; // <
    wire _P2_Set_CM1_10;
    wire _Pa_Ophd_10;
    wire _PA_Select_A_high_10;
    wire _PR_InvertIn_10;
    wire _PF_Write_S_10;
    wire _PF_Write_Z_10;
    wire _PF_Write_H_10;
    wire _PF_Write_PV_10;
    wire _PF_Write_N_10;
    wire _PF_Write_C_10;
    wire _PF_Select_S_bit7_10;
    wire _PF_Select_Z_bit24_10; // >
    wire _PR_Write_A_10;
    wire _PA_ADD_10;
    wire _PA_SUB_10;
    wire _PF_Select_H_bit21_10;
    wire _PF_Select_H_bit22_10;
    wire _PF_Select_N_bit17_10;
    wire _PF_Select_PV_bit25_10;
    wire _PF_Select_H_bit17_10;
    wire _PF_Select_H_bit16_10;
    wire _PF_Select_PV_bit27_10;
    wire _PF_Select_N_bit16_10;

    DECODER_op_X1_10 d10(
        .enable(_10xxxxxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PI_SelectAd_HL(_PI_SelectAd_HL_10),
        .PC_RA0(PC_RA0),
        .PC_RA1(PC_RA1),
        .PC_RA2(PC_RA2),
        .PA_Select_B_low(_PA_Select_B_low_10),
        .PA_Select_C_low(_PA_Select_C_low_10),
        .PA_Select_D_low(_PA_Select_D_low_10),
        .PA_Select_E_low(_PA_Select_E_low_10),
        .PA_Select_H_low(_PA_Select_H_low_10),
        .PA_Select_L_low(_PA_Select_L_low_10),
        .PA_Select_A_low(_PA_Select_A_low_10),
        .PR_Reset_XPT(_PR_Reset_XPT_10), // <
        .P2_Set_CM1(_P2_Set_CM1_10),
        .Pa_Ophd(_Pa_Ophd_10),
        .PA_Select_A_high(_PA_Select_A_high_10),
        .PR_InvertIn(_PR_InvertIn_10),
        .PF_Write_S(_PF_Write_S_10),
        .PF_Write_Z(_PF_Write_Z_10),
        .PF_Write_H(_PF_Write_H_10),
        .PF_Write_PV(_PF_Write_PV_10),
        .PF_Write_N(_PF_Write_N_10),
        .PF_Write_C(_PF_Write_C_10),
        .PF_Select_S_bit7(_PF_Select_S_bit7_10),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_10), // >
        .PR_Write_A(_PR_Write_A_10),
        .PA_ADD(_PA_ADD_10),
        .PA_ADC(PA_ADC),
        .PA_SUB(_PA_SUB_10),
        .PA_SBC(PA_SBC),
        .PA_AND(PA_AND),
        .PA_XOR(PA_XOR),
        .PA_OR(PA_OR),
        .PF_Select_H_bit21(_PF_Select_H_bit21_10), // <
        .PF_Select_C_bit23(PF_Select_C_bit23), // >
        .PF_Select_H_bit22(_PF_Select_H_bit22_10), // <
        .PF_Select_N_bit17(_PF_Select_N_bit17_10),
        .PF_Select_C_bit26(PF_Select_C_bit26), // >
        .PF_Select_PV_bit25(_PF_Select_PV_bit25_10),
        .PF_Select_H_bit17(_PF_Select_H_bit17_10),
        .PF_Select_H_bit16(_PF_Select_H_bit16_10),
        .PF_Select_PV_bit27(_PF_Select_PV_bit27_10), // <
        .PF_Select_C_bit16(PF_Select_C_bit16), // >
        .PF_Select_N_bit16(_PF_Select_N_bit16_10)
    );

    wire _PR_Reset_XPT_11;
    wire _P2_Set_CM1_11;
    wire _Pa_Ophd_11;
    wire _PC_R0_11;
    wire _PC_R1_11;
    wire _PC_R2_11;
    wire _PR_InvertIn_11;
    wire _PA_NOP_11;
    wire _PA_Select_HL_low_11;
    wire _PR_Write_SP_11;
    wire _PR_Write_B_11;
    wire _PR_Write_C_11;
    wire _PR_Write_D_11;
    wire _PR_Write_E_11;
    wire _PR_Write_H_11;
    wire _PR_Write_L_11;
    wire _PR_Write_A_11;
    wire _PR_Write_Dt_11;
    wire _PC_W0_11;
    wire _PC_W1_11;
    wire _PC_W2_11;
    wire _PI_SelectDt_Dt_11;
    wire _P2_Set_CMR_11;
    wire _PI_SelectDt_B_11;
    wire _PI_SelectDt_C_11;
    wire _PI_SelectDt_D_11;
    wire _PI_SelectDt_E_11;
    wire _PI_SelectDt_H_11;
    wire _PI_SelectDt_L_11;
    wire _PI_SelectDt_A_11;

    DECODER_op_X1_11 d11(
        .enable(_11xxxxxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .Flag_Z(Flag_Z),
        .Flag_C(Flag_C),
        .Flag_PV(Flag_PV),
        .Flag_S(Flag_S),
        .PR_Reset_XPT(_PR_Reset_XPT_11),
        .P2_Set_CM1(_P2_Set_CM1_11),
        .Pa_Ophd(_Pa_Ophd_11),
        .PI_SelectAd_SP(PI_SelectAd_SP),
        .PC_R0(_PC_R0_11),
        .PC_R1(_PC_R1_11),
        .PC_R2(_PC_R2_11),
        .PR_Inc_SP(PR_Inc_SP),
        .PR_Write_PC_low(PR_Write_PC_low),
        .PR_Write_PC_high(PR_Write_PC_high),
        .PR_InvertIn(_PR_InvertIn_11),
        .PA_NOP(_PA_NOP_11),
        .PA_Select_HL_low(_PA_Select_HL_low_11),
        .PR_Write_SP(_PR_Write_SP_11),
        .PR_Exx(PR_Exx),
        .PR_Write_B(_PR_Write_B_11),
        .PR_Write_C(_PR_Write_C_11),
        .PR_Write_D(_PR_Write_D_11),
        .PR_Write_E(_PR_Write_E_11),
        .PR_Write_H(_PR_Write_H_11),
        .PR_Write_L(_PR_Write_L_11),
        .PR_Write_A(_PR_Write_A_11),
        .PR_Write_F(PR_Write_F),
        .PR_Write_Dt(_PR_Write_Dt_11),// <
        .PR_Write_Dtex(PR_Write_Dtex), // >
        .PC_W0(_PC_W0_11),
        .PC_W1(_PC_W1_11),
        .PC_W2(_PC_W2_11),
        .PI_SelectDt_Dt(_PI_SelectDt_Dt_11),
        .PI_SelectDt_Dtex(PI_SelectDt_Dtex),
        .PI_SelectAdt1(PI_SelectAdt1),
        .P2_Set_XBIT(P2_Set_XBIT),
        .PR_Ex_DE_HL(PR_Ex_DE_HL),
        .P2_Reset_IFF1(P2_Reset_IFF1), // <
        .P2_Reset_IFF2(P2_Reset_IFF2), // >
        .P2_Set_IFF1(P2_Set_IFF1), // <
        .P2_Set_IFF2(P2_Set_IFF2), // >
        .P2_Set_CMR(_P2_Set_CMR_11),
        .P2_Set_IJPccnn_0_0(P2_Set_IJPccnn_0_0),
        .P2_Set_IJPccnn_1_0(P2_Set_IJPccnn_1_0),
        .P2_Set_IJPccnn_2_0(P2_Set_IJPccnn_2_0),
        .P2_Set_IJPccnn_3_0(P2_Set_IJPccnn_3_0),
        .P2_Set_IJPccnn_4_0(P2_Set_IJPccnn_4_0),
        .P2_Set_IJPccnn_5_0(P2_Set_IJPccnn_5_0),
        .P2_Set_IJPccnn_6_0(P2_Set_IJPccnn_6_0),
        .P2_Set_IJPccnn_7_0(P2_Set_IJPccnn_7_0),
        .P2_Set_IJPnn_0(P2_Set_IJPnn_0),
        .P2_Set_IOUTlnlA(P2_Set_IOUTlnlA),
        .P2_Set_IINAlnl(P2_Set_IINAlnl),
        .PR_Dec_SP(PR_Dec_SP),
        .PI_SelectDt_B(_PI_SelectDt_B_11),
        .PI_SelectDt_C(_PI_SelectDt_C_11),
        .PI_SelectDt_D(_PI_SelectDt_D_11),
        .PI_SelectDt_E(_PI_SelectDt_E_11),
        .PI_SelectDt_H(_PI_SelectDt_H_11),
        .PI_SelectDt_L(_PI_SelectDt_L_11),
        .PI_SelectDt_A(_PI_SelectDt_A_11),
        .PI_SelectDt_F(PI_SelectDt_F),
        .P2_Set_ICALLccnn_0_0(P2_Set_ICALLccnn_0_0),
        .P2_Set_ICALLccnn_1_0(P2_Set_ICALLccnn_1_0),
        .P2_Set_ICALLccnn_2_0(P2_Set_ICALLccnn_2_0),
        .P2_Set_ICALLccnn_3_0(P2_Set_ICALLccnn_3_0),
        .P2_Set_ICALLccnn_4_0(P2_Set_ICALLccnn_4_0),
        .P2_Set_ICALLccnn_5_0(P2_Set_ICALLccnn_5_0),
        .P2_Set_ICALLccnn_6_0(P2_Set_ICALLccnn_6_0),
        .P2_Set_ICALLccnn_7_0(P2_Set_ICALLccnn_7_0),
        .P2_Set_ICALLnn_0(P2_Set_ICALLnn_0),
        .P2_Set_XIX(P2_Set_XIX),
        .P2_Set_XOTR(P2_Set_XOTR),
        .P2_Set_XIY(P2_Set_XIY),
        .P2_Set_CMA(P2_Set_CMA),
        .P2_Set_IADDAn(P2_Set_IADDAn),
        .P2_Set_IADCAn(P2_Set_IADCAn),
        .P2_Set_ISUBAn(P2_Set_ISUBAn),
        .P2_Set_ISBCAn(P2_Set_ISBCAn),
        .P2_Set_IANDn(P2_Set_IANDn),
        .P2_Set_IXORn(P2_Set_IXORn),
        .P2_Set_IORn(P2_Set_IORn),
        .P2_Set_ICPn(P2_Set_ICPn),
        .PI_SelectDt_PC_high(PI_SelectDt_PC_high),
        .PI_SelectDt_PC_low(PI_SelectDt_PC_low),
        .PA_Select_0x8_low(PA_Select_0x8_low),
        .PA_Select_0x10_low(PA_Select_0x10_low),
        .PA_Select_0x18_low(PA_Select_0x18_low),
        .PA_Select_0x20_low(PA_Select_0x20_low),
        .PA_Select_0x28_low(PA_Select_0x28_low),
        .PA_Select_0x30_low(PA_Select_0x30_low),
        .PA_Select_0x38_low(PA_Select_0x38_low)
    );

    wire _end_h123 = (_PR_Reset_XPT_halt | _PR_Reset_XPT_01 | _PR_Reset_XPT_10); // 4
    assign PR_Reset_XPT = (_end_h123 | _PR_Reset_XPT_00 | _PR_Reset_XPT_11); // 4
    wire _end_h0123 = (_end_h123 | _P2_Set_CM1_00); // 2
    assign P2_Set_CM1 = (_end_h0123 | _P2_Set_CM1_11); // 2
    assign Pa_Ophd = (_end_h0123 | _Pa_Ophd_11); // 2

    assign P2_Set_CMR = (_P2_Set_CMR_00 | _P2_Set_CMR_11); // 2

    assign PC_R0 = (_PC_R0_00 | _PC_R0_01 | _PC_R0_11); // 4
    assign PC_R1 = (_PC_R1_00 | _PC_R1_01 | _PC_R1_11); // 4
    assign PC_R2 = (_PC_R2_00 | _PC_R2_01 | _PC_R2_11); // 4
    assign PC_W0 = (_PC_W0_00 | _PC_W0_01 | _PC_W0_11); // 4
    assign PC_W1 = (_PC_W1_00 | _PC_W1_01 | _PC_W1_11); // 4
    assign PC_W2 = (_PC_W2_00 | _PC_W2_01 | _PC_W2_11); // 4
    assign PA_ADD = (_PA_ADD_00 | _PA_ADD_10); // 2
    assign PA_SUB = (_PA_SUB_00 | _PA_SUB_10); // 2
    assign PA_NOP = (_PA_NOP_01 | _PA_NOP_11); // 2
    assign PR_Write_A = (_PR_Write_A_00 | _PR_Write_A_01 | _PR_Write_A_10 | _PR_Write_A_11); // 6
    assign PR_Write_B = (_PR_Write_B_00 | _PR_Write_B_01 | _PR_Write_B_11); // 4
    assign PR_Write_C = (_PR_Write_C_00 | _PR_Write_C_01 | _PR_Write_C_11); // 4
    assign PR_Write_D = (_PR_Write_D_00 | _PR_Write_D_01 | _PR_Write_D_11); // 4
    assign PR_Write_E = (_PR_Write_E_00 | _PR_Write_E_01 | _PR_Write_E_11); // 4
    assign PR_Write_H = (_PR_Write_H_00 | _PR_Write_H_01 | _PR_Write_H_11); // 4
    assign PR_Write_L = (_PR_Write_L_00 | _PR_Write_L_01 | _PR_Write_L_11); // 4
    assign PR_Write_Dt = (_PR_Write_Dt_00 | _PR_Write_Dt_11); // 2
    assign PF_Write_C = (_PF_Write_C_00 | _PF_Write_C_10); // 2
    assign PF_Write_N = (_PF_Write_N_00 | _PF_Write_N_10); // 2
    assign PF_Write_H = (_PF_Write_H_00 | _PF_Write_H_10); // 2
    assign PF_Write_S = (_PF_Write_S_00 | _PF_Write_S_10); // 2
    assign PF_Write_Z = (_PF_Write_Z_00 | _PF_Write_Z_10); // 2
    assign PI_SelectDt_A = (_PI_SelectDt_A_00 | _PI_SelectDt_A_01 | _PI_SelectDt_A_11); // 4
    assign PI_SelectDt_B = (_PI_SelectDt_B_01 | _PI_SelectDt_B_11); // 2
    assign PI_SelectDt_C = (_PI_SelectDt_C_01 | _PI_SelectDt_C_11); // 2
    assign PI_SelectDt_D = (_PI_SelectDt_D_01 | _PI_SelectDt_D_11); // 2
    assign PI_SelectDt_E = (_PI_SelectDt_E_01 | _PI_SelectDt_E_11); // 2
    assign PI_SelectDt_H = (_PI_SelectDt_H_01 | _PI_SelectDt_H_11); // 2
    assign PI_SelectDt_L = (_PI_SelectDt_L_01 | _PI_SelectDt_L_11); // 2
    assign PF_Select_N_bit16 = (_PF_Select_N_bit16_00 | _PF_Select_N_bit16_10); // 2
    assign PA_Select_HL_low = (_PA_Select_HL_low_00 | _PA_Select_HL_low_11); // 2
    assign PA_Select_A_high = (_PA_Select_A_high_00 | _PA_Select_A_high_10); // 2
    assign PF_Select_PV_bit25 = (_PF_Select_PV_bit25_00 | _PF_Select_PV_bit25_10); // 2
    assign PF_Select_H_bit21 = (_PF_Select_H_bit21_00 | _PF_Select_H_bit21_10); // 2
    assign PF_Select_H_bit22 = (_PF_Select_H_bit22_00 | _PF_Select_H_bit22_10); // 2
    assign PF_Select_N_bit17 = (_PF_Select_N_bit17_00 | _PF_Select_N_bit17_10); // 2
    assign PF_Select_PV_bit27 = (_PF_Select_PV_bit27_00 | _PF_Select_PV_bit27_00); // 2
    assign PF_Select_H_bit16 = (_PF_Select_H_bit16_00 | _PF_Select_H_bit16_10); // 2
    assign PF_Select_H_bit17 = (_PF_Select_H_bit17_00 | _PF_Select_H_bit17_10); // 2
    assign PI_SelectAd_HL = (_PI_SelectAd_HL_00 | _PI_SelectAd_HL_01 | _PI_SelectAd_HL_10); // 4
    assign PI_SelectDt_Dt = (_PI_SelectDt_Dt_00 | _PI_SelectDt_Dt_11); // 2
    assign PR_InvertIn = (_PR_InvertIn_00 | _PR_InvertIn_01 | _PR_InvertIn_10 | _PR_InvertIn_11); // 6
    assign PA_Select_A_low = (_PA_Select_A_low_00 | _PA_Select_A_low_01 | _PA_Select_A_low_10); // 4
    assign PA_Select_B_low = (_PA_Select_B_low_01 | _PA_Select_B_low_10); // 2
    assign PA_Select_C_low = (_PA_Select_C_low_01 | _PA_Select_C_low_10); // 2
    assign PA_Select_D_low = (_PA_Select_D_low_01 | _PA_Select_D_low_10); // 2
    assign PA_Select_E_low = (_PA_Select_E_low_01 | _PA_Select_E_low_10); // 2
    assign PA_Select_H_low = (_PA_Select_H_low_01 | _PA_Select_H_low_10); // 2
    assign PA_Select_L_low = (_PA_Select_L_low_01 | _PA_Select_L_low_10); // 2

    assign PF_Write_PV = (_PF_Write_PV_00 | _PF_Write_PV_10); // 2
    assign PF_Select_S_bit7 = PF_Write_PV;
    assign PF_Select_Z_bit24 = PF_Write_PV;

    assign PR_Write_SP_high = (_PR_Write_SP_high_00 | _PR_Write_SP_11); // 2
    assign PR_Write_SP_low = PR_Write_SP_high;

endmodule
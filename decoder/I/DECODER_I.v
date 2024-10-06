// 112(1408)
module DECODER_I(
        input wire not_decodingIn,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        input wire Flag_C,
        input wire Flag_Z,
        input wire notIsResultLow0,
        input wire OP7,
        input wire notOP7,
        input wire Flag_PV,
        input wire Flag_S,
        output wire not_decodingOut,
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
        output wire PF_Select_PV_bit25,
        output wire PR_Write_IX_low,
        output wire PR_Write_IY_low,
        output wire P2_Set_ILDlnnlA_1,
        output wire P2_Set_ILDIXnn_1,
        output wire P2_Set_ILDHLlnnl_1,
        output wire P2_Set_ILDIYnn_1,
        output wire P2_Set_ILDIXlnnl_1,
        output wire P2_Set_ILDIYlnnl_1,
        output wire P2_Set_ICALLnn_1,
        output wire PR_Write_IX_high,
        output wire PR_Write_IY_high,
        output wire PR_Dec_SP,
        output wire PI_SelectDt_PC_high,
        output wire PI_SelectAd_SP,
        output wire PI_SelectDt_PC_low,
        output wire PA_Select_OPOPold_low,
        output wire PC_I0,
        output wire PC_I1,
        output wire PC_I2,
        output wire PC_I3,
        output wire PC_O0,
        output wire PC_O1,
        output wire PC_O2,
        output wire PC_O3,
        output wire PI_SelectAd_AOP,
        output wire P2_Set_ILDlnnlIX_1,
        output wire P2_Set_ILDlnnlIY_1,
        output wire PI_SelectDt_IX_low,
        output wire PI_SelectDt_IY_low,
        output wire PI_SelectDt_IX_high,
        output wire PI_SelectDt_IY_high,
        output wire PA_Select_PC_high,
        output wire PA_Select_0xffOP_low,
        output wire PA_Select_B_high,
        output wire PA_Select_0x1_low,
        output wire P2_Set_IJPccnn_0_1,
        output wire P2_Set_IJPccnn_1_1,
        output wire P2_Set_IJPccnn_2_1,
        output wire P2_Set_IJPccnn_3_1,
        output wire P2_Set_IJPccnn_4_1,
        output wire P2_Set_IJPccnn_5_1,
        output wire P2_Set_IJPccnn_6_1,
        output wire P2_Set_IJPccnn_7_1,
        output wire P2_Set_ICALLccnn_0_1,
        output wire P2_Set_ICALLccnn_1_1,
        output wire P2_Set_ICALLccnn_2_1,
        output wire P2_Set_ICALLccnn_3_1,
        output wire P2_Set_ICALLccnn_4_1,
        output wire P2_Set_ICALLccnn_5_1,
        output wire P2_Set_ICALLccnn_6_1,
        output wire P2_Set_ICALLccnn_7_1,
        output wire PC_RA0,
        output wire PC_RA1,
        output wire PC_RA2,
        output wire PA_Select_Dt_high,
        output wire PI_SelectAd_ALU,
        output wire PI_SelectDt_Dt,
        output wire P2_Set_ILDlIXtdln_1,
        output wire P2_Set_ILDlIYtdln_1,
        output wire PA_Select_OPold_low
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _xxxx0xxx;
    wire _xxxx1xxx;

    DECODER_1bit_decoder d_xxxxdxxx(
        .notEnable(not_decodingIn),
        .In(ITABLE[3]),
        .notIn(notITABLE[3]),
        .out0(_xxxx0xxx),
        .out1(_xxxx1xxx),
    );

    wire _PI_SelectDt_OP_0;
    wire _PC_W0_0;
    wire _PC_W1_0;
    wire _PC_W2_0;
    wire _PR_Reset_XPT_0;
    wire _P2_Set_CM1_0; // <
    wire _P2_Reset_ITABLE_0;
    wire _Pa_Ophd_0; // >
    wire _P2_Set_CMR_0;
    wire _PI_SelectAdt1_0;
    wire _PI_SelectAd_OPOPold_0;
    wire _PC_R0_0;
    wire _PC_R1_0;
    wire _PC_R2_0;
    wire _PR_Write_A_0;
    wire _PR_InvertIn_0;
    wire _P2_Set_CMA_0;
    wire _PA_Select_OP_high_0;
    wire _PA_NOP_0;
    wire _PR_Write_PC_high_0;
    wire _PR_Write_PC_low_0;
    wire _PR_Write_B_0;
    wire _PR_Write_H_0;
    wire _PR_Write_L_0;
    wire _PA_Select_IX_high_0;
    wire _PA_Select_IY_high_0;
    wire _PA_Select_OP_low_0;
    wire _PA_ADD_0;
    wire _PR_Write_Dt_0;
    wire _PR_Write_Dtex_0;
    wire _PI_SelectAd_DtexDt_0;
    wire _PI_SelectDt_A_0;
    wire _PA_Select_A_high_0;
    wire _PF_Write_S_0;
    wire _PF_Select_S_bit7_0;
    wire _PF_Write_Z_0;
    wire _PF_Select_Z_bit24_0;
    wire _PF_Write_H_0;
    wire _PF_Write_PV_0;
    wire _PF_Write_N_0;
    wire _PF_Write_C_0;
    wire _PA_ADC_0;
    wire _PA_SUB_0;
    wire _PA_SBC_0;
    wire _PA_AND_0;
    wire _PA_OR_0;
    wire _PA_XOR_0;
    wire _PF_Select_H_bit22_0;
    wire _PF_Select_N_bit17_0;
    wire _PF_Select_C_bit26_0;
    wire _PF_Select_H_bit21_0;
    wire _PF_Select_C_bit23_0;
    wire _PF_Select_H_bit16_0;
    wire _PF_Select_PV_bit27_0;
    wire _PF_Select_C_bit16_0;
    wire _PF_Select_H_bit17_0;
    wire _PF_Select_N_bit16_0;
    wire _PF_Select_PV_bit25_0;

    DECODER_I_xxxx0 dxxxx0(
        .enable(_xxxx0xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .not_is00000000(not_decodingOut),
        .PI_SelectAd_HL(PI_SelectAd_HL),
        .PI_SelectDt_OP(_PI_SelectDt_OP_0),
        .PC_W0(_PC_W0_0),
        .PC_W1(_PC_W1_0),
        .PC_W2(_PC_W2_0),
        .PR_Reset_XPT(_PR_Reset_XPT_0),
        .P2_Set_CM1(_P2_Set_CM1_0), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_0),
        .Pa_Ophd(_Pa_Ophd_0), // >
        .P2_Set_CMR(_P2_Set_CMR_0),
        .P2_Set_ILDlnnlHL_1(P2_Set_ILDlnnlHL_1),
        .PI_SelectDt_L(PI_SelectDt_L),
        .PI_SelectDt_H(PI_SelectDt_H),
        .PI_SelectAdt1(_PI_SelectAdt1_0),
        .PI_SelectAd_OPOPold(_PI_SelectAd_OPOPold_0),
        .P2_Set_ILDAlnnl_1(P2_Set_ILDAlnnl_1),
        .PC_R0(_PC_R0_0),
        .PC_R1(_PC_R1_0),
        .PC_R2(_PC_R2_0),
        .PR_Write_A(_PR_Write_A_0),
        .PR_InvertIn(_PR_InvertIn_0),
        .P2_Set_CMA(_P2_Set_CMA_0),
        .P2_Set_IJPnn_1(P2_Set_IJPnn_1),
        .PA_Select_OP_high(_PA_Select_OP_high_0),
        .PA_NOP(_PA_NOP_0),
        .PR_Write_PC_high(_PR_Write_PC_high_0),
        .PR_Write_PC_low(_PR_Write_PC_low_0),
        .PR_Write_B(_PR_Write_B_0),
        .PR_Write_C(PR_Write_C),
        .PR_Write_D(PR_Write_D),
        .PR_Write_E(PR_Write_E),
        .PR_Write_H(_PR_Write_H_0),
        .PR_Write_L(_PR_Write_L_0),
        .PA_Select_IX_high(_PA_Select_IX_high_0),
        .PA_Select_IY_high(_PA_Select_IY_high_0),
        .PA_Select_OP_low(_PA_Select_OP_low_0),
        .PA_ADD(_PA_ADD_0),
        .PR_Write_Dt(_PR_Write_Dt_0),
        .PR_Write_Dtex(_PR_Write_Dtex_0),
        .PI_SelectAd_DtexDt(_PI_SelectAd_DtexDt_0),
        .P2_Set_ILDddnn_BC_1(P2_Set_ILDddnn_BC_1),
        .P2_Set_ILDddnn_DE_1(P2_Set_ILDddnn_DE_1),
        .P2_Set_ILDddnn_HL_1(P2_Set_ILDddnn_HL_1),
        .P2_Set_ILDddnn_SP_1(P2_Set_ILDddnn_SP_1),
        .PR_Write_SP_low(PR_Write_SP_low),
        .PR_Write_SP_high(PR_Write_SP_high),
        .P2_Set_ILDddlnnl_BC_1(P2_Set_ILDddlnnl_BC_1),
        .P2_Set_ILDddlnnl_DE_1(P2_Set_ILDddlnnl_DE_1),
        .P2_Set_ILDddlnnl_HL_1(P2_Set_ILDddlnnl_HL_1),
        .P2_Set_ILDddlnnl_SP_1(P2_Set_ILDddlnnl_SP_1),
        .PI_SelectDt_A(_PI_SelectDt_A_0),
        .PI_SelectDt_B(PI_SelectDt_B),
        .PI_SelectDt_D(PI_SelectDt_D),
        .P2_Set_ILDlnnldd_BC_1(P2_Set_ILDlnnldd_BC_1),
        .P2_Set_ILDlnnldd_DE_1(P2_Set_ILDlnnldd_DE_1),
        .P2_Set_ILDlnnldd_HL_1(P2_Set_ILDlnnldd_HL_1),
        .P2_Set_ILDlnnldd_SP_1(P2_Set_ILDlnnldd_SP_1),
        .PI_SelectDt_SP_low(PI_SelectDt_SP_low),
        .PI_SelectDt_SP_high(PI_SelectDt_SP_high),
        .PA_Select_A_high(_PA_Select_A_high_0),
        .PF_Write_S(_PF_Write_S_0),
        .PF_Select_S_bit7(_PF_Select_S_bit7_0),
        .PF_Write_Z(_PF_Write_Z_0),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_0),
        .PF_Write_H(_PF_Write_H_0),
        .PF_Write_PV(_PF_Write_PV_0),
        .PF_Write_N(_PF_Write_N_0),
        .PF_Write_C(_PF_Write_C_0),
        .PA_ADC(_PA_ADC_0),
        .PA_SUB(_PA_SUB_0),
        .PA_SBC(_PA_SBC_0),
        .PA_AND(_PA_AND_0),
        .PA_OR(_PA_OR_0),
        .PA_XOR(_PA_XOR_0),
        .PF_Select_H_bit22(_PF_Select_H_bit22_0),
        .PF_Select_N_bit17(_PF_Select_N_bit17_0),
        .PF_Select_C_bit26(_PF_Select_C_bit26_0),
        .PF_Select_H_bit21(_PF_Select_H_bit21_0),
        .PF_Select_C_bit23(_PF_Select_C_bit23_0),
        .PF_Select_H_bit16(_PF_Select_H_bit16_0),
        .PF_Select_PV_bit27(_PF_Select_PV_bit27_0),
        .PF_Select_C_bit16(_PF_Select_C_bit16_0),
        .PF_Select_H_bit17(_PF_Select_H_bit17_0),
        .PF_Select_N_bit16(_PF_Select_N_bit16_0),
        .PF_Select_PV_bit25(_PF_Select_PV_bit25_0)
    );

    wire _PI_SelectDt_OP_1;
    wire _PC_W0_1;
    wire _PC_W1_1;
    wire _PC_W2_1;
    wire _PR_Reset_XPT_1;
    wire _P2_Set_CM1_1; // <
    wire _P2_Reset_ITABLE_1;
    wire _Pa_Ophd_1; // >
    wire _P2_Set_CMR_1;
    wire _PI_SelectAdt1_1;
    wire _PI_SelectAd_OPOPold_1;
    wire _PC_R0_1;
    wire _PC_R1_1;
    wire _PC_R2_1;
    wire _PR_Write_A_1;
    wire _PR_InvertIn_1;
    wire _P2_Set_CMA_1;
    wire _PA_Select_OP_high_1;
    wire _PA_NOP_1;
    wire _PR_Write_PC_high_1;
    wire _PR_Write_PC_low_1;
    wire _PR_Write_B_1;
    wire _PR_Write_H_1;
    wire _PR_Write_L_1;
    wire _PA_Select_IX_high_1;
    wire _PA_Select_IY_high_1;
    wire _PA_Select_OP_low_1;
    wire _PA_ADD_1;
    wire _PR_Write_Dt_1;
    wire _PR_Write_Dtex_1;
    wire _PI_SelectAd_DtexDt_1;
    wire _PI_SelectDt_A_1;
    wire _PA_Select_A_high_1;
    wire _PF_Write_S_1;
    wire _PF_Select_S_bit7_1;
    wire _PF_Write_Z_1;
    wire _PF_Select_Z_bit24_1;
    wire _PF_Write_H_1;
    wire _PF_Write_PV_1;
    wire _PF_Write_N_1;
    wire _PF_Write_C_1;
    wire _PA_ADC_1;
    wire _PA_SUB_1;
    wire _PA_SBC_1;
    wire _PA_AND_1;
    wire _PA_OR_1;
    wire _PA_XOR_1;
    wire _PF_Select_H_bit22_1;
    wire _PF_Select_N_bit17_1;
    wire _PF_Select_C_bit26_1;
    wire _PF_Select_H_bit21_1;
    wire _PF_Select_C_bit23_1;
    wire _PF_Select_H_bit16_1;
    wire _PF_Select_PV_bit27_1;
    wire _PF_Select_C_bit16_1;
    wire _PF_Select_H_bit17_1;
    wire _PF_Select_N_bit16_1;
    wire _PF_Select_PV_bit25_1;

    DECODER_I_xxxx1 dxxxx1(
        .enable(_xxxx1xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .Flag_C(Flag_C),
        .Flag_Z(Flag_Z),
        .notIsResultLow0(notIsResultLow0),
        .OP7(OP7),
        .notOP7(notOP7),
        .Flag_PV(Flag_PV),
        .Flag_S(Flag_S),
        .PR_Reset_XPT(_PR_Reset_XPT_1),
        .P2_Set_CMR(_P2_Set_CMR_1),
        .PR_Write_IX_low(PR_Write_IX_low),
        .PR_Write_IY_low(PR_Write_IY_low),
        .P2_Set_ILDlnnlA_1(P2_Set_ILDlnnlA_1),
        .P2_Set_ILDIXnn_1(P2_Set_ILDIXnn_1),
        .P2_Set_ILDHLlnnl_1(P2_Set_ILDHLlnnl_1),
        .P2_Set_ILDIYnn_1(P2_Set_ILDIYnn_1),
        .P2_Set_ILDIXlnnl_1(P2_Set_ILDIXlnnl_1),
        .P2_Set_ILDIYlnnl_1(P2_Set_ILDIYlnnl_1),
        .P2_Set_ICALLnn_1(P2_Set_ICALLnn_1),
        .PI_SelectAd_OPOPold(_PI_SelectAd_OPOPold_1),
        .PI_SelectDt_A(_PI_SelectDt_A_1),
        .PC_W0(_PC_W0_1),
        .PC_W1(_PC_W1_1),
        .PC_W2(_PC_W2_1),
        .P2_Set_CM1(_P2_Set_CM1_1), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_1),
        .Pa_Ophd(_Pa_Ophd_1), // >
        .PC_R0(_PC_R0_1),
        .PC_R1(_PC_R1_1),
        .PC_R2(_PC_R2_1),
        .PR_Write_L(_PR_Write_L_1),
        .PI_SelectAdt1(_PI_SelectAdt1_1),
        .PR_Write_H(_PR_Write_H_1),
        .PR_InvertIn(_PR_InvertIn_1),
        .PR_Write_IX_high(PR_Write_IX_high),
        .PR_Write_IY_high(PR_Write_IY_high),
        .PR_Dec_SP(PR_Dec_SP),
        .PI_SelectDt_PC_high(PI_SelectDt_PC_high),
        .PI_SelectAd_SP(PI_SelectAd_SP),
        .PI_SelectDt_PC_low(PI_SelectDt_PC_low),
        .PA_Select_OPOPold_low(PA_Select_OPOPold_low),
        .PA_NOP(_PA_NOP_1),
        .PR_Write_PC_high(_PR_Write_PC_high_1),
        .PR_Write_PC_low(_PR_Write_PC_low_1),
        .PC_I0(PC_I0),
        .PC_I1(PC_I1),
        .PC_I2(PC_I2),
        .PC_I3(PC_I3),
        .PC_O0(PC_O0),
        .PC_O1(PC_O1),
        .PC_O2(PC_O2),
        .PC_O3(PC_O3),
        .PR_Write_A(_PR_Write_A_1),
        .PI_SelectAd_AOP(PI_SelectAd_AOP),
        .P2_Set_ILDlnnlIX_1(P2_Set_ILDlnnlIX_1),
        .P2_Set_ILDlnnlIY_1(P2_Set_ILDlnnlIY_1),
        .PI_SelectDt_IX_low(PI_SelectDt_IX_low),
        .PI_SelectDt_IY_low(PI_SelectDt_IY_low),
        .PI_SelectDt_IX_high(PI_SelectDt_IX_high),
        .PI_SelectDt_IY_high(PI_SelectDt_IY_high),
        .PA_Select_PC_high(PA_Select_PC_high),
        .PA_ADD(_PA_ADD_1),
        .PA_Select_OP_low(_PA_Select_OP_low_1),
        .PA_Select_0xffOP_low(PA_Select_0xffOP_low),
        .PA_Select_B_high(PA_Select_B_high),
        .PA_Select_0x1_low(PA_Select_0x1_low),
        .PA_SUB(_PA_SUB_1),
        .PR_Write_B(_PR_Write_B_1),
        .P2_Set_IJPccnn_0_1(P2_Set_IJPccnn_0_1),
        .P2_Set_IJPccnn_1_1(P2_Set_IJPccnn_1_1),
        .P2_Set_IJPccnn_2_1(P2_Set_IJPccnn_2_1),
        .P2_Set_IJPccnn_3_1(P2_Set_IJPccnn_3_1),
        .P2_Set_IJPccnn_4_1(P2_Set_IJPccnn_4_1),
        .P2_Set_IJPccnn_5_1(P2_Set_IJPccnn_5_1),
        .P2_Set_IJPccnn_6_1(P2_Set_IJPccnn_6_1),
        .P2_Set_IJPccnn_7_1(P2_Set_IJPccnn_7_1),
        .P2_Set_CMA(_P2_Set_CMA_1),
        .PA_Select_OP_high(_PA_Select_OP_high_1),
        .P2_Set_ICALLccnn_0_1(P2_Set_ICALLccnn_0_1),
        .P2_Set_ICALLccnn_1_1(P2_Set_ICALLccnn_1_1),
        .P2_Set_ICALLccnn_2_1(P2_Set_ICALLccnn_2_1),
        .P2_Set_ICALLccnn_3_1(P2_Set_ICALLccnn_3_1),
        .P2_Set_ICALLccnn_4_1(P2_Set_ICALLccnn_4_1),
        .P2_Set_ICALLccnn_5_1(P2_Set_ICALLccnn_5_1),
        .P2_Set_ICALLccnn_6_1(P2_Set_ICALLccnn_6_1),
        .P2_Set_ICALLccnn_7_1(P2_Set_ICALLccnn_7_1),
        .PA_Select_IX_high(_PA_Select_IX_high_1),
        .PA_Select_IY_high(_PA_Select_IY_high_1),
        .PR_Write_Dt(_PR_Write_Dt_1),
        .PR_Write_Dtex(_PR_Write_Dtex_1),
        .PI_SelectAd_DtexDt(_PI_SelectAd_DtexDt_1),
        .PC_RA0(PC_RA0),
        .PC_RA1(PC_RA1),
        .PC_RA2(PC_RA2),
        .PA_Select_A_high(_PA_Select_A_high_1),
        .PF_Write_S(_PF_Write_S_1),
        .PF_Write_Z(_PF_Write_Z_1),
        .PF_Write_H(_PF_Write_H_1),
        .PF_Write_PV(_PF_Write_PV_1),
        .PF_Write_N(_PF_Write_N_1),
        .PF_Write_C(_PF_Write_C_1),
        .PA_ADC(_PA_ADC_1),
        .PA_SBC(_PA_SBC_1),
        .PA_AND(_PA_AND_1),
        .PA_OR(_PA_OR_1),
        .PA_XOR(_PA_XOR_1),
        .PF_Select_H_bit22(_PF_Select_H_bit22_1),
        .PF_Select_N_bit17(_PF_Select_N_bit17_1),
        .PF_Select_C_bit26(_PF_Select_C_bit26_1),
        .PF_Select_H_bit21(_PF_Select_H_bit21_1),
        .PF_Select_C_bit23(_PF_Select_C_bit23_1),
        .PF_Select_H_bit16(_PF_Select_H_bit16_1),
        .PF_Select_PV_bit27(_PF_Select_PV_bit27_1),
        .PF_Select_C_bit16(_PF_Select_C_bit16_1),
        .PF_Select_H_bit17(_PF_Select_H_bit17_1),
        .PF_Select_N_bit16(_PF_Select_N_bit16_1),
        .PF_Select_PV_bit25(_PF_Select_PV_bit25_1),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_1),
        .PF_Select_S_bit7(_PF_Select_S_bit7_1),
        .PA_Select_Dt_high(PA_Select_Dt_high),
        .PI_SelectAd_ALU(PI_SelectAd_ALU),
        .PI_SelectDt_Dt(PI_SelectDt_Dt),
        .P2_Set_ILDlIXtdln_1(P2_Set_ILDlIXtdln_1),
        .P2_Set_ILDlIYtdln_1(P2_Set_ILDlIYtdln_1),
        .PA_Select_OPold_low(PA_Select_OPold_low),
        .PI_SelectDt_OP(_PI_SelectDt_OP_1)
    );

    assign P2_Set_CM1 = (_P2_Set_CM1_0 | _P2_Set_CM1_1); // 2 // <
    assign P2_Reset_ITABLE = P2_Set_CM1;
    assign Pa_Ophd = P2_Set_CM1;
    
    assign PI_SelectDt_OP = (_PI_SelectDt_OP_0 | _PI_SelectDt_OP_1); // 2
    assign PC_W0 = (_PC_W0_0 | _PC_W0_1); // 2
    assign PC_W1 = (_PC_W1_0 | _PC_W1_1); // 2
    assign PC_W2 = (_PC_W2_0 | _PC_W2_1); // 2
    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2
    assign P2_Set_CMR = (_P2_Set_CMR_0 | _P2_Set_CMR_1); // 2
    assign PI_SelectAdt1 = (_PI_SelectAdt1_0 | _PI_SelectAdt1_1); // 2
    assign PI_SelectAd_OPOPold = (_PI_SelectAd_OPOPold_0 | _PI_SelectAd_OPOPold_1); // 2
    assign PC_R0 = (_PC_R0_0 | _PC_R0_1); // 2
    assign PC_R1 = (_PC_R1_0 | _PC_R1_1); // 2
    assign PC_R2 = (_PC_R2_0 | _PC_R2_1); // 2
    assign PR_Write_A = (_PR_Write_A_0 | _PR_Write_A_1); // 2
    assign PR_InvertIn = (_PR_InvertIn_0 | _PR_InvertIn_1); // 2
    assign P2_Set_CMA = (_P2_Set_CMA_0 | _P2_Set_CMA_1); // 2
    assign PA_Select_OP_high = (_PA_Select_OP_high_0 | _PA_Select_OP_high_1); // 2
    assign PA_NOP = (_PA_NOP_0 | _PA_NOP_1); // 2
    assign PR_Write_PC_high = (_PR_Write_PC_high_0 | _PR_Write_PC_high_1); // 2
    assign PR_Write_PC_low = (_PR_Write_PC_low_0 | _PR_Write_PC_low_1); // 2
    assign PR_Write_B = (_PR_Write_B_0 | _PR_Write_B_1); // 2
    assign PR_Write_H = (_PR_Write_H_0 | _PR_Write_H_1); // 2
    assign PR_Write_L = (_PR_Write_L_0 | _PR_Write_L_1); // 2
    assign PA_Select_IX_high = (_PA_Select_IX_high_0 | _PA_Select_IX_high_1); // 2
    assign PA_Select_IY_high = (_PA_Select_IY_high_0 | _PA_Select_IY_high_1); // 2
    assign PA_Select_OP_low = (_PA_Select_OP_low_0 | _PA_Select_OP_low_1); // 2
    assign PA_ADD = (_PA_ADD_0 | _PA_ADD_1); // 2
    assign PR_Write_Dt = (_PR_Write_Dt_0 | _PR_Write_Dt_1); // 2
    assign PR_Write_Dtex = (_PR_Write_Dtex_0 | _PR_Write_Dtex_1); // 2
    assign PI_SelectAd_DtexDt = (_PI_SelectAd_DtexDt_0 | _PI_SelectAd_DtexDt_1); // 2
    assign PI_SelectDt_A = (_PI_SelectDt_A_0 | _PI_SelectDt_A_1); // 2
    assign PA_Select_A_high = (_PA_Select_A_high_0 | _PA_Select_A_high_1); // 2
    assign PF_Write_S = (_PF_Write_S_0 | _PF_Write_S_1); // 2
    assign PF_Select_S_bit7 = (_PF_Select_S_bit7_0 | _PF_Select_S_bit7_1); // 2
    assign PF_Write_Z = (_PF_Write_Z_0 | _PF_Write_Z_1); // 2
    assign PF_Select_Z_bit24 = (_PF_Select_Z_bit24_0 | _PF_Select_Z_bit24_1); // 2
    assign PF_Write_H = (_PF_Write_H_0 | _PF_Write_H_1); // 2
    assign PF_Write_PV = (_PF_Write_PV_0 | _PF_Write_PV_1); // 2
    assign PF_Write_N = (_PF_Write_N_0 | _PF_Write_N_1); // 2
    assign PF_Write_C = (_PF_Write_C_0 | _PF_Write_C_1); // 2
    assign PA_ADC = (_PA_ADC_0 | _PA_ADC_1); // 2
    assign PA_SUB = (_PA_SUB_0 | _PA_SUB_1); // 2
    assign PA_SBC = (_PA_SBC_0 | _PA_SBC_1); // 2
    assign PA_AND = (_PA_AND_0 | _PA_AND_1); // 2
    assign PA_OR = (_PA_OR_0 | _PA_OR_1); // 2
    assign PA_XOR = (_PA_XOR_0 | _PA_XOR_1); // 2
    assign PF_Select_H_bit22 = (_PF_Select_H_bit22_0 | _PF_Select_H_bit22_1); // 2
    assign PF_Select_N_bit17 = (_PF_Select_N_bit17_0 | _PF_Select_N_bit17_1); // 2
    assign PF_Select_C_bit26 = (_PF_Select_C_bit26_0 | _PF_Select_C_bit26_1); // 2
    assign PF_Select_H_bit21 = (_PF_Select_H_bit21_0 | _PF_Select_H_bit21_1); // 2
    assign PF_Select_C_bit23 = (_PF_Select_C_bit23_0 | _PF_Select_C_bit23_1); // 2
    assign PF_Select_H_bit16 = (_PF_Select_H_bit16_0 | _PF_Select_H_bit16_1); // 2
    assign PF_Select_PV_bit27 = (_PF_Select_PV_bit27_0 | _PF_Select_PV_bit27_1); // 2
    assign PF_Select_C_bit16 = (_PF_Select_C_bit16_0 | _PF_Select_C_bit16_1); // 2
    assign PF_Select_H_bit17 = (_PF_Select_H_bit17_0 | _PF_Select_H_bit17_1); // 2
    assign PF_Select_N_bit16 = (_PF_Select_N_bit16_0 | _PF_Select_N_bit16_1); // 2
    assign PF_Select_PV_bit25 = (_PF_Select_PV_bit25_0 | _PF_Select_PV_bit25_1); // 2

endmodule
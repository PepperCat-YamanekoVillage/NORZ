// 348(3045)
module DECODER_op(
        input wire not_enable_X1,
        input wire not_enable_XOTR,
        input wire not_enable_XBIT,
        input wire not_enable_XIX,
        input wire not_enable_XIX4_1,
        input wire not_enable_XIX4_0,
        input wire is_Y,
        input wire [4:0] XPT, ////// <----- 4だぞ~!
        input wire [4:0] notXPT,
        input wire [7:0] OP,
        input wire [7:0] Dtcs,
        input wire PD_Source_Dtcs,
        input wire Flag_H,
        input wire Flag_Z,
        input wire Flag_C,
        input wire Flag_S,
        input wire Flag_N,
        input wire Flag_PV,
        input wire notFlag_Z,
        output wire PR_Inc_PC,
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1,
        output wire Pa_Ophd,
        output wire P2_Reset_XBIT,
        output wire PR_Write_B,
        output wire PR_Write_C,
        output wire PR_Write_D,
        output wire PR_Write_E,
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PR_Write_A,
        output wire PA_Select_B_low,
        output wire PA_Select_C_low,
        output wire PA_Select_D_low,
        output wire PA_Select_E_low,
        output wire PA_Select_H_low,
        output wire PA_Select_L_low,
        output wire PA_Select_A_low,
        output wire PA_Select_B_high,
        output wire PA_Select_C_high,
        output wire PA_Select_D_high,
        output wire PA_Select_E_high,
        output wire PA_Select_H_high,
        output wire PA_Select_L_high,
        output wire PA_Select_A_high,
        output wire PR_InvertIn,
        output wire PI_SelectAd_HL,
        output wire PR_Write_Dt,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PA_Select_Dt_low,
        output wire PA_Select_Dt_high,
        output wire PI_SelectDt_Dt,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PR_Write_Dtex,
        output wire PI_SelectAd_DtexDt,
        output wire P2_Reset_XIX4,
        output wire P2_Reset_XIY4,
        output wire PI_SelectAd_ALU,
        output wire PA_Select_OPold_low,
        output wire PA_ADD,
        output wire PA_Select_IX_high,
        output wire PA_Select_IY_high,
        output wire PF_Write_Z,
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Write_C,
        output wire PF_Write_PV,
        output wire PF_Write_S,
        output wire PF_Select_N_bit16,
        output wire PF_Select_Z_bit24,
        output wire PF_Select_S_bit7,
        output wire PF_Select_PV_bit27,
        output wire PF_Select_H_bit16,
        output wire PF_Select_C_bit38,
        output wire PF_Select_C_bit37,
        output wire PF_Select_H_bit17,
        output wire PA_RLC,
        output wire PA_RL,
        output wire PA_SLA,
        output wire PA_RRC,
        output wire PA_RR,
        output wire PA_SRA,
        output wire PA_SRL,
        output wire PA_NOP,
        output wire PA_OR,
        output wire PA_NLAND,
        output wire PF_Select_Z_bit40,
        output wire PF_Select_Z_bit41,
        output wire PF_Select_Z_bit42,
        output wire PF_Select_Z_bit43,
        output wire PF_Select_Z_bit44,
        output wire PF_Select_Z_bit45,
        output wire PF_Select_Z_bit46,
        output wire PF_Select_Z_bit47,
        output wire PA_Select_0x1_low,
        output wire PA_Select_0x2_low,
        output wire PA_Select_0x4_low,
        output wire PA_Select_0x8_low,
        output wire PA_Select_0x10_low,
        output wire PA_Select_0x20_low,
        output wire PA_Select_0x40_low,
        output wire PA_Select_0x80_low,
        output wire P2_Set_CMR,
        output wire P2_Set_XIX4_1,
        output wire P2_Set_XIY4_1,
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
        output wire P2_Reset_XOTR,
        output wire PA_Select_HL_high,
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
        output wire PA_SUB,
        output wire PF_Select_C_bit26,
        output wire PF_Select_PV_bit25,
        output wire PF_Select_H_bit22,
        output wire PI_SelectAd_SP,
        output wire PR_Inc_SP,
        output wire PR_Write_PC_low,
        output wire PR_Write_PC_high,
        output wire P2_RestoreIFF,
        output wire P2_IM0,
        output wire P2_IM1,
        output wire P2_IM2,
        output wire PR_Write_I,
        output wire PR_Write_R,
        output wire PF_Select_Z_bit19,
        output wire PF_Select_PV_bit18,
        output wire PA_Select_I_low,
        output wire PA_Select_R_low,
        output wire PA_RRD,
        output wire PA_RLD,
        output wire PA_Select_BC_high,
        output wire PF_Select_PV_bit20,
        output wire PA_Select_PC_high,
        output wire PI_SelectAd_DE,
        output wire PA_Select_DE_high,
        output wire PR_Write_IX_high,
        output wire PR_Write_IX_low,
        output wire P2_Reset_XIX,
        output wire PR_Write_IY_high,
        output wire PR_Write_IY_low,
        output wire P2_Reset_XIY,
        output wire PA_Select_IX_low,
        output wire PA_Select_IY_low,
        output wire P2_Set_ILDIXlnnl_0,
        output wire P2_Set_ILDIYlnnl_0,
        output wire P2_Set_ILDIXnn_0,
        output wire P2_Set_ILDIYnn_0,
        output wire P2_Set_ILDlnnlIX_0,
        output wire P2_Set_ILDlnnlIY_0,
        output wire P2_Set_IINClIXtdl,
        output wire P2_Set_IINClIYtdl,
        output wire P2_Set_IDEClIXtdl,
        output wire P2_Set_IDEClIYtdl,
        output wire P2_Set_ILDlIXtdln_0,
        output wire P2_Set_ILDlIYtdln_0,
        output wire P2_Set_ILDrlIXtdl_B,
        output wire P2_Set_ILDrlIXtdl_C,
        output wire P2_Set_ILDrlIXtdl_D,
        output wire P2_Set_ILDrlIXtdl_E,
        output wire P2_Set_ILDrlIXtdl_H,
        output wire P2_Set_ILDrlIXtdl_L,
        output wire P2_Set_ILDrlIXtdl_A,
        output wire P2_Set_ILDlIXtdlr_B,
        output wire P2_Set_ILDlIXtdlr_C,
        output wire P2_Set_ILDlIXtdlr_D,
        output wire P2_Set_ILDlIXtdlr_E,
        output wire P2_Set_ILDlIXtdlr_H,
        output wire P2_Set_ILDlIXtdlr_L,
        output wire P2_Set_ILDlIXtdlr_A,
        output wire P2_Set_ILDrlIYtdl_B,
        output wire P2_Set_ILDrlIYtdl_C,
        output wire P2_Set_ILDrlIYtdl_D,
        output wire P2_Set_ILDrlIYtdl_E,
        output wire P2_Set_ILDrlIYtdl_H,
        output wire P2_Set_ILDrlIYtdl_L,
        output wire P2_Set_ILDrlIYtdl_A,
        output wire P2_Set_ILDlIYtdlr_B,
        output wire P2_Set_ILDlIYtdlr_C,
        output wire P2_Set_ILDlIYtdlr_D,
        output wire P2_Set_ILDlIYtdlr_E,
        output wire P2_Set_ILDlIYtdlr_H,
        output wire P2_Set_ILDlIYtdlr_L,
        output wire P2_Set_ILDlIYtdlr_A,
        output wire P2_Set_IADDAlIXtdl,
        output wire P2_Set_IADCAlIXtdl,
        output wire P2_Set_ISUBAlIXtdl,
        output wire P2_Set_ISBCAlIXtdl,
        output wire P2_Set_IANDlIXtdl,
        output wire P2_Set_IXORlIXtdl,
        output wire P2_Set_IORlIXtdl,
        output wire P2_Set_ICPlIXtdl,
        output wire P2_Set_IADDAlIYtdl,
        output wire P2_Set_IADCAlIYtdl,
        output wire P2_Set_ISUBAlIYtdl,
        output wire P2_Set_ISBCAlIYtdl,
        output wire P2_Set_IANDlIYtdl,
        output wire P2_Set_IXORlIYtdl,
        output wire P2_Set_IORlIYtdl,
        output wire P2_Set_ICPlIYtdl,
        output wire P2_Set_XIX4_0,
        output wire P2_Set_XIY4_0,
        output wire PI_SelectDt_Dtex,
        output wire PI_SelectAdt1,
        output wire PR_Dec_SP,
        output wire PI_SelectDt_IX_high,
        output wire PI_SelectDt_IY_high,
        output wire PI_SelectDt_IX_low,
        output wire PI_SelectDt_IY_low,
        output wire P2_Set_LHALT,
        output wire PR_Ex_AF_AF,
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
        output wire P2_Set_ILDlnnlHL_0,
        output wire P2_Set_ILDHLlnnl_0,
        output wire P2_Set_ILDlnnlA_0,
        output wire P2_Set_ILDAlnnl_0,
        output wire PA_Select_SP_high, 
        output wire PR_Write_SP_high, // <
        output wire PR_Write_SP_low, // >
        output wire PF_Select_H_bit21,
        output wire P2_Set_ILDrn_B,
        output wire P2_Set_ILDrn_C,
        output wire P2_Set_ILDrn_D,
        output wire P2_Set_ILDrn_E,
        output wire P2_Set_ILDrn_H,
        output wire P2_Set_ILDrn_L,
        output wire P2_Set_ILDrn_A,
        output wire P2_Set_ILDlHLln,
        output wire PA_Select_0xaa_low,
        output wire PF_Select_S_bit39,
        output wire PF_Select_Z_bit21,
        output wire PF_Select_C_bit29,
        output wire PF_Select_H_bit28,
        output wire PA_Select_0x60_low,
        output wire PA_Select_0x06_low,
        output wire PA_Select_0x66_low,
        output wire PA_NOT,
        output wire PF_Select_H_bit30,
        output wire PF_Select_C_bit0,
        output wire PF_Select_C_bit17,
        output wire PA_Select_F_low,
        output wire PC_RA0,
        output wire PC_RA1,
        output wire PC_RA2,
        output wire PA_AND,
        output wire PA_XOR,
        output wire PF_Select_C_bit23,
        output wire PF_Select_C_bit16,
        output wire PR_Exx,
        output wire PR_Write_F,
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
        output wire PA_Select_0x18_low,
        output wire PA_Select_0x28_low,
        output wire PA_Select_0x30_low,
        output wire PA_Select_0x38_low
    );

    // wire [4:0] notXPT = ~XPT;

    wire [7:0] opsource;
    wire [7:0] _not_opsource = ~opsource; // 8

    DECODER_source_selecter ss(
        .OP(OP),
        .Dtcs(Dtcs),
        .PD_Source_Dtcs(PD_Source_Dtcs),
        .opsource(opsource)
    );

    wire _PR_Inc_PC_xbi4;
    wire _PR_Reset_XPT_xbi4; // <
    wire _P2_Set_CM1_xbi4;
    wire _Pa_Ophd_xbi4; // >
    wire _PR_Write_B_xbi4;
    wire _PR_Write_C_xbi4;
    wire _PR_Write_D_xbi4;
    wire _PR_Write_E_xbi4;
    wire _PR_Write_H_xbi4;
    wire _PR_Write_L_xbi4;
    wire _PR_Write_A_xbi4;
    wire _PA_Select_B_low_xbi4;
    wire _PA_Select_C_low_xbi4;
    wire _PA_Select_D_low_xbi4;
    wire _PA_Select_E_low_xbi4;
    wire _PA_Select_H_low_xbi4;
    wire _PA_Select_L_low_xbi4;
    wire _PA_Select_A_low_xbi4;
    wire _PA_Select_B_high_xbi4;
    wire _PA_Select_C_high_xbi4;
    wire _PA_Select_D_high_xbi4;
    wire _PA_Select_E_high_xbi4;
    wire _PA_Select_H_high_xbi4;
    wire _PA_Select_L_high_xbi4;
    wire _PA_Select_A_high_xbi4;
    wire _PR_InvertIn_xbi4;
    wire _PI_SelectAd_HL_xbi4;
    wire _PR_Write_Dt_xbi4;
    wire _PC_R0_xbi4;
    wire _PC_R1_xbi4;
    wire _PC_R2_xbi4;
    wire _PA_Select_Dt_low_xbi4;
    wire _PA_Select_Dt_high_xbi4;
    wire _PI_SelectDt_Dt_xbi4;
    wire _PC_W0_xbi4;
    wire _PC_W1_xbi4;
    wire _PC_W2_xbi4;
    wire _PR_Write_Dtex_xbi4;
    wire _PA_ADD_xbi4;
    wire _PA_Select_IX_high_xbi4;
    wire _PA_Select_IY_high_xbi4;
    wire _PF_Write_Z_xbi4;
    wire _PF_Write_N_xbi4;
    wire _PF_Write_H_xbi4;
    wire _PF_Write_C_xbi4;
    wire _PF_Write_PV_xbi4;
    wire _PF_Write_S_xbi4;
    wire _PF_Select_N_bit16_xbi4;
    wire _PF_Select_Z_bit24_xbi4;
    wire _PF_Select_S_bit7_xbi4;
    wire _PF_Select_PV_bit27_xbi4;
    wire _PF_Select_H_bit16_xbi4;
    wire _PF_Select_C_bit38_xbi4;
    wire _PF_Select_C_bit37_xbi4;
    wire _PF_Select_H_bit17_xbi4;
    wire _PA_RLC_xbi4;
    wire _PA_RL_xbi4;
    wire _PA_RRC_xbi4;
    wire _PA_RR_xbi4;
    wire _PA_NOP_xbi4;
    wire _PA_OR_xbi4;
    wire _PA_Select_0x1_low_xbi4;
    wire _PA_Select_0x8_low_xbi4;
    wire _PA_Select_0x10_low_xbi4;
    wire _PA_Select_0x20_low_xbi4;

    DECODER_op_XBIT_XIX4_1 xbi4(
        .not_enable_XBIT(not_enable_XBIT),
        .not_enable_XIX4_1(not_enable_XIX4_1),
        .is_Y(is_Y),
        .XPT(XPT[3:0]), // <-3
        .notXPT(notXPT[3:0]),
        .Source(opsource),
        .notSource(_not_opsource),
        .PR_Inc_PC(_PR_Inc_PC_xbi4),
        .PR_Reset_XPT(_PR_Reset_XPT_xbi4), // <
        .P2_Set_CM1(_P2_Set_CM1_xbi4),
        .Pa_Ophd(_Pa_Ophd_xbi4), // >
        .P2_Reset_XBIT(P2_Reset_XBIT),
        .PR_Write_B(_PR_Write_B_xbi4),
        .PR_Write_C(_PR_Write_C_xbi4),
        .PR_Write_D(_PR_Write_D_xbi4),
        .PR_Write_E(_PR_Write_E_xbi4),
        .PR_Write_H(_PR_Write_H_xbi4),
        .PR_Write_L(_PR_Write_L_xbi4),
        .PR_Write_A(_PR_Write_A_xbi4),
        .PA_Select_B_low(_PA_Select_B_low_xbi4),
        .PA_Select_C_low(_PA_Select_C_low_xbi4),
        .PA_Select_D_low(_PA_Select_D_low_xbi4),
        .PA_Select_E_low(_PA_Select_E_low_xbi4),
        .PA_Select_H_low(_PA_Select_H_low_xbi4),
        .PA_Select_L_low(_PA_Select_L_low_xbi4),
        .PA_Select_A_low(_PA_Select_A_low_xbi4),
        .PA_Select_B_high(_PA_Select_B_high_xbi4),
        .PA_Select_C_high(_PA_Select_C_high_xbi4),
        .PA_Select_D_high(_PA_Select_D_high_xbi4),
        .PA_Select_E_high(_PA_Select_E_high_xbi4),
        .PA_Select_H_high(_PA_Select_H_high_xbi4),
        .PA_Select_L_high(_PA_Select_L_high_xbi4),
        .PA_Select_A_high(_PA_Select_A_high_xbi4),
        .PR_InvertIn(_PR_InvertIn_xbi4),
        .PI_SelectAd_HL(_PI_SelectAd_HL_xbi4),
        .PR_Write_Dt(_PR_Write_Dt_xbi4),
        .PC_R0(_PC_R0_xbi4),
        .PC_R1(_PC_R1_xbi4),
        .PC_R2(_PC_R2_xbi4),
        .PA_Select_Dt_low(_PA_Select_Dt_low_xbi4),
        .PA_Select_Dt_high(_PA_Select_Dt_high_xbi4),
        .PI_SelectDt_Dt(_PI_SelectDt_Dt_xbi4),
        .PC_W0(_PC_W0_xbi4),
        .PC_W1(_PC_W1_xbi4),
        .PC_W2(_PC_W2_xbi4),
        .PR_Write_Dtex(_PR_Write_Dtex_xbi4),
        .PI_SelectAd_DtexDt(PI_SelectAd_DtexDt),
        .P2_Reset_XIX4(P2_Reset_XIX4),
        .P2_Reset_XIY4(P2_Reset_XIY4),
        .PI_SelectAd_ALU(PI_SelectAd_ALU),
        .PA_Select_OPold_low(PA_Select_OPold_low),
        .PA_ADD(_PA_ADD_xbi4),
        .PA_Select_IX_high(_PA_Select_IX_high_xbi4),
        .PA_Select_IY_high(_PA_Select_IY_high_xbi4),
        .PF_Write_Z(_PF_Write_Z_xbi4),
        .PF_Write_N(_PF_Write_N_xbi4),
        .PF_Write_H(_PF_Write_H_xbi4),
        .PF_Write_C(_PF_Write_C_xbi4),
        .PF_Write_PV(_PF_Write_PV_xbi4),
        .PF_Write_S(_PF_Write_S_xbi4),
        .PF_Select_N_bit16(_PF_Select_N_bit16_xbi4),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_xbi4),
        .PF_Select_S_bit7(_PF_Select_S_bit7_xbi4),
        .PF_Select_PV_bit27(_PF_Select_PV_bit27_xbi4),
        .PF_Select_H_bit16(_PF_Select_H_bit16_xbi4),
        .PF_Select_C_bit38(_PF_Select_C_bit38_xbi4),
        .PF_Select_C_bit37(_PF_Select_C_bit37_xbi4),
        .PF_Select_H_bit17(_PF_Select_H_bit17_xbi4),
        .PA_RLC(_PA_RLC_xbi4),
        .PA_RL(_PA_RL_xbi4),
        .PA_SLA(PA_SLA),
        .PA_RRC(_PA_RRC_xbi4),
        .PA_RR(_PA_RR_xbi4),
        .PA_SRA(PA_SRA),
        .PA_SRL(PA_SRL),
        .PA_NOP(_PA_NOP_xbi4),
        .PA_OR(_PA_OR_xbi4),
        .PA_NLAND(PA_NLAND),
        .PF_Select_Z_bit40(PF_Select_Z_bit40),
        .PF_Select_Z_bit41(PF_Select_Z_bit41),
        .PF_Select_Z_bit42(PF_Select_Z_bit42),
        .PF_Select_Z_bit43(PF_Select_Z_bit43),
        .PF_Select_Z_bit44(PF_Select_Z_bit44),
        .PF_Select_Z_bit45(PF_Select_Z_bit45),
        .PF_Select_Z_bit46(PF_Select_Z_bit46),
        .PF_Select_Z_bit47(PF_Select_Z_bit47),
        .PA_Select_0x1_low(_PA_Select_0x1_low_xbi4),
        .PA_Select_0x2_low(PA_Select_0x2_low),
        .PA_Select_0x4_low(PA_Select_0x4_low),
        .PA_Select_0x8_low(_PA_Select_0x8_low_xbi4),
        .PA_Select_0x10_low(_PA_Select_0x10_low_xbi4),
        .PA_Select_0x20_low(_PA_Select_0x20_low_xbi4),
        .PA_Select_0x40_low(PA_Select_0x40_low),
        .PA_Select_0x80_low(PA_Select_0x80_low)
    );

    wire _PR_Reset_XPT_xi40;
    wire _P2_Set_CMR_xi40;

    DECODER_op_XIX4_0 xi40(
        .not_enable(not_enable_XIX4_0),
        .is_Y(is_Y),
        .PR_Reset_XPT(_PR_Reset_XPT_xi40),
        .P2_Set_CMR(_P2_Set_CMR_xi40),
        .P2_Set_XIX4_1(P2_Set_XIX4_1),
        .P2_Set_XIY4_1(P2_Set_XIY4_1)
    );

    wire _PR_Inc_PC_xotr;
    wire _PI_SelectAd_BC_xotr;
    wire _PI_SelectDt_B_xotr;
    wire _PI_SelectDt_C_xotr;
    wire _PI_SelectDt_D_xotr;
    wire _PI_SelectDt_E_xotr;
    wire _PI_SelectDt_H_xotr;
    wire _PI_SelectDt_L_xotr;
    wire _PI_SelectDt_A_xotr;
    wire _PR_Reset_XPT_xotr;
    wire _P2_Set_CM1_xotr; // <
    wire _Pa_Ophd_xotr; // >
    wire _PF_Write_Z_xotr;
    wire _PF_Write_PV_xotr;
    wire _PF_Write_S_xotr;
    wire _PF_Write_N_xotr;
    wire _PF_Write_H_xotr;
    wire _PF_Select_Z_bit24_xotr;
    wire _PF_Select_PV_bit27_xotr;
    wire _PF_Select_S_bit7_xotr;
    wire _PF_Select_N_bit16_xotr;
    wire _PF_Select_H_bit16_xotr;
    wire _PR_Write_B_xotr;
    wire _PR_Write_C_xotr;
    wire _PR_Write_D_xotr;
    wire _PR_Write_E_xotr;
    wire _PR_Write_H_xotr;
    wire _PR_Write_L_xotr;
    wire _PR_Write_A_xotr;
    wire _PR_InvertIn_xotr;
    wire _PA_Select_HL_high_xotr;
    wire _PF_Write_C_xotr;
    wire _PA_SBC_xotr;
    wire _PF_Select_N_bit17_xotr;
    wire _PA_ADC_xotr;
    wire _PF_Select_C_bit32_xotr;
    wire _PF_Select_H_bit31_xotr;
    wire _PA_Select_BC_low_xotr;
    wire _PA_Select_DE_low_xotr;
    wire _PA_Select_HL_low_xotr;
    wire _PA_Select_SP_low_xotr;
    wire _PA_Select_A_low_xotr;
    wire _PA_SUB_xotr;
    wire _PF_Select_C_bit26_xotr;
    wire _PF_Select_PV_bit25_xotr;
    wire _PF_Select_H_bit22_xotr;
    wire _PI_SelectAd_SP_xotr;
    wire _PC_R0_xotr;
    wire _PC_R1_xotr;
    wire _PC_R2_xotr;
    wire _PR_Inc_SP_xotr;
    wire _PR_Write_PC_low_xotr;
    wire _PR_Write_PC_high_xotr;
    wire _PA_NOP_xotr;
    wire _PR_Write_Dt_xotr;
    wire _PA_Select_Dt_high_xotr;
    wire _PC_W0_xotr;
    wire _PC_W1_xotr;
    wire _PC_W2_xotr;
    wire _PI_SelectDt_Dt_xotr;
    wire _PI_SelectAd_HL_xotr;
    wire _PA_Select_BC_high_xotr;
    wire _PA_Select_0x1_low_xotr;
    wire _PA_ADD_xotr;
    wire _PI_SelectAd_DE_xotr;
    wire _PA_Select_DE_high_xotr;
    wire _PA_Select_A_high_xotr;
    wire _PA_Select_Dt_low_xotr;
    wire _PA_Select_B_high_xotr;
    wire _P2_Set_CMR_xotr;

    DECODER_op_XOTR xotr(
        .not_enable(not_enable_XOTR),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(opsource),
        .notSource(_not_opsource),
        .Flag_PV(Flag_PV),
        .notFlag_Z(notFlag_Z),
        .PR_Inc_PC(_PR_Inc_PC_xotr),
        .PI_SelectAd_BC(_PI_SelectAd_BC_xotr),
        .PI_SelectDt_B(_PI_SelectDt_B_xotr),
        .PI_SelectDt_C(_PI_SelectDt_C_xotr),
        .PI_SelectDt_D(_PI_SelectDt_D_xotr),
        .PI_SelectDt_E(_PI_SelectDt_E_xotr),
        .PI_SelectDt_H(_PI_SelectDt_H_xotr),
        .PI_SelectDt_L(_PI_SelectDt_L_xotr),
        .PI_SelectDt_A(_PI_SelectDt_A_xotr),
        .PC_I0(PC_I0),
        .PC_I1(PC_I1),
        .PC_I2(PC_I2),
        .PC_I3(PC_I3),
        .PC_O0(PC_O0),
        .PC_O1(PC_O1),
        .PC_O2(PC_O2),
        .PC_O3(PC_O3),
        .PR_Reset_XPT(_PR_Reset_XPT_xotr), // <
        .P2_Reset_XOTR(P2_Reset_XOTR), // >
        .P2_Set_CM1(_P2_Set_CM1_xotr), // <
        .Pa_Ophd(_Pa_Ophd_xotr), // >
        .PF_Write_Z(_PF_Write_Z_xotr),
        .PF_Write_PV(_PF_Write_PV_xotr),
        .PF_Write_S(_PF_Write_S_xotr),
        .PF_Write_N(_PF_Write_N_xotr),
        .PF_Write_H(_PF_Write_H_xotr),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_xotr),
        .PF_Select_PV_bit27(_PF_Select_PV_bit27_xotr),
        .PF_Select_S_bit7(_PF_Select_S_bit7_xotr),
        .PF_Select_N_bit16(_PF_Select_N_bit16_xotr),
        .PF_Select_H_bit16(_PF_Select_H_bit16_xotr),
        .PR_Write_B(_PR_Write_B_xotr),
        .PR_Write_C(_PR_Write_C_xotr),
        .PR_Write_D(_PR_Write_D_xotr),
        .PR_Write_E(_PR_Write_E_xotr),
        .PR_Write_H(_PR_Write_H_xotr),
        .PR_Write_L(_PR_Write_L_xotr),
        .PR_Write_A(_PR_Write_A_xotr),
        .PR_InvertIn(_PR_InvertIn_xotr),
        .PA_Select_HL_high(_PA_Select_HL_high_xotr),
        .PF_Write_C(_PF_Write_C_xotr),
        .PF_Select_Z_bit34(PF_Select_Z_bit34),
        .PF_Select_PV_bit33(PF_Select_PV_bit33),
        .PF_Select_S_bit15(PF_Select_S_bit15),
        .PA_SBC(_PA_SBC_xotr),
        .PF_Select_C_bit36(PF_Select_C_bit36),
        .PF_Select_N_bit17(_PF_Select_N_bit17_xotr),
        .PF_Select_H_bit35(PF_Select_H_bit35),
        .PA_ADC(_PA_ADC_xotr),
        .PF_Select_C_bit32(_PF_Select_C_bit32_xotr),
        .PF_Select_H_bit31(_PF_Select_H_bit31_xotr),
        .PA_Select_BC_low(_PA_Select_BC_low_xotr),
        .PA_Select_DE_low(_PA_Select_DE_low_xotr),
        .PA_Select_HL_low(_PA_Select_HL_low_xotr),
        .PA_Select_SP_low(_PA_Select_SP_low_xotr),
        .P2_Set_ILDlnnldd_BC_0(P2_Set_ILDlnnldd_BC_0),
        .P2_Set_ILDlnnldd_DE_0(P2_Set_ILDlnnldd_DE_0),
        .P2_Set_ILDlnnldd_HL_0(P2_Set_ILDlnnldd_HL_0),
        .P2_Set_ILDlnnldd_SP_0(P2_Set_ILDlnnldd_SP_0),
        .P2_Set_ILDddlnnl_BC_0(P2_Set_ILDddlnnl_BC_0),
        .P2_Set_ILDddlnnl_DE_0(P2_Set_ILDddlnnl_DE_0),
        .P2_Set_ILDddlnnl_HL_0(P2_Set_ILDddlnnl_HL_0),
        .P2_Set_ILDddlnnl_SP_0(P2_Set_ILDddlnnl_SP_0),
        .PA_Select_A_low(_PA_Select_A_low_xotr),
        .PA_SUB(_PA_SUB_xotr),
        .PF_Select_C_bit26(_PF_Select_C_bit26_xotr),
        .PF_Select_PV_bit25(_PF_Select_PV_bit25_xotr),
        .PF_Select_H_bit22(_PF_Select_H_bit22_xotr),
        .PI_SelectAd_SP(_PI_SelectAd_SP_xotr),
        .PC_R0(_PC_R0_xotr),
        .PC_R1(_PC_R1_xotr),
        .PC_R2(_PC_R2_xotr),
        .PR_Inc_SP(_PR_Inc_SP_xotr),
        .PR_Write_PC_low(_PR_Write_PC_low_xotr),
        .PR_Write_PC_high(_PR_Write_PC_high_xotr),
        .P2_RestoreIFF(P2_RestoreIFF),
        .P2_IM0(P2_IM0),
        .P2_IM1(P2_IM1),
        .P2_IM2(P2_IM2),
        .PA_NOP(_PA_NOP_xotr),
        .PR_Write_I(PR_Write_I),
        .PR_Write_R(PR_Write_R),
        .PF_Select_Z_bit19(PF_Select_Z_bit19),
        .PF_Select_PV_bit18(PF_Select_PV_bit18),
        .PA_Select_I_low(PA_Select_I_low),
        .PA_Select_R_low(PA_Select_R_low),
        .PR_Write_Dt(_PR_Write_Dt_xotr),
        .PA_Select_Dt_high(_PA_Select_Dt_high_xotr),
        .PC_W0(_PC_W0_xotr),
        .PC_W1(_PC_W1_xotr),
        .PC_W2(_PC_W2_xotr),
        .PI_SelectDt_Dt(_PI_SelectDt_Dt_xotr),
        .PI_SelectAd_HL(_PI_SelectAd_HL_xotr),
        .PA_RRD(PA_RRD),
        .PA_RLD(PA_RLD),
        .PA_Select_BC_high(_PA_Select_BC_high_xotr),
        .PF_Select_PV_bit20(PF_Select_PV_bit20),
        .PA_Select_PC_high(PA_Select_PC_high),
        .PA_Select_0x1_low(_PA_Select_0x1_low_xotr),
        .PA_ADD(_PA_ADD_xotr),
        .PI_SelectAd_DE(_PI_SelectAd_DE_xotr),
        .PA_Select_DE_high(_PA_Select_DE_high_xotr),
        .PA_Select_A_high(_PA_Select_A_high_xotr),
        .PA_Select_Dt_low(_PA_Select_Dt_low_xotr),
        .PA_Select_B_high(_PA_Select_B_high_xotr),
        .P2_Set_CMR(_P2_Set_CMR_xotr)
    );

    wire _PR_Inc_PC_xix;
    wire _PR_Reset_XPT_xix;
    wire _P2_Set_CM1_xix; // <
    wire _Pa_Ophd_xix; // >
    wire _PA_ADD_xix;
    wire _PF_Write_C_xix; // <
    wire _PF_Write_N_xix;
    wire _PF_Write_H_xix;
    wire _PF_Select_C_bit32_xix;
    wire _PF_Select_N_bit16_xix;
    wire _PF_Select_H_bit31_xix; // >
    wire _PA_Select_IX_high_xix;
    wire _PA_Select_IY_high_xix;
    wire _PA_Select_BC_low_xix;
    wire _PA_Select_DE_low_xix;
    wire _PA_Select_SP_low_xix;
    wire _PA_Select_0x1_low_xix;
    wire _PA_SUB_xix;
    wire _P2_Set_CMR_xix;
    wire _PI_SelectAd_SP_xix;
    wire _PC_R0_xix;
    wire _PC_R1_xix;
    wire _PC_R2_xix;
    wire _PR_Inc_SP_xix;
    wire _PR_InvertIn_xix;
    wire _PA_NOP_xix;
    wire _PR_Write_Dt_xix;
    wire _PR_Write_Dtex_xix;
    wire _PI_SelectDt_Dt_xix;
    wire _PC_W0_xix;
    wire _PC_W1_xix;
    wire _PC_W2_xix;
    wire _PI_SelectDt_Dtex_xix;
    wire _PI_SelectAdt1_xix;
    wire _PR_Dec_SP_xix;
    wire _PR_Write_PC_high_xix;
    wire _PR_Write_PC_low_xix;
    wire _PR_Write_SP_xix;

    DECODER_op_XIX xix(
        .not_enable(not_enable_XIX),
        .is_Y(is_Y),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(opsource),
        .notSource(_not_opsource),
        .PR_Inc_PC(_PR_Inc_PC_xix),
        .PR_Reset_XPT(_PR_Reset_XPT_xix),
        .P2_Set_CM1(_P2_Set_CM1_xix), // <
        .Pa_Ophd(_Pa_Ophd_xix), // >
        .PA_ADD(_PA_ADD_xix),
        .PF_Write_C(_PF_Write_C_xix), // <
        .PF_Write_N(_PF_Write_N_xix),
        .PF_Write_H(_PF_Write_H_xix),
        .PF_Select_C_bit32(_PF_Select_C_bit32_xix),
        .PF_Select_N_bit16(_PF_Select_N_bit16_xix),
        .PF_Select_H_bit31(_PF_Select_H_bit31_xix), // >
        .PA_Select_IX_high(_PA_Select_IX_high_xix),
        .PR_Write_IX_high(PR_Write_IX_high),
        .PR_Write_IX_low(PR_Write_IX_low),
        .P2_Reset_XIX(P2_Reset_XIX),
        .PA_Select_IY_high(_PA_Select_IY_high_xix),
        .PR_Write_IY_high(PR_Write_IY_high),
        .PR_Write_IY_low(PR_Write_IY_low),
        .P2_Reset_XIY(P2_Reset_XIY),
        .PA_Select_BC_low(_PA_Select_BC_low_xix),
        .PA_Select_DE_low(_PA_Select_DE_low_xix),
        .PA_Select_SP_low(_PA_Select_SP_low_xix),
        .PA_Select_IX_low(PA_Select_IX_low),
        .PA_Select_IY_low(PA_Select_IY_low),
        .PA_Select_0x1_low(_PA_Select_0x1_low_xix),
        .PA_SUB(_PA_SUB_xix),
        .P2_Set_CMR(_P2_Set_CMR_xix),
        .P2_Set_ILDIXlnnl_0(P2_Set_ILDIXlnnl_0),
        .P2_Set_ILDIYlnnl_0(P2_Set_ILDIYlnnl_0),
        .P2_Set_ILDIXnn_0(P2_Set_ILDIXnn_0),
        .P2_Set_ILDIYnn_0(P2_Set_ILDIYnn_0),
        .P2_Set_ILDlnnlIX_0(P2_Set_ILDlnnlIX_0),
        .P2_Set_ILDlnnlIY_0(P2_Set_ILDlnnlIY_0),
        .P2_Set_IINClIXtdl(P2_Set_IINClIXtdl),
        .P2_Set_IINClIYtdl(P2_Set_IINClIYtdl),
        .P2_Set_IDEClIXtdl(P2_Set_IDEClIXtdl),
        .P2_Set_IDEClIYtdl(P2_Set_IDEClIYtdl),
        .P2_Set_ILDlIXtdln_0(P2_Set_ILDlIXtdln_0),
        .P2_Set_ILDlIYtdln_0(P2_Set_ILDlIYtdln_0),
        .P2_Set_ILDrlIXtdl_B(P2_Set_ILDrlIXtdl_B),
        .P2_Set_ILDrlIXtdl_C(P2_Set_ILDrlIXtdl_C),
        .P2_Set_ILDrlIXtdl_D(P2_Set_ILDrlIXtdl_D),
        .P2_Set_ILDrlIXtdl_E(P2_Set_ILDrlIXtdl_E),
        .P2_Set_ILDrlIXtdl_H(P2_Set_ILDrlIXtdl_H),
        .P2_Set_ILDrlIXtdl_L(P2_Set_ILDrlIXtdl_L),
        .P2_Set_ILDrlIXtdl_A(P2_Set_ILDrlIXtdl_A),
        .P2_Set_ILDlIXtdlr_B(P2_Set_ILDlIXtdlr_B),
        .P2_Set_ILDlIXtdlr_C(P2_Set_ILDlIXtdlr_C),
        .P2_Set_ILDlIXtdlr_D(P2_Set_ILDlIXtdlr_D),
        .P2_Set_ILDlIXtdlr_E(P2_Set_ILDlIXtdlr_E),
        .P2_Set_ILDlIXtdlr_H(P2_Set_ILDlIXtdlr_H),
        .P2_Set_ILDlIXtdlr_L(P2_Set_ILDlIXtdlr_L),
        .P2_Set_ILDlIXtdlr_A(P2_Set_ILDlIXtdlr_A),
        .P2_Set_ILDrlIYtdl_B(P2_Set_ILDrlIYtdl_B),
        .P2_Set_ILDrlIYtdl_C(P2_Set_ILDrlIYtdl_C),
        .P2_Set_ILDrlIYtdl_D(P2_Set_ILDrlIYtdl_D),
        .P2_Set_ILDrlIYtdl_E(P2_Set_ILDrlIYtdl_E),
        .P2_Set_ILDrlIYtdl_H(P2_Set_ILDrlIYtdl_H),
        .P2_Set_ILDrlIYtdl_L(P2_Set_ILDrlIYtdl_L),
        .P2_Set_ILDrlIYtdl_A(P2_Set_ILDrlIYtdl_A),
        .P2_Set_ILDlIYtdlr_B(P2_Set_ILDlIYtdlr_B),
        .P2_Set_ILDlIYtdlr_C(P2_Set_ILDlIYtdlr_C),
        .P2_Set_ILDlIYtdlr_D(P2_Set_ILDlIYtdlr_D),
        .P2_Set_ILDlIYtdlr_E(P2_Set_ILDlIYtdlr_E),
        .P2_Set_ILDlIYtdlr_H(P2_Set_ILDlIYtdlr_H),
        .P2_Set_ILDlIYtdlr_L(P2_Set_ILDlIYtdlr_L),
        .P2_Set_ILDlIYtdlr_A(P2_Set_ILDlIYtdlr_A),
        .P2_Set_IADDAlIXtdl(P2_Set_IADDAlIXtdl),
        .P2_Set_IADCAlIXtdl(P2_Set_IADCAlIXtdl),
        .P2_Set_ISUBAlIXtdl(P2_Set_ISUBAlIXtdl),
        .P2_Set_ISBCAlIXtdl(P2_Set_ISBCAlIXtdl),
        .P2_Set_IANDlIXtdl(P2_Set_IANDlIXtdl),
        .P2_Set_IXORlIXtdl(P2_Set_IXORlIXtdl),
        .P2_Set_IORlIXtdl(P2_Set_IORlIXtdl),
        .P2_Set_ICPlIXtdl(P2_Set_ICPlIXtdl),
        .P2_Set_IADDAlIYtdl(P2_Set_IADDAlIYtdl),
        .P2_Set_IADCAlIYtdl(P2_Set_IADCAlIYtdl),
        .P2_Set_ISUBAlIYtdl(P2_Set_ISUBAlIYtdl),
        .P2_Set_ISBCAlIYtdl(P2_Set_ISBCAlIYtdl),
        .P2_Set_IANDlIYtdl(P2_Set_IANDlIYtdl),
        .P2_Set_IXORlIYtdl(P2_Set_IXORlIYtdl),
        .P2_Set_IORlIYtdl(P2_Set_IORlIYtdl),
        .P2_Set_ICPlIYtdl(P2_Set_ICPlIYtdl),
        .P2_Set_XIX4_0(P2_Set_XIX4_0),
        .P2_Set_XIY4_0(P2_Set_XIY4_0),
        .PI_SelectAd_SP(_PI_SelectAd_SP_xix),
        .PC_R0(_PC_R0_xix),
        .PC_R1(_PC_R1_xix),
        .PC_R2(_PC_R2_xix),
        .PR_Inc_SP(_PR_Inc_SP_xix),
        .PR_InvertIn(_PR_InvertIn_xix),
        .PA_NOP(_PA_NOP_xix),
        .PR_Write_Dt(_PR_Write_Dt_xix),
        .PR_Write_Dtex(_PR_Write_Dtex_xix),
        .PI_SelectDt_Dt(_PI_SelectDt_Dt_xix),
        .PC_W0(_PC_W0_xix),
        .PC_W1(_PC_W1_xix),
        .PC_W2(_PC_W2_xix),
        .PI_SelectDt_Dtex(_PI_SelectDt_Dtex_xix),
        .PI_SelectAdt1(_PI_SelectAdt1_xix),
        .PR_Dec_SP(_PR_Dec_SP_xix),
        .PI_SelectDt_IX_high(PI_SelectDt_IX_high),
        .PI_SelectDt_IY_high(PI_SelectDt_IY_high),
        .PI_SelectDt_IX_low(PI_SelectDt_IX_low),
        .PI_SelectDt_IY_low(PI_SelectDt_IY_low),
        .PR_Write_PC_high(_PR_Write_PC_high_xix),
        .PR_Write_PC_low(_PR_Write_PC_low_xix),
        .PR_Write_SP(_PR_Write_SP_xix)
    );

    wire _PR_Inc_PC_x1;
    wire _PR_Reset_XPT_x1;
    wire _P2_Set_CM1_x1;
    wire _Pa_Ophd_x1;
    wire _P2_Set_CMR_x1;
    wire _PA_ADD_x1;
    wire _PR_Write_H_x1;
    wire _PR_Write_L_x1;
    wire _PF_Write_C_x1;
    wire _PF_Write_N_x1;
    wire _PF_Write_H_x1;
    wire _PF_Select_C_bit32_x1;
    wire _PF_Select_N_bit16_x1;
    wire _PF_Select_H_bit31_x1;
    wire _PA_Select_HL_high_x1;
    wire _PA_Select_BC_low_x1;
    wire _PA_Select_DE_low_x1;
    wire _PA_Select_HL_low_x1;
    wire _PA_Select_SP_low_x1;
    wire _PI_SelectAd_BC_x1;
    wire _PI_SelectAd_DE_x1;
    wire _PI_SelectDt_A_x1;
    wire _PC_R0_x1;
    wire _PC_R1_x1;
    wire _PC_R2_x1;
    wire _PC_W0_x1;
    wire _PC_W1_x1;
    wire _PC_W2_x1;
    wire _PR_Write_A_x1;
    wire _PR_InvertIn_x1;
    wire _PA_Select_0x1_low_x1;
    wire _PA_SUB_x1;
    wire _PA_Select_BC_high_x1;
    wire _PR_Write_B_x1;
    wire _PR_Write_C_x1;
    wire _PA_Select_DE_high_x1;
    wire _PR_Write_D_x1;
    wire _PR_Write_E_x1;
    wire _PA_Select_B_high_x1;
    wire _PA_Select_C_high_x1;
    wire _PA_Select_D_high_x1;
    wire _PA_Select_E_high_x1;
    wire _PA_Select_H_high_x1;
    wire _PA_Select_L_high_x1;
    wire _PA_Select_A_high_x1;
    wire _PF_Write_S_x1;
    wire _PF_Write_Z_x1;
    wire _PF_Write_PV_x1; // <
    wire _PF_Select_S_bit7_x1;
    wire _PF_Select_Z_bit24_x1; // >
    wire _PF_Select_PV_bit25_x1;
    wire _PF_Select_H_bit22_x1;
    wire _PF_Select_N_bit17_x1;
    wire _PI_SelectAd_HL_x1;
    wire _PR_Write_Dt_x1;
    wire _PA_Select_Dt_high_x1;
    wire _PI_SelectDt_Dt_x1;
    wire _PF_Select_PV_bit27_x1;
    wire _PA_Select_A_low_x1;
    wire _PA_RLC_x1;
    wire _PA_RL_x1;
    wire _PA_RRC_x1;
    wire _PA_RR_x1;
    wire _PF_Select_C_bit38_x1;
    wire _PF_Select_C_bit37_x1;
    wire _PF_Select_H_bit16_x1;
    wire _PF_Select_H_bit17_x1;
    wire _PI_SelectDt_B_x1;
    wire _PI_SelectDt_C_x1;
    wire _PI_SelectDt_D_x1;
    wire _PI_SelectDt_E_x1;
    wire _PI_SelectDt_H_x1;
    wire _PI_SelectDt_L_x1;
    wire _PA_NOP_x1;
    wire _PA_Select_B_low_x1;
    wire _PA_Select_C_low_x1;
    wire _PA_Select_D_low_x1;
    wire _PA_Select_E_low_x1;
    wire _PA_Select_H_low_x1;
    wire _PA_Select_L_low_x1;
    wire _PA_ADC_x1;
    wire _PA_SBC_x1;
    wire _PA_OR_x1;
    wire _PF_Select_C_bit26_x1;
    wire _PI_SelectAd_SP_x1;
    wire _PR_Inc_SP_x1;
    wire _PR_Write_PC_low_x1;
    wire _PR_Write_PC_high_x1;
    wire _PR_Write_Dtex_x1;
    wire _PI_SelectDt_Dtex_x1;
    wire _PI_SelectAdt1_x1;
    wire _PR_Dec_SP_x1;
    wire _PA_Select_0x8_low_x1;
    wire _PA_Select_0x10_low_x1;
    wire _PA_Select_0x20_low_x1;
    wire _PR_Write_SP_high_x1; // <
    wire _PR_Write_SP_low_x1; // >

    DECODER_op_X1 x1(
        .not_enable(not_enable_X1),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(opsource),
        .notSource(_not_opsource),
        .Flag_H(Flag_H),
        .Flag_Z(Flag_Z),
        .Flag_C(Flag_C),
        .Flag_S(Flag_S),
        .Flag_N(Flag_N),
        .Flag_PV(Flag_PV),
        .PR_Inc_PC(_PR_Inc_PC_x1),
        .P2_Set_LHALT(P2_Set_LHALT),
        .PR_Reset_XPT(_PR_Reset_XPT_x1),
        .P2_Set_CM1(_P2_Set_CM1_x1),
        .Pa_Ophd(_Pa_Ophd_x1),
        .PR_Ex_AF_AF(PR_Ex_AF_AF),
        .P2_Set_CMR(_P2_Set_CMR_x1),
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
        .PA_ADD(_PA_ADD_x1),
        .PR_Write_H(_PR_Write_H_x1),
        .PR_Write_L(_PR_Write_L_x1),
        .PF_Write_C(_PF_Write_C_x1),
        .PF_Write_N(_PF_Write_N_x1),
        .PF_Write_H(_PF_Write_H_x1),
        .PF_Select_C_bit32(_PF_Select_C_bit32_x1),
        .PF_Select_N_bit16(_PF_Select_N_bit16_x1),
        .PF_Select_H_bit31(_PF_Select_H_bit31_x1),
        .PA_Select_HL_high(_PA_Select_HL_high_x1),
        .PA_Select_BC_low(_PA_Select_BC_low_x1),
        .PA_Select_DE_low(_PA_Select_DE_low_x1),
        .PA_Select_HL_low(_PA_Select_HL_low_x1),
        .PA_Select_SP_low(_PA_Select_SP_low_x1),
        .PI_SelectAd_BC(_PI_SelectAd_BC_x1),
        .PI_SelectAd_DE(_PI_SelectAd_DE_x1),
        .PI_SelectDt_A(_PI_SelectDt_A_x1),
        .PC_R0(_PC_R0_x1),
        .PC_R1(_PC_R1_x1),
        .PC_R2(_PC_R2_x1),
        .PC_W0(_PC_W0_x1),
        .PC_W1(_PC_W1_x1),
        .PC_W2(_PC_W2_x1),
        .PR_Write_A(_PR_Write_A_x1),
        .PR_InvertIn(_PR_InvertIn_x1),
        .P2_Set_ILDlnnlHL_0(P2_Set_ILDlnnlHL_0),
        .P2_Set_ILDHLlnnl_0(P2_Set_ILDHLlnnl_0),
        .P2_Set_ILDlnnlA_0(P2_Set_ILDlnnlA_0),
        .P2_Set_ILDAlnnl_0(P2_Set_ILDAlnnl_0),
        .PA_Select_0x1_low(_PA_Select_0x1_low_x1),
        .PA_SUB(_PA_SUB_x1),
        .PA_Select_BC_high(_PA_Select_BC_high_x1),
        .PR_Write_B(_PR_Write_B_x1),
        .PR_Write_C(_PR_Write_C_x1),
        .PA_Select_DE_high(_PA_Select_DE_high_x1),
        .PR_Write_D(_PR_Write_D_x1),
        .PR_Write_E(_PR_Write_E_x1),
        .PA_Select_SP_high(PA_Select_SP_high), 
        .PR_Write_SP_high(_PR_Write_SP_high_x1), // <
        .PR_Write_SP_low(_PR_Write_SP_low_x1), // >
        .PA_Select_B_high(_PA_Select_B_high_x1),
        .PA_Select_C_high(_PA_Select_C_high_x1),
        .PA_Select_D_high(_PA_Select_D_high_x1),
        .PA_Select_E_high(_PA_Select_E_high_x1),
        .PA_Select_H_high(_PA_Select_H_high_x1),
        .PA_Select_L_high(_PA_Select_L_high_x1),
        .PA_Select_A_high(_PA_Select_A_high_x1),
        .PF_Write_S(_PF_Write_S_x1),
        .PF_Write_Z(_PF_Write_Z_x1),
        .PF_Write_PV(_PF_Write_PV_x1),// <
        .PF_Select_S_bit7(_PF_Select_S_bit7_x1),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_x1), // >
        .PF_Select_PV_bit25(_PF_Select_PV_bit25_x1),
        .PF_Select_H_bit21(PF_Select_H_bit21),
        .PF_Select_H_bit22(_PF_Select_H_bit22_x1),
        .PF_Select_N_bit17(_PF_Select_N_bit17_x1),
        .PI_SelectAd_HL(_PI_SelectAd_HL_x1),
        .PR_Write_Dt(_PR_Write_Dt_x1),
        .PA_Select_Dt_high(_PA_Select_Dt_high_x1),
        .PI_SelectDt_Dt(_PI_SelectDt_Dt_x1),
        .P2_Set_ILDrn_B(P2_Set_ILDrn_B),
        .P2_Set_ILDrn_C(P2_Set_ILDrn_C),
        .P2_Set_ILDrn_D(P2_Set_ILDrn_D),
        .P2_Set_ILDrn_E(P2_Set_ILDrn_E),
        .P2_Set_ILDrn_H(P2_Set_ILDrn_H),
        .P2_Set_ILDrn_L(P2_Set_ILDrn_L),
        .P2_Set_ILDrn_A(P2_Set_ILDrn_A),
        .P2_Set_ILDlHLln(P2_Set_ILDlHLln),
        .PA_Select_0xaa_low(PA_Select_0xaa_low),
        .PF_Select_S_bit39(PF_Select_S_bit39),
        .PF_Select_Z_bit21(PF_Select_Z_bit21),
        .PF_Select_C_bit29(PF_Select_C_bit29),
        .PF_Select_PV_bit27(_PF_Select_PV_bit27_x1),
        .PF_Select_H_bit28(PF_Select_H_bit28),
        .PA_Select_0x60_low(PA_Select_0x60_low),
        .PA_Select_0x06_low(PA_Select_0x06_low),
        .PA_Select_0x66_low(PA_Select_0x66_low),
        .PA_Select_A_low(_PA_Select_A_low_x1),
        .PA_RLC(_PA_RLC_x1),
        .PA_RL(_PA_RL_x1),
        .PA_RRC(_PA_RRC_x1),
        .PA_RR(_PA_RR_x1),
        .PA_NOT(PA_NOT),
        .PF_Select_C_bit38(_PF_Select_C_bit38_x1),
        .PF_Select_C_bit37(_PF_Select_C_bit37_x1),
        .PF_Select_H_bit16(_PF_Select_H_bit16_x1),
        .PF_Select_H_bit30(PF_Select_H_bit30),
        .PF_Select_H_bit17(_PF_Select_H_bit17_x1),
        .PF_Select_C_bit0(PF_Select_C_bit0),
        .PF_Select_C_bit17(PF_Select_C_bit17),
        .PA_Select_F_low(PA_Select_F_low),
        .PI_SelectDt_B(_PI_SelectDt_B_x1),
        .PI_SelectDt_C(_PI_SelectDt_C_x1),
        .PI_SelectDt_D(_PI_SelectDt_D_x1),
        .PI_SelectDt_E(_PI_SelectDt_E_x1),
        .PI_SelectDt_H(_PI_SelectDt_H_x1),
        .PI_SelectDt_L(_PI_SelectDt_L_x1),
        .PA_NOP(_PA_NOP_x1),
        .PA_Select_B_low(_PA_Select_B_low_x1),
        .PA_Select_C_low(_PA_Select_C_low_x1),
        .PA_Select_D_low(_PA_Select_D_low_x1),
        .PA_Select_E_low(_PA_Select_E_low_x1),
        .PA_Select_H_low(_PA_Select_H_low_x1),
        .PA_Select_L_low(_PA_Select_L_low_x1),
        .PC_RA0(PC_RA0),
        .PC_RA1(PC_RA1),
        .PC_RA2(PC_RA2),
        .PA_ADC(_PA_ADC_x1),
        .PA_SBC(_PA_SBC_x1),
        .PA_AND(PA_AND),
        .PA_XOR(PA_XOR),
        .PA_OR(_PA_OR_x1),
        .PF_Select_C_bit23(PF_Select_C_bit23),
        .PF_Select_C_bit26(_PF_Select_C_bit26_x1),
        .PF_Select_C_bit16(PF_Select_C_bit16),
        .PI_SelectAd_SP(_PI_SelectAd_SP_x1),
        .PR_Inc_SP(_PR_Inc_SP_x1),
        .PR_Write_PC_low(_PR_Write_PC_low_x1),
        .PR_Write_PC_high(_PR_Write_PC_high_x1),
        .PR_Exx(PR_Exx),
        .PR_Write_F(PR_Write_F),
        .PR_Write_Dtex(_PR_Write_Dtex_x1),
        .PI_SelectDt_Dtex(_PI_SelectDt_Dtex_x1),
        .PI_SelectAdt1(_PI_SelectAdt1_x1),
        .P2_Set_XBIT(P2_Set_XBIT),
        .PR_Ex_DE_HL(PR_Ex_DE_HL),
        .P2_Reset_IFF1(P2_Reset_IFF1), // <
        .P2_Reset_IFF2(P2_Reset_IFF2), // >
        .P2_Set_IFF1(P2_Set_IFF1), // <
        .P2_Set_IFF2(P2_Set_IFF2), // >
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
        .PR_Dec_SP(_PR_Dec_SP_x1),
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
        .PA_Select_0x8_low(_PA_Select_0x8_low_x1),
        .PA_Select_0x10_low(_PA_Select_0x10_low_x1),
        .PA_Select_0x18_low(PA_Select_0x18_low),
        .PA_Select_0x20_low(_PA_Select_0x20_low_x1),
        .PA_Select_0x28_low(PA_Select_0x28_low),
        .PA_Select_0x30_low(PA_Select_0x30_low),
        .PA_Select_0x38_low(PA_Select_0x38_low)
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_xbi4 | _PR_Reset_XPT_xi40 | _PR_Reset_XPT_xotr | _PR_Reset_XPT_xix | _PR_Reset_XPT_x1); // 8
    assign P2_Set_CMR = (_P2_Set_CMR_xi40 | _P2_Set_CMR_xix | _P2_Set_CMR_x1 | _P2_Set_CMR_xotr); // 6

    wire _end = (_P2_Set_CM1_xbi4 | _P2_Set_CM1_xotr | _P2_Set_CM1_xix); // 4
    assign P2_Set_CM1 = (_end | _P2_Set_CM1_x1); // 2
    assign Pa_Ophd = (_end | _Pa_Ophd_x1); // 2

    assign PR_Inc_PC = (_PR_Inc_PC_xbi4 | _PR_Inc_PC_xotr | _PR_Inc_PC_xix | _PR_Inc_PC_x1); // 6
    assign PR_Write_B = (_PR_Write_B_xbi4 | _PR_Write_B_xotr | _PR_Write_B_x1); // 4
    assign PR_Write_C = (_PR_Write_C_xbi4 | _PR_Write_C_xotr | _PR_Write_C_x1); // 4
    assign PR_Write_D = (_PR_Write_D_xbi4 | _PR_Write_D_xotr | _PR_Write_D_x1); // 4
    assign PR_Write_E = (_PR_Write_E_xbi4 | _PR_Write_E_xotr | _PR_Write_E_x1); // 4
    assign PR_Write_H = (_PR_Write_H_xbi4 | _PR_Write_H_xotr | _PR_Write_H_x1); // 4
    assign PR_Write_L = (_PR_Write_L_xbi4 | _PR_Write_L_xotr | _PR_Write_L_x1); // 4
    assign PR_Write_A = (_PR_Write_A_xbi4 | _PR_Write_A_xotr | _PR_Write_A_x1); // 4
    assign PA_Select_B_low = (_PA_Select_B_low_xbi4 | _PA_Select_B_low_x1); // 2
    assign PA_Select_C_low = (_PA_Select_C_low_xbi4 | _PA_Select_C_low_x1); // 2
    assign PA_Select_D_low = (_PA_Select_D_low_xbi4 | _PA_Select_D_low_x1); // 2
    assign PA_Select_E_low = (_PA_Select_E_low_xbi4 | _PA_Select_E_low_x1); // 2
    assign PA_Select_H_low = (_PA_Select_H_low_xbi4 | _PA_Select_H_low_x1); // 2
    assign PA_Select_L_low = (_PA_Select_L_low_xbi4 | _PA_Select_L_low_x1); // 2
    assign PA_Select_A_low = (_PA_Select_A_low_xbi4 | _PA_Select_A_low_xotr | _PA_Select_A_low_x1); // 4
    assign PA_Select_B_high = (_PA_Select_B_high_xbi4 | _PA_Select_B_high_xotr | _PA_Select_B_high_x1); // 4
    assign PA_Select_C_high = (_PA_Select_C_high_xbi4 | _PA_Select_C_high_x1); // 2
    assign PA_Select_D_high = (_PA_Select_D_high_xbi4 | _PA_Select_D_high_x1); // 2
    assign PA_Select_E_high = (_PA_Select_E_high_xbi4 | _PA_Select_E_high_x1); // 2
    assign PA_Select_H_high = (_PA_Select_H_high_xbi4 | _PA_Select_H_high_x1); // 2
    assign PA_Select_L_high = (_PA_Select_L_high_xbi4 | _PA_Select_L_high_x1); // 2
    assign PA_Select_A_high = (_PA_Select_A_high_xbi4 | _PA_Select_A_high_xotr | _PA_Select_A_high_x1); // 4
    assign PR_InvertIn = (_PR_InvertIn_xbi4 | _PR_InvertIn_xotr | _PR_InvertIn_xix | _PR_InvertIn_x1); // 6
    assign PI_SelectAd_HL = (_PI_SelectAd_HL_xbi4 | _PI_SelectAd_HL_xotr | _PI_SelectAd_HL_x1); // 4
    assign PR_Write_Dt = (_PR_Write_Dt_xbi4 | _PR_Write_Dt_xotr | _PR_Write_Dt_xix | _PR_Write_Dt_x1); // 6
    assign PR_Write_Dtex = (_PR_Write_Dtex_xbi4 | _PR_Write_Dtex_xix | _PR_Write_Dtex_x1); // 4
    assign PC_R0 = (_PC_R0_xbi4 | _PC_R0_xotr | _PC_R0_xix | _PC_R0_x1); // 6
    assign PC_R1 = (_PC_R1_xbi4 | _PC_R1_xotr | _PC_R1_xix | _PC_R1_x1); // 6
    assign PC_R2 = (_PC_R2_xbi4 | _PC_R2_xotr | _PC_R2_xix | _PC_R2_x1); // 6
    assign PC_W0 = (_PC_W0_xbi4 | _PC_W0_xotr | _PC_W0_xix | _PC_W0_x1); // 6
    assign PC_W1 = (_PC_W1_xbi4 | _PC_W1_xotr | _PC_W1_xix | _PC_W1_x1); // 6
    assign PC_W2 = (_PC_W2_xbi4 | _PC_W2_xotr | _PC_W2_xix | _PC_W2_x1); // 6
    assign PA_Select_Dt_low = (_PA_Select_Dt_low_xbi4 | _PA_Select_Dt_low_xotr); // 2
    assign PA_Select_Dt_high = (_PA_Select_Dt_high_xbi4 | _PA_Select_Dt_high_xotr | _PA_Select_Dt_high_x1); // 4
    assign PI_SelectDt_Dt = (_PI_SelectDt_Dt_xbi4 | _PI_SelectDt_Dt_xotr | _PI_SelectDt_Dt_xix | _PI_SelectDt_Dt_x1); // 6
    assign PI_SelectDt_Dtex = (_PI_SelectDt_Dtex_xix | _PI_SelectDt_Dtex_x1); // 2
    assign PA_ADD = (_PA_ADD_xbi4 | _PA_ADD_xotr | _PA_ADD_xix | _PA_ADD_x1); // 6
    assign PA_Select_IX_high = (_PA_Select_IX_high_xbi4 | _PA_Select_IX_high_xix); // 2
    assign PA_Select_IY_high = (_PA_Select_IY_high_xbi4 | _PA_Select_IY_high_xix); // 2
    assign PF_Write_Z = (_PF_Write_Z_xbi4 | _PF_Write_Z_xotr | _PF_Write_Z_x1); // 4
    assign PF_Write_N = (_PF_Write_N_xbi4 | _PF_Write_N_xotr | _PF_Write_N_xix | _PF_Write_N_x1); // 6
    assign PF_Write_H = (_PF_Write_H_xbi4 | _PF_Write_H_xotr | _PF_Write_H_xix | _PF_Write_H_x1); // 6
    assign PF_Write_C = (_PF_Write_C_xbi4 | _PF_Write_C_xotr | _PF_Write_C_xix | _PF_Write_C_x1); // 6
    assign PF_Write_PV = (_PF_Write_PV_xbi4 | _PF_Write_PV_xotr | _PF_Write_PV_x1); // 4
    assign PF_Write_S = (_PF_Write_S_xbi4 | _PF_Write_S_xotr | _PF_Write_S_x1); // 4
    assign PF_Select_N_bit16 = (_PF_Select_N_bit16_xbi4 | _PF_Select_N_bit16_xotr | _PF_Select_N_bit16_xix | _PF_Select_N_bit16_x1); // 6
    assign PF_Select_C_bit32 = (_PF_Select_C_bit32_xotr | _PF_Select_C_bit32_xix | _PF_Select_C_bit32_x1); // 4
    assign PF_Select_Z_bit24 = (_PF_Select_Z_bit24_xbi4 | _PF_Select_Z_bit24_xotr | _PF_Select_Z_bit24_x1); // 4
    assign PI_SelectDt_B = (_PI_SelectDt_B_xotr | _PI_SelectDt_B_x1); // 2
    assign PI_SelectDt_C = (_PI_SelectDt_C_xotr | _PI_SelectDt_C_x1); // 2
    assign PI_SelectDt_D = (_PI_SelectDt_D_xotr | _PI_SelectDt_D_x1); // 2
    assign PI_SelectDt_E = (_PI_SelectDt_E_xotr | _PI_SelectDt_E_x1); // 2
    assign PI_SelectDt_H = (_PI_SelectDt_H_xotr | _PI_SelectDt_H_x1); // 2
    assign PI_SelectDt_L = (_PI_SelectDt_L_xotr | _PI_SelectDt_L_x1); // 2
    assign PI_SelectDt_A = (_PI_SelectDt_A_xotr | _PI_SelectDt_A_x1); // 2
    assign PF_Select_S_bit7 = (_PF_Select_S_bit7_xbi4 | _PF_Select_S_bit7_xotr | _PF_Select_S_bit7_x1); // 4
    assign PF_Select_PV_bit27 = (_PF_Select_PV_bit27_xbi4 | _PF_Select_PV_bit27_xotr | _PF_Select_PV_bit27_x1); // 4
    assign PF_Select_H_bit16 = (_PF_Select_H_bit16_xbi4 | _PF_Select_H_bit16_xotr | _PF_Select_H_bit16_x1); // 4
    assign PF_Select_C_bit38 = (_PF_Select_C_bit38_xbi4 | _PF_Select_C_bit38_x1); // 2
    assign PF_Select_C_bit37 = (_PF_Select_C_bit37_xbi4 | _PF_Select_C_bit37_x1); // 2
    assign PF_Select_H_bit17 = (_PF_Select_H_bit17_xbi4 | _PF_Select_H_bit17_x1); // 2
    assign PA_NOP = (_PA_NOP_xbi4 | _PA_NOP_xotr | _PA_NOP_xix | _PA_NOP_x1); // 6
    assign PA_RLC = (_PA_RLC_xbi4 | _PA_RLC_x1); // 2
    assign PA_RL = (_PA_RL_xbi4 | _PA_RL_x1); // 2
    assign PA_RRC = (_PA_RRC_xbi4 | _PA_RRC_x1); // 2
    assign PA_RR = (_PA_RR_xbi4 | _PA_RR_x1); // 2
    assign PA_OR = (_PA_OR_xbi4 | _PA_OR_x1); // 2
    assign PA_Select_0x1_low = (_PA_Select_0x1_low_xbi4 | _PA_Select_0x1_low_xotr | _PA_Select_0x1_low_xix | _PA_Select_0x1_low_x1); // 6
    assign PA_Select_0x8_low = (_PA_Select_0x8_low_xbi4 | _PA_Select_0x8_low_x1); // 2
    assign PA_Select_0x10_low = (_PA_Select_0x10_low_xbi4 | _PA_Select_0x10_low_x1); // 2
    assign PA_Select_0x20_low = (_PA_Select_0x20_low_xbi4 | _PA_Select_0x20_low_x1); // 2
    assign PI_SelectAd_BC = (_PI_SelectAd_BC_xotr | _PI_SelectAd_BC_x1); // 2
    assign PF_Select_H_bit31 = (_PF_Select_H_bit31_xotr | _PF_Select_H_bit31_xix | _PF_Select_H_bit31_x1); // 4
    assign PA_Select_BC_low = (_PA_Select_BC_low_xotr | _PA_Select_BC_low_xix | _PA_Select_BC_low_x1); // 4
    assign PA_Select_DE_low = (_PA_Select_DE_low_xotr | _PA_Select_DE_low_xix | _PA_Select_DE_low_x1); // 4
    assign PA_Select_SP_low = (_PA_Select_SP_low_xotr | _PA_Select_SP_low_xix | _PA_Select_SP_low_x1); // 4
    assign PA_SUB = (_PA_SUB_xotr | _PA_SUB_xix | _PA_SUB_x1); // 4
    assign PI_SelectAd_SP = (_PI_SelectAd_SP_xotr | _PI_SelectAd_SP_xix | _PI_SelectAd_SP_x1); // 4
    assign PR_Inc_SP = (_PR_Inc_SP_xotr | _PR_Inc_SP_xix | _PR_Inc_SP_x1); // 4
    assign PI_SelectAdt1 = (_PI_SelectAdt1_xix | _PI_SelectAdt1_x1); // 2
    assign PR_Dec_SP = (_PR_Dec_SP_xix | _PR_Dec_SP_x1); // 2
    assign PR_Write_PC_high = (_PR_Write_PC_high_xotr | _PR_Write_PC_high_xix | _PR_Write_PC_high_x1); // 4
    assign PR_Write_PC_low = (_PR_Write_PC_low_xotr | _PR_Write_PC_low_xix | _PR_Write_PC_low_x1); // 4
    assign PA_Select_HL_high = (_PA_Select_HL_high_xotr | _PA_Select_HL_high_x1); // 2
    assign PA_SBC = (_PA_SBC_xotr | _PA_SBC_x1); // 2
    assign PF_Select_N_bit17 = (_PF_Select_N_bit17_xotr | _PF_Select_N_bit17_x1); // 2
    assign PA_ADC = (_PA_ADC_xotr | _PA_ADC_x1); // 2
    assign PA_Select_HL_low = (_PA_Select_HL_low_xotr | _PA_Select_HL_low_x1); // 2
    assign PF_Select_C_bit26 = (_PF_Select_C_bit26_xotr | _PF_Select_C_bit26_x1); // 2
    assign PF_Select_PV_bit25 = (_PF_Select_PV_bit25_xotr | _PF_Select_PV_bit25_x1); // 2
    assign PF_Select_H_bit22 = (_PF_Select_H_bit22_xotr | _PF_Select_H_bit22_x1); // 2
    assign PA_Select_BC_high = (_PA_Select_BC_high_xotr | _PA_Select_BC_high_x1); // 2
    assign PI_SelectAd_DE = (_PI_SelectAd_DE_xotr | _PI_SelectAd_DE_x1); // 2
    assign PA_Select_DE_high = (_PA_Select_DE_high_xotr | _PA_Select_DE_high_x1); // 2

    assign PR_Write_SP_high = (_PR_Write_SP_xix | _PR_Write_SP_high_x1); // 2
    assign PR_Write_SP_low = PR_Write_SP_high;

endmodule
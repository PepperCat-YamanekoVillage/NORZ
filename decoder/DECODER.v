// Pa/PhI/PC系の都合上うまいことデバッグができなかったが、実際はinitial RESETでうまくいくはず
// 314(5307)
module DECODER(
        input wire Clk,
        input wire notClk,
        input wire RESET,
        input wire TRESET,
        input wire BUSRQ,
        input wire TNMI,
        input wire TINT,
        input wire notIFF1,
        input wire IMFa,
        input wire IMFb,
        input wire notCRESET,
        input wire notCBUSRQ,
        input wire notCNMI,
        input wire notCINT0_RST,
        input wire notCINT0_CALL,
        input wire notCINT0,
        input wire notCINT1,
        input wire notCINT2,
        input wire notCM1, // XPT 0,1のみXOR
        input wire notCMR, // XPT 0,1のみXOR
        input wire notCMA, // XPT 0,1のみXOR
        input wire TWAIT,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        input wire [7:0] OP,
        input wire [7:0] Dtcs,
        input wire notIsResultLow0,
        input wire notXIX,
        input wire notXIX4_0,
        input wire notXIX4_1,
        input wire notXIY,
        input wire notXIY4_0,
        input wire notXIY4_1,
        input wire notXOTR,
        input wire notXBIT,
        input wire Flag_H,
        input wire Flag_Z,
        input wire Flag_C,
        input wire Flag_S,
        input wire Flag_N,
        input wire Flag_PV,
        input wire notFlag_Z,
        output wire P2_Set_CRESET,
        output wire P2_Reset_ALL_except_CRESET,
        output wire P2_Set_CBUSRQ,
        output wire PI_Nullify_MREQ,
        output wire PI_Nullify_RD,
        output wire PI_Nullify_WR,
        output wire PI_Nullify_IORQ,
        output wire PI_Flag_BUSAK,
        output wire PR_Halt_XPT,
        output wire P2_Set_CNMI,
        output wire P2_Reset_TNMI,
        output wire P2_Reset_LHALT,
        output wire P2_EvacuateIFF,
        output wire P2_Reset_IFF1,
        output wire P2_Set_CINT0,
        output wire P2_Set_CINT1,
        output wire P2_Set_CINT2,
        output wire P2_Reset_TINT,
        output wire P2_Reset_IFF2,
        output wire PI_Activate_Ad_high,
        output wire PI_Activate_Ad_low,
        output wire PI_SelectAd_PC,
        output wire PI_Flag_M1,
        output wire PR_Reset_XPT,
        output wire PA_NOP,
        output wire PR_Write_PC_low,
        output wire PR_Write_PC_high,
        output wire PR_Write_I,
        output wire PR_Write_R,
        output wire P2_Reset_CRESET,
        output wire P2_Set_CM1,
        output wire P2_IM0,
        output wire P2_Reset_CBUSRQ,
        output wire PR_Dec_SP,
        output wire PI_SelectDt_PC_high,
        output wire PI_SelectDt_PC_low,
        output wire PI_SelectAd_SP,
        output wire P2_Reset_CNMI,
        output wire PA_Select_0x66_low,
        output wire PA_Select_0x8_low,
        output wire PA_Select_0x10_low,
        output wire PA_Select_0x18_low,
        output wire PA_Select_0x20_low,
        output wire PA_Select_0x28_low,
        output wire PA_Select_0x30_low,
        output wire PA_Select_0x38_low,
        output wire P2_Reset_CINT,
        output wire PA_Select_OPOPold_low,
        output wire P2_Set_CINT0_RST,
        output wire P2_Set_CINT0_CALL,
        output wire PA_Select_IOP_low,
        output wire PI_Flag_IORQ,
        output wire PA_Select_Din_low,
        output wire PR_Write_OP,
        output wire PI_SelectAd_IR,
        output wire PI_Flag_RFSH,
        output wire PR_Inc_R,
        output wire PI_Flag_MREQ,
        output wire PI_Flag_RD,
        output wire P2_Reset_CM1,
        output wire PR_SlideOP,
        output wire P2_Reset_CMR,
        output wire PR_Inc_PC,
        output wire PI_Read_Dtcs,
        output wire PA_Select_Dtcs_low,
        output wire P2_Reset_CMA,
        output wire PI_Flag_WR,
        output wire PI_Activate_Dt,
        output wire PI_SelectAd_HL,
        output wire PI_SelectDt_OP,
        output wire P2_Reset_ITABLE,
        output wire P2_Set_CMR,
        output wire P2_Set_ILDlnnlHL_1,
        output wire PI_SelectDt_L,
        output wire PI_SelectDt_H,
        output wire PI_SelectAdt1,
        output wire PI_SelectAd_OPOPold,
        output wire P2_Set_ILDAlnnl_1,
        output wire PR_Write_A,
        output wire PR_InvertIn,
        output wire P2_Set_CMA,
        output wire P2_Set_IJPnn_1,
        output wire PA_Select_OP_high,
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
        output wire PA_Select_Dt_high,
        output wire PI_SelectAd_ALU,
        output wire PI_SelectDt_Dt,
        output wire P2_Set_ILDlIXtdln_1,
        output wire P2_Set_ILDlIYtdln_1,
        output wire PA_Select_OPold_low,
        output wire P2_Reset_XBIT,
        output wire PA_Select_B_low,
        output wire PA_Select_C_low,
        output wire PA_Select_D_low,
        output wire PA_Select_E_low,
        output wire PA_Select_H_low,
        output wire PA_Select_L_low,
        output wire PA_Select_A_low,
        output wire PA_Select_C_high,
        output wire PA_Select_D_high,
        output wire PA_Select_E_high,
        output wire PA_Select_H_high,
        output wire PA_Select_L_high,
        output wire PA_Select_Dt_low,
        output wire P2_Reset_XIX4,
        output wire P2_Reset_XIY4,
        output wire PF_Select_C_bit38,
        output wire PF_Select_C_bit37,
        output wire PA_RLC,
        output wire PA_RL,
        output wire PA_SLA,
        output wire PA_RRC,
        output wire PA_RR,
        output wire PA_SRA,
        output wire PA_SRL,
        output wire PA_NLAND,
        output wire PF_Select_Z_bit40,
        output wire PF_Select_Z_bit41,
        output wire PF_Select_Z_bit42,
        output wire PF_Select_Z_bit43,
        output wire PF_Select_Z_bit44,
        output wire PF_Select_Z_bit45,
        output wire PF_Select_Z_bit46,
        output wire PF_Select_Z_bit47,
        output wire PA_Select_0x2_low,
        output wire PA_Select_0x4_low,
        output wire PA_Select_0x20_low,
        output wire PA_Select_0x40_low,
        output wire PA_Select_0x80_low,
        output wire P2_Set_XIX4_1,
        output wire P2_Set_XIY4_1,
        output wire PI_SelectAd_BC,
        output wire PI_SelectDt_C,
        output wire PI_SelectDt_E,
        output wire P2_Reset_XOTR,
        output wire PA_Select_HL_high,
        output wire PF_Select_Z_bit34,
        output wire PF_Select_PV_bit33,
        output wire PF_Select_S_bit15,
        output wire PF_Select_C_bit36,
        output wire PF_Select_H_bit35,
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
        output wire PR_Inc_SP,
        output wire P2_RestoreIFF,
        output wire P2_IM1,
        output wire P2_IM2,
        output wire PF_Select_Z_bit19,
        output wire PF_Select_PV_bit18,
        output wire PA_Select_I_low,
        output wire PA_Select_R_low,
        output wire PA_RRD,
        output wire PA_RLD,
        output wire PA_Select_BC_high,
        output wire PF_Select_PV_bit20,
        output wire PI_SelectAd_DE,
        output wire PA_Select_DE_high,
        output wire P2_Reset_XIX,
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
        output wire PF_Select_H_bit28,
        output wire PA_Select_0x60_low,
        output wire PA_Select_0x06_low,
        output wire PA_NOT,
        output wire PF_Select_H_bit30,
        output wire PF_Select_C_bit0,
        output wire PF_Select_C_bit17,
        output wire PA_Select_F_low,
        output wire PR_Exx,
        output wire PR_Write_F,
        output wire P2_Set_XBIT,
        output wire PR_Ex_DE_HL,
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
        output wire P2_Set_IADDAn,
        output wire P2_Set_IADCAn,
        output wire P2_Set_ISUBAn,
        output wire P2_Set_ISBCAn,
        output wire P2_Set_IANDn,
        output wire P2_Set_IXORn,
        output wire P2_Set_IORn,
        output wire P2_Set_ICPn
    );

    // wire notClk = ~Clk;
    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    wire _decodeing_drst;

    DECODER_reset drst(
        .RESET(RESET),
        .TRESET(TRESET),
        .P2_Set_CRESET(P2_Set_CRESET),
        .P2_Reset_ALL_except_CRESET(P2_Reset_ALL_except_CRESET),
        .decoding(_decodeing_drst)
    );

    wire _notPa_ophd  = ~(_Pa_Ophd_dc | _Pa_Ophd_di | _Pa_Ophd_dop); // 3

    wire _P2_Set_CBUSRQ_pohd;
    wire _PI_Nullify_MREQ_pohd;
    wire _PI_Nullify_RD_pohd;
    wire _PI_Nullify_WR_pohd;
    wire _PI_Nullify_IORQ_pohd;
    wire _PI_Flag_BUSAK_pohd;
    wire _PR_Halt_XPT_pohd;
    wire _PhI_Flag_BUSAK_pohd;
    wire _P2_Reset_IFF1_pohd;
    wire _PC_M1_pohd;
    wire _P2_Reset_IFF2_pohd;
    wire _PI_Activate_Ad_high_pohd;
    wire _PI_Activate_Ad_low_pohd;
    wire _PI_SelectAd_PC_pohd;
    wire _PI_Flag_M1_pohd;

    wire _not_decodingOut_pohd;

    DECODER_ophd dophd(
        .Clk(Clk),
        .notClk(notClk),
        .decodingIn(_decodeing_drst),
        .notPa_ophd(_notPa_ophd),
        .BUSRQ(BUSRQ),
        .TNMI(TNMI),
        .TINT(TINT),
        .notIFF1(notIFF1),
        .IMFa(IMFa),
        .IMFb(IMFb),
        .P2_Set_CBUSRQ(_P2_Set_CBUSRQ_pohd),
        .PI_Nullify_MREQ(_PI_Nullify_MREQ_pohd),
        .PI_Nullify_RD(_PI_Nullify_RD_pohd),
        .PI_Nullify_WR(_PI_Nullify_WR_pohd),
        .PI_Nullify_IORQ(_PI_Nullify_IORQ_pohd),
        .PI_Flag_BUSAK(_PI_Flag_BUSAK_pohd),
        .PR_Halt_XPT(_PR_Halt_XPT_pohd),
        .PhI_Flag_BUSAK(_PhI_Flag_BUSAK_pohd),
        .P2_Set_CNMI(P2_Set_CNMI),
        .P2_Reset_TNMI(P2_Reset_TNMI),
        .P2_Reset_LHALT(P2_Reset_LHALT),
        .P2_EvacuateIFF(P2_EvacuateIFF),
        .P2_Reset_IFF1(_P2_Reset_IFF1_pohd),
        .PC_M1(_PC_M1_pohd),
        .P2_Set_CINT0(P2_Set_CINT0),
        .P2_Set_CINT1(P2_Set_CINT1),
        .P2_Set_CINT2(P2_Set_CINT2),
        .P2_Reset_TINT(P2_Reset_TINT),
        .P2_Reset_IFF2(_P2_Reset_IFF2_pohd),
        .PI_Activate_Ad_high(_PI_Activate_Ad_high_pohd),
        .PI_Activate_Ad_low(_PI_Activate_Ad_low_pohd),
        .PI_SelectAd_PC(_PI_SelectAd_PC_pohd),
        .PI_Flag_M1(_PI_Flag_M1_pohd),
        .not_decodingOut(_not_decodingOut_pohd)
    );

    wire [7:0] _notOP = ~OP[7:0]; // 8

    wire _PR_Reset_XPT_dc;
    wire _PA_NOP_dc;
    wire _PR_Write_PC_low_dc;
    wire _PR_Write_PC_high_dc;
    wire _PR_Write_I_dc;
    wire _PR_Write_R_dc;
    wire _P2_Set_CM1_dc;
    wire _P2_IM0_dc;
    wire _P2_Reset_IFF1_dc;
    wire _P2_Reset_IFF2_dc;
    wire _Pa_Ophd_dc;
    wire _P2_Set_CBUSRQ_dc;
    wire _PI_Nullify_MREQ_dc;
    wire _PI_Nullify_RD_dc;
    wire _PI_Nullify_WR_dc;
    wire _PI_Nullify_IORQ_dc;
    wire _PI_Flag_BUSACK_dc;
    wire _PhI_Flag_BUSACK_dc;
    wire _PR_Halt_XPT_dc;
    wire _PC_M1_dc;
    wire _PC_W0_dc;
    wire _PC_W1_dc;
    wire _PC_W2_dc;
    wire _PR_Dec_SP_dc;
    wire _PI_SelectDt_PC_high_dc;
    wire _PI_SelectDt_PC_low_dc;
    wire _PI_SelectAd_SP_dc;
    wire _PA_Select_0x66_low_dc;
    wire _PA_Select_0x8_low_dc;
    wire _PA_Select_0x10_low_dc;
    wire _PA_Select_0x18_low_dc;
    wire _PA_Select_0x20_low_dc;
    wire _PA_Select_0x28_low_dc;
    wire _PA_Select_0x30_low_dc;
    wire _PA_Select_0x38_low_dc;
    wire _PC_MR0_dc;
    wire _PC_MR1_dc;
    wire _PC_MR2_dc;
    wire _PA_Select_OPOPold_low_dc;
    wire _PI_SelectAd_PC_dc;
    wire _PI_Flag_M1_dc;
    wire _PI_Activate_Ad_high_dc;
    wire _PI_Activate_Ad_low_dc;
    wire _PhI_Flag_IORQ_dc;
    wire _PI_Flag_IORQ_dc;
    wire _PA_Select_Din_low_dc;
    wire _PR_Write_OP_dc;
    wire _PI_SelectAd_IR_dc;
    wire _PI_Flag_RFSH_dc;
    wire _PhI_Flag_MREQ_dc;
    wire _PR_Inc_R_dc;
    wire _PC_MR_dc;
    wire _PD_Source_Dtcs_dc;
    wire _PC_MA_dc;

    wire _not_decodingOut_dc;

    DECODER_C dc(
        .Clk(Clk),
        .not_decodingIn(_not_decodingOut_pohd),
        .notCRESET(notCRESET),
        .notCBUSRQ(notCBUSRQ),
        .notCNMI(notCNMI),
        .notCINT0_RST(notCINT0_RST),
        .notCINT0_CALL(notCINT0_CALL),
        .notCINT0(notCINT0),
        .notCINT1(notCINT1),
        .notCINT2(notCINT2),
        .notCM1(notCM1), // XPT 0(),1のみXOR
        .notCMR(notCMR), // XPT 0(),1のみXOR
        .notCMA(notCMA), // XPT 0(),1のみXOR
        .BUSRQ(BUSRQ),
        .TWAIT(TWAIT),
        .XPT(XPT),
        .notXPT(notXPT),
        .OP(OP[5:0]),
        .notOP(_notOP[5:0]),
        .PR_Reset_XPT(_PR_Reset_XPT_dc),
        .PA_NOP(_PA_NOP_dc),
        .PR_Write_PC_low(_PR_Write_PC_low_dc),
        .PR_Write_PC_high(_PR_Write_PC_high_dc),
        .PR_Write_I(_PR_Write_I_dc),
        .PR_Write_R(_PR_Write_R_dc),
        .P2_Reset_CRESET(P2_Reset_CRESET),
        .P2_Set_CM1(_P2_Set_CM1_dc),
        .P2_IM0(_P2_IM0_dc),
        .P2_Reset_IFF1(_P2_Reset_IFF1_dc),
        .P2_Reset_IFF2(_P2_Reset_IFF2_dc),
        .Pa_Ophd(_Pa_Ophd_dc),
        .P2_Set_CBUSRQ(_P2_Set_CBUSRQ_dc),
        .PI_Nullify_MREQ(_PI_Nullify_MREQ_dc),
        .PI_Nullify_RD(_PI_Nullify_RD_dc),
        .PI_Nullify_WR(_PI_Nullify_WR_dc),
        .PI_Nullify_IORQ(_PI_Nullify_IORQ_dc),
        .PI_Flag_BUSACK(_PI_Flag_BUSACK_dc),
        .PhI_Flag_BUSACK(_PhI_Flag_BUSACK_dc),
        .PR_Halt_XPT(_PR_Halt_XPT_dc),
        .P2_Reset_CBUSRQ(P2_Reset_CBUSRQ),
        .PC_M1(_PC_M1_dc),
        .PC_W0(_PC_W0_dc),
        .PC_W1(_PC_W1_dc),
        .PC_W2(_PC_W2_dc),
        .PR_Dec_SP(_PR_Dec_SP_dc),
        .PI_SelectDt_PC_high(_PI_SelectDt_PC_high_dc),
        .PI_SelectDt_PC_low(_PI_SelectDt_PC_low_dc),
        .PI_SelectAd_SP(_PI_SelectAd_SP_dc),
        .P2_Reset_CNMI(P2_Reset_CNMI),
        .PA_Select_0x66_low(_PA_Select_0x66_low_dc),
        .PA_Select_0x8_low(_PA_Select_0x8_low_dc),
        .PA_Select_0x10_low(_PA_Select_0x10_low_dc),
        .PA_Select_0x18_low(_PA_Select_0x18_low_dc),
        .PA_Select_0x20_low(_PA_Select_0x20_low_dc),
        .PA_Select_0x28_low(_PA_Select_0x28_low_dc),
        .PA_Select_0x30_low(_PA_Select_0x30_low_dc),
        .PA_Select_0x38_low(_PA_Select_0x38_low_dc),
        .PC_MR0(_PC_MR0_dc),
        .PC_MR1(_PC_MR1_dc),
        .PC_MR2(_PC_MR2_dc),
        .P2_Reset_CINT(P2_Reset_CINT),
        .PA_Select_OPOPold_low(_PA_Select_OPOPold_low_dc),
        .P2_Set_CINT0_RST(P2_Set_CINT0_RST),
        .P2_Set_CINT0_CALL(P2_Set_CINT0_CALL),
        .PA_Select_IOP_low(PA_Select_IOP_low),
        .PI_SelectAd_PC(_PI_SelectAd_PC_dc),
        .PI_Flag_M1(_PI_Flag_M1_dc),
        .PI_Activate_Ad_high(_PI_Activate_Ad_high_dc),
        .PI_Activate_Ad_low(_PI_Activate_Ad_low_dc),
        .PhI_Flag_IORQ(_PhI_Flag_IORQ_dc),
        .PI_Flag_IORQ(_PI_Flag_IORQ_dc),
        .PA_Select_Din_low(_PA_Select_Din_low_dc),
        .PR_Write_OP(_PR_Write_OP_dc),
        .PI_SelectAd_IR(_PI_SelectAd_IR_dc),
        .PI_Flag_RFSH(_PI_Flag_RFSH_dc),
        .PhI_Flag_MREQ(_PhI_Flag_MREQ_dc),
        .PR_Inc_R(_PR_Inc_R_dc),
        .PC_MR(_PC_MR_dc),
        .PD_Source_Dtcs(_PD_Source_Dtcs_dc),
        .PC_MA(_PC_MA_dc),
        .not_decodingOut(_not_decodingOut_dc),
    );

    wire _PC_M1 = (_PC_M1_pohd | _PC_M1_dc); // 2
    wire _PC_MR = _PC_MR_dc;
    wire _PC_MR0 = _PC_MR0_dc;
    wire _PC_MR1 = _PC_MR1_dc;
    wire _PC_MR2 = _PC_MR2_dc;
    wire _PC_MA = _PC_MA_dc;
    wire _PC_W0 = (_PC_W0_dc | _PC_W0_di | _PC_W0_dop); // 4
    wire _PC_W1 = (_PC_W1_dc | _PC_W1_di | _PC_W1_dop); // 4
    wire _PC_W2 = (_PC_W2_dc | _PC_W2_di | _PC_W2_dop); // 4
    wire _PC_R0 = (_PC_R0_di | _PC_R0_dop); // 2
    wire _PC_R1 = (_PC_R1_di | _PC_R1_dop); // 2
    wire _PC_R2 = (_PC_R2_di | _PC_R2_dop); // 2
    wire _PC_RA0 = (_PC_RA0_di | _PC_RA0_dop); // 2
    wire _PC_RA1 = (_PC_RA1_di | _PC_RA1_dop); // 2
    wire _PC_RA2 = (_PC_RA2_di | _PC_RA2_dop); // 2
    wire _PC_I0 = (_PC_I0_di | _PC_I0_dop); // 2
    wire _PC_I1 = (_PC_I1_di | _PC_I1_dop); // 2
    wire _PC_I2 = (_PC_I2_di | _PC_I2_dop); // 2
    wire _PC_I3 = (_PC_I3_di | _PC_I3_dop); // 2
    wire _PC_O0 = (_PC_O0_di | _PC_O0_dop); // 2
    wire _PC_O1 = (_PC_O1_di | _PC_O1_dop); // 2
    wire _PC_O2 = (_PC_O2_di | _PC_O2_dop); // 2
    wire _PC_O3 = (_PC_O3_di | _PC_O3_dop); // 2

    wire _PI_Activate_Ad_high_db;
    wire _PI_Activate_Ad_low_db;
    wire _PI_SelectAd_PC_db;
    wire _PI_Flag_M1_db;
    wire _PhI_Flag_MREQ_db;
    wire _PhI_Flag_RD_db;
    wire _PI_Flag_MREQ_db;
    wire _PI_Flag_RD_db;
    wire _PA_Select_Din_low_db;
    wire _PA_NOP_db;
    wire _PR_Write_OP_db;
    wire _PR_Halt_XPT_db;
    wire _PI_SelectAd_IR_db;
    wire _PI_Flag_RFSH_db;
    wire _PR_Inc_R_db;
    wire _PR_Inc_PC_db;
    wire _PI_Flag_IORQ_db;
    wire _PhI_Flag_IORQ_db;
    wire _PI_Flag_WR_db;
    wire _PhI_Flag_WR_db;
    wire _PI_Activate_Dt_db;
    wire _PhI_Activate_Dt_db;

    DECODER_basic dbasic(
        .TWAIT(TWAIT),
        .XPT(XPT[1:0]),
        .notXPT(notXPT[1:0]),
        .PC_M1(_PC_M1),
        .PC_MR(_PC_MR),
        .PC_MR0(_PC_MR0),
        .PC_MR1(_PC_MR1),
        .PC_MR2(_PC_MR2),
        .PC_MA(_PC_MA),
        .PC_W0(_PC_W0),
        .PC_W1(_PC_W1),
        .PC_W2(_PC_W2),
        .PC_R0(_PC_R0),
        .PC_R1(_PC_R1),
        .PC_R2(_PC_R2),
        .PC_RA0(_PC_RA0),
        .PC_RA1(_PC_RA1),
        .PC_RA2(_PC_RA2),
        .PC_I0(_PC_I0),
        .PC_I1(_PC_I1),
        .PC_I2(_PC_I2),
        .PC_I3(_PC_I3),
        .PC_O0(_PC_O0),
        .PC_O1(_PC_O1),
        .PC_O2(_PC_O2),
        .PC_O3(_PC_O3),
        .PI_Activate_Ad_high(_PI_Activate_Ad_high_db),
        .PI_Activate_Ad_low(_PI_Activate_Ad_low_db),
        .PI_SelectAd_PC(_PI_SelectAd_PC_db),
        .PI_Flag_M1(_PI_Flag_M1_db),
        .PhI_Flag_MREQ(_PhI_Flag_MREQ_db),
        .PhI_Flag_RD(_PhI_Flag_RD_db),
        .PI_Flag_MREQ(_PI_Flag_MREQ_db),
        .PI_Flag_RD(_PI_Flag_RD_db),
        .PA_Select_Din_low(_PA_Select_Din_low_db),
        .PA_NOP(_PA_NOP_db),
        .PR_Write_OP(_PR_Write_OP_db),
        .PR_Halt_XPT(_PR_Halt_XPT_db),
        .PI_SelectAd_IR(_PI_SelectAd_IR_db),
        .PI_Flag_RFSH(_PI_Flag_RFSH_db),
        .P2_Reset_CM1(P2_Reset_CM1),
        .PR_Inc_R(_PR_Inc_R_db),
        .PR_SlideOP(PR_SlideOP),
        .P2_Reset_CMR(P2_Reset_CMR),
        .PR_Inc_PC(_PR_Inc_PC_db),
        .PI_Read_Dtcs(PI_Read_Dtcs),
        .PA_Select_Dtcs_low(PA_Select_Dtcs_low),
        .P2_Reset_CMA(P2_Reset_CMA),
        .PI_Flag_IORQ(_PI_Flag_IORQ_db),
        .PhI_Flag_IORQ(_PhI_Flag_IORQ_db),
        .PI_Flag_WR(_PI_Flag_WR_db),
        .PI_Activate_Dt(_PI_Activate_Dt_db),
        .PhI_Activate_Dt(_PhI_Activate_Dt_db),
        .PhI_Flag_WR(_PhI_Flag_WR_db)
    );

    wire _PI_SelectAd_HL_di;
    wire _PC_W0_di;
    wire _PC_W1_di;
    wire _PC_W2_di;
    wire _PR_Reset_XPT_di;
    wire _P2_Set_CM1_di;
    wire _Pa_Ophd_di;
    wire _P2_Set_CMR_di;
    wire _PI_SelectDt_L_di;
    wire _PI_SelectDt_H_di;
    wire _PI_SelectAdt1_di;
    wire _PC_R0_di;
    wire _PC_R1_di;
    wire _PC_R2_di;
    wire _PR_Write_A_di;
    wire _PR_InvertIn_di;
    wire _P2_Set_CMA_di;
    wire _PA_NOP_di;
    wire _PR_Write_PC_high_di;
    wire _PR_Write_PC_low_di;
    wire _PR_Write_B_di;
    wire _PR_Write_C_di;
    wire _PR_Write_D_di;
    wire _PR_Write_E_di;
    wire _PR_Write_H_di;
    wire _PR_Write_L_di;
    wire _PA_Select_IX_high_di;
    wire _PA_Select_IY_high_di;
    wire _PA_ADD_di;
    wire _PR_Write_Dt_di;
    wire _PR_Write_Dtex_di;
    wire _PI_SelectAd_DtexDt_di;
    wire _PR_Write_SP_low_di;
    wire _PR_Write_SP_high_di;
    wire _PI_SelectDt_A_di;
    wire _PI_SelectDt_B_di;
    wire _PI_SelectDt_D_di;
    wire _PA_Select_A_high_di;
    wire _PF_Write_S_di;
    wire _PF_Select_S_bit7_di;
    wire _PF_Write_Z_di;
    wire _PF_Select_Z_bit24_di;
    wire _PF_Write_H_di;
    wire _PF_Write_PV_di;
    wire _PF_Write_N_di;
    wire _PF_Write_C_di;
    wire _PA_ADC_di;
    wire _PA_SUB_di;
    wire _PA_SBC_di;
    wire _PA_AND_di;
    wire _PA_OR_di;
    wire _PA_XOR_di;
    wire _PF_Select_H_bit22_di;
    wire _PF_Select_N_bit17_di;
    wire _PF_Select_C_bit26_di;
    wire _PF_Select_H_bit21_di;
    wire _PF_Select_C_bit23_di;
    wire _PF_Select_H_bit16_di;
    wire _PF_Select_PV_bit27_di;
    wire _PF_Select_C_bit16_di;
    wire _PF_Select_H_bit17_di;
    wire _PF_Select_N_bit16_di;
    wire _PF_Select_PV_bit25_di;
    wire _PR_Write_IX_low_di;
    wire _PR_Write_IY_low_di;
    wire _PR_Dec_SP_di;
    wire _PI_SelectDt_PC_high_di;
    wire _PI_SelectAd_SP_di;
    wire _PI_SelectDt_PC_low_di;
    wire _PA_Select_OPOPold_low_di;
    wire _PC_I0_di;
    wire _PC_I1_di;
    wire _PC_I2_di;
    wire _PC_I3_di;
    wire _PC_O0_di;
    wire _PC_O1_di;
    wire _PC_O2_di;
    wire _PC_O3_di;
    wire _PI_SelectDt_IX_low_di;
    wire _PI_SelectDt_IY_low_di;
    wire _PI_SelectDt_IX_high_di;
    wire _PI_SelectDt_IY_high_di;
    wire _PA_Select_PC_high_di;
    wire _PA_Select_B_high_di;
    wire _PA_Select_0x1_low_di;
    wire _PC_RA0_di;
    wire _PC_RA1_di;
    wire _PC_RA2_di;
    wire _PA_Select_Dt_high_di;
    wire _PI_SelectAd_ALU_di;
    wire _PI_SelectDt_Dt_di;
    wire _PA_Select_OPold_low_di;

    wire _not_decodingOut_di;

    DECODER_I di(
        .not_decodingIn(_not_decodingOut_dc),
        .XPT(XPT[3:0]),
        .notXPT(notXPT[3:0]),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .Flag_C(Flag_C),
        .Flag_Z(Flag_Z),
        .notIsResultLow0(notIsResultLow0),
        .OP7(OP[7]),
        .notOP7(_notOP7[7]),
        .Flag_PV(Flag_PV),
        .Flag_S(Flag_S),
        .not_decodingOut(_not_decodingOut_di),
        .PI_SelectAd_HL(_PI_SelectAd_HL_di),
        .PI_SelectDt_OP(PI_SelectDt_OP),
        .PC_W0(_PC_W0_di),
        .PC_W1(_PC_W1_di),
        .PC_W2(_PC_W2_di),
        .PR_Reset_XPT(_PR_Reset_XPT_di),
        .P2_Set_CM1(_P2_Set_CM1_di), // <
        .P2_Reset_ITABLE(P2_Reset_ITABLE),
        .Pa_Ophd(_Pa_Ophd_di), // >
        .P2_Set_CMR(_P2_Set_CMR_di),
        .P2_Set_ILDlnnlHL_1(P2_Set_ILDlnnlHL_1),
        .PI_SelectDt_L(_PI_SelectDt_L_di),
        .PI_SelectDt_H(_PI_SelectDt_H_di),
        .PI_SelectAdt1(_PI_SelectAdt1_di),
        .PI_SelectAd_OPOPold(PI_SelectAd_OPOPold),
        .P2_Set_ILDAlnnl_1(P2_Set_ILDAlnnl_1),
        .PC_R0(_PC_R0_di),
        .PC_R1(_PC_R1_di),
        .PC_R2(_PC_R2_di),
        .PR_Write_A(_PR_Write_A_di),
        .PR_InvertIn(_PR_InvertIn_di),
        .P2_Set_CMA(_P2_Set_CMA_di),
        .P2_Set_IJPnn_1(P2_Set_IJPnn_1),
        .PA_Select_OP_high(PA_Select_OP_high),
        .PA_NOP(_PA_NOP_di),
        .PR_Write_PC_high(_PR_Write_PC_high_di),
        .PR_Write_PC_low(_PR_Write_PC_low_di),
        .PR_Write_B(_PR_Write_B_di),
        .PR_Write_C(_PR_Write_C_di),
        .PR_Write_D(_PR_Write_D_di),
        .PR_Write_E(_PR_Write_E_di),
        .PR_Write_H(_PR_Write_H_di),
        .PR_Write_L(_PR_Write_L_di),
        .PA_Select_IX_high(_PA_Select_IX_high_di),
        .PA_Select_IY_high(_PA_Select_IY_high_di),
        .PA_Select_OP_low(PA_Select_OP_low),
        .PA_ADD(_PA_ADD_di),
        .PR_Write_Dt(_PR_Write_Dt_di),
        .PR_Write_Dtex(_PR_Write_Dtex_di),
        .PI_SelectAd_DtexDt(_PI_SelectAd_DtexDt_di),
        .P2_Set_ILDddnn_BC_1(P2_Set_ILDddnn_BC_1),
        .P2_Set_ILDddnn_DE_1(P2_Set_ILDddnn_DE_1),
        .P2_Set_ILDddnn_HL_1(P2_Set_ILDddnn_HL_1),
        .P2_Set_ILDddnn_SP_1(P2_Set_ILDddnn_SP_1),
        .PR_Write_SP_low(_PR_Write_SP_low_di),
        .PR_Write_SP_high(_PR_Write_SP_high_di),
        .P2_Set_ILDddlnnl_BC_1(P2_Set_ILDddlnnl_BC_1),
        .P2_Set_ILDddlnnl_DE_1(P2_Set_ILDddlnnl_DE_1),
        .P2_Set_ILDddlnnl_HL_1(P2_Set_ILDddlnnl_HL_1),
        .P2_Set_ILDddlnnl_SP_1(P2_Set_ILDddlnnl_SP_1),
        .PI_SelectDt_A(_PI_SelectDt_A_di),
        .PI_SelectDt_B(_PI_SelectDt_B_di),
        .PI_SelectDt_D(_PI_SelectDt_D_di),
        .P2_Set_ILDlnnldd_BC_1(P2_Set_ILDlnnldd_BC_1),
        .P2_Set_ILDlnnldd_DE_1(P2_Set_ILDlnnldd_DE_1),
        .P2_Set_ILDlnnldd_HL_1(P2_Set_ILDlnnldd_HL_1),
        .P2_Set_ILDlnnldd_SP_1(P2_Set_ILDlnnldd_SP_1),
        .PI_SelectDt_SP_low(PI_SelectDt_SP_low),
        .PI_SelectDt_SP_high(PI_SelectDt_SP_high),
        .PA_Select_A_high(_PA_Select_A_high_di),
        .PF_Write_S(_PF_Write_S_di),
        .PF_Select_S_bit7(_PF_Select_S_bit7_di),
        .PF_Write_Z(_PF_Write_Z_di),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_di),
        .PF_Write_H(_PF_Write_H_di),
        .PF_Write_PV(_PF_Write_PV_di),
        .PF_Write_N(_PF_Write_N_di),
        .PF_Write_C(_PF_Write_C_di),
        .PA_ADC(_PA_ADC_di),
        .PA_SUB(_PA_SUB_di),
        .PA_SBC(_PA_SBC_di),
        .PA_AND(_PA_AND_di),
        .PA_OR(_PA_OR_di),
        .PA_XOR(_PA_XOR_di),
        .PF_Select_H_bit22(_PF_Select_H_bit22_di),
        .PF_Select_N_bit17(_PF_Select_N_bit17_di),
        .PF_Select_C_bit26(_PF_Select_C_bit26_di),
        .PF_Select_H_bit21(_PF_Select_H_bit21_di),
        .PF_Select_C_bit23(_PF_Select_C_bit23_di),
        .PF_Select_H_bit16(_PF_Select_H_bit16_di),
        .PF_Select_PV_bit27(_PF_Select_PV_bit27_di),
        .PF_Select_C_bit16(_PF_Select_C_bit16_di),
        .PF_Select_H_bit17(_PF_Select_H_bit17_di),
        .PF_Select_N_bit16(_PF_Select_N_bit16_di),
        .PF_Select_PV_bit25(_PF_Select_PV_bit25_di),
        .PR_Write_IX_low(_PR_Write_IX_low_di),
        .PR_Write_IY_low(_PR_Write_IY_low_di),
        .P2_Set_ILDlnnlA_1(P2_Set_ILDlnnlA_1),
        .P2_Set_ILDIXnn_1(P2_Set_ILDIXnn_1),
        .P2_Set_ILDHLlnnl_1(P2_Set_ILDHLlnnl_1),
        .P2_Set_ILDIYnn_1(P2_Set_ILDIYnn_1),
        .P2_Set_ILDIXlnnl_1(P2_Set_ILDIXlnnl_1),
        .P2_Set_ILDIYlnnl_1(P2_Set_ILDIYlnnl_1),
        .P2_Set_ICALLnn_1(P2_Set_ICALLnn_1),
        .PR_Write_IX_high(PR_Write_IX_high),
        .PR_Write_IY_high(PR_Write_IY_high),
        .PR_Dec_SP(_PR_Dec_SP_di),
        .PI_SelectDt_PC_high(_PI_SelectDt_PC_high_di),
        .PI_SelectAd_SP(_PI_SelectAd_SP_di),
        .PI_SelectDt_PC_low(_PI_SelectDt_PC_low_di),
        .PA_Select_OPOPold_low(_PA_Select_OPOPold_low_di),
        .PC_I0(_PC_I0_di),
        .PC_I1(_PC_I1_di),
        .PC_I2(_PC_I2_di),
        .PC_I3(_PC_I3_di),
        .PC_O0(_PC_O0_di),
        .PC_O1(_PC_O1_di),
        .PC_O2(_PC_O2_di),
        .PC_O3(_PC_O3_di),
        .PI_SelectAd_AOP(PI_SelectAd_AOP),
        .P2_Set_ILDlnnlIX_1(P2_Set_ILDlnnlIX_1),
        .P2_Set_ILDlnnlIY_1(P2_Set_ILDlnnlIY_1),
        .PI_SelectDt_IX_low(_PI_SelectDt_IX_low_di),
        .PI_SelectDt_IY_low(_PI_SelectDt_IY_low_di),
        .PI_SelectDt_IX_high(_PI_SelectDt_IX_high_di),
        .PI_SelectDt_IY_high(_PI_SelectDt_IY_high_di),
        .PA_Select_PC_high(_PA_Select_PC_high_di),
        .PA_Select_0xffOP_low(PA_Select_0xffOP_low),
        .PA_Select_B_high(_PA_Select_B_high_di),
        .PA_Select_0x1_low(_PA_Select_0x1_low_di),
        .P2_Set_IJPccnn_0_1(P2_Set_IJPccnn_0_1),
        .P2_Set_IJPccnn_1_1(P2_Set_IJPccnn_1_1),
        .P2_Set_IJPccnn_2_1(P2_Set_IJPccnn_2_1),
        .P2_Set_IJPccnn_3_1(P2_Set_IJPccnn_3_1),
        .P2_Set_IJPccnn_4_1(P2_Set_IJPccnn_4_1),
        .P2_Set_IJPccnn_5_1(P2_Set_IJPccnn_5_1),
        .P2_Set_IJPccnn_6_1(P2_Set_IJPccnn_6_1),
        .P2_Set_IJPccnn_7_1(P2_Set_IJPccnn_7_1),
        .P2_Set_ICALLccnn_0_1(P2_Set_ICALLccnn_0_1),
        .P2_Set_ICALLccnn_1_1(P2_Set_ICALLccnn_1_1),
        .P2_Set_ICALLccnn_2_1(P2_Set_ICALLccnn_2_1),
        .P2_Set_ICALLccnn_3_1(P2_Set_ICALLccnn_3_1),
        .P2_Set_ICALLccnn_4_1(P2_Set_ICALLccnn_4_1),
        .P2_Set_ICALLccnn_5_1(P2_Set_ICALLccnn_5_1),
        .P2_Set_ICALLccnn_6_1(P2_Set_ICALLccnn_6_1),
        .P2_Set_ICALLccnn_7_1(P2_Set_ICALLccnn_7_1),
        .PC_RA0(_PC_RA0_di),
        .PC_RA1(_PC_RA1_di),
        .PC_RA2(_PC_RA2_di),
        .PA_Select_Dt_high(_PA_Select_Dt_high_di),
        .PI_SelectAd_ALU(_PI_SelectAd_ALU_di),
        .PI_SelectDt_Dt(_PI_SelectDt_Dt_di),
        .P2_Set_ILDlIXtdln_1(P2_Set_ILDlIXtdln_1),
        .P2_Set_ILDlIYtdln_1(P2_Set_ILDlIYtdln_1),
        .PA_Select_OPold_low(_PA_Select_OPold_low_di)
    );

    DECODER_X dx(
        .not_decodingIn(_not_decodingOut_di),
        .notXIX(notXIX),
        .notXIX4_0(notXIX4_0),
        .notXIX4_1(notXIX4_1),
        .notXIY(notXIY),
        .notXIY4_0(notXIY4_0),
        .notXIY4_1(notXIY4_1),
        .notXOTR(notXOTR),
        .notXBIT(notXBIT),
        .not_enable_X1(not_enable_X1),
        .not_enable_XOTR(not_enable_XOTR),
        .not_enable_XBIT(not_enable_XBIT),
        .not_enable_XIX(not_enable_XIX),
        .not_enable_XIX4_1(not_enable_XIX4_1),
        .not_enable_XIX4_0(not_enable_XIX4_0),
        .is_Y(is_Y)
    );

    wire _PR_Inc_PC_dop;
    wire _PR_Reset_XPT_dop;
    wire _P2_Set_CM1_dop;
    wire _Pa_Ophd_dop;
    wire _PR_Write_B_dop;
    wire _PR_Write_C_dop;
    wire _PR_Write_D_dop;
    wire _PR_Write_E_dop;
    wire _PR_Write_H_dop;
    wire _PR_Write_L_dop;
    wire _PR_Write_A_dop;
    wire _PA_Select_B_high_dop;
    wire _PA_Select_A_high_dop;
    wire _PR_InvertIn_dop;
    wire _PI_SelectAd_HL_dop;
    wire _PR_Write_Dt_dop;
    wire _PC_R0_dop;
    wire _PC_R1_dop;
    wire _PC_R2_dop;
    wire _PA_Select_Dt_high_dop;
    wire _PI_SelectDt_Dt_dop;
    wire _PC_W0_dop;
    wire _PC_W1_dop;
    wire _PC_W2_dop;
    wire _PR_Write_Dtex_dop;
    wire _PI_SelectAd_DtexDt_dop;
    wire _PI_SelectAd_ALU_dop;
    wire _PA_Select_OPold_low_dop;
    wire _PA_ADD_dop;
    wire _PA_Select_IX_high_dop;
    wire _PA_Select_IY_high_dop;
    wire _PF_Write_Z_dop;
    wire _PF_Write_N_dop;
    wire _PF_Write_H_dop;
    wire _PF_Write_C_dop;
    wire _PF_Write_PV_dop;
    wire _PF_Write_S_dop;
    wire _PF_Select_N_bit16_dop;
    wire _PF_Select_Z_bit24_dop;
    wire _PF_Select_S_bit7_dop;
    wire _PF_Select_PV_bit27_dop;
    wire _PF_Select_H_bit16_dop;
    wire _PF_Select_H_bit17_dop;
    wire _PA_NOP_dop;
    wire _PA_OR_dop;
    wire _PA_Select_0x1_low_dop;
    wire _PA_Select_0x8_low_dop;
    wire _PA_Select_0x10_low_dop;
    wire _PA_Select_0x20_low_dop;
    wire _P2_Set_CMR_dop;
    wire _PI_SelectDt_B_dop;
    wire _PI_SelectDt_D_dop;
    wire _PI_SelectDt_H_dop;
    wire _PI_SelectDt_L_dop;
    wire _PI_SelectDt_A_dop;
    wire _PC_I0_dop;
    wire _PC_I1_dop;
    wire _PC_I2_dop;
    wire _PC_I3_dop;
    wire _PC_O0_dop;
    wire _PC_O1_dop;
    wire _PC_O2_dop;
    wire _PC_O3_dop;
    wire _PA_SBC_dop;
    wire _PF_Select_N_bit17_dop;
    wire _PA_ADC_dop;
    wire _PA_SUB_dop;
    wire _PF_Select_C_bit26_dop;
    wire _PF_Select_PV_bit25_dop;
    wire _PF_Select_H_bit22_dop;
    wire _PI_SelectAd_SP_dop;
    wire _PR_Write_PC_low_dop;
    wire _PR_Write_PC_high_dop;
    wire _P2_IM0_dop;
    wire _PR_Write_I_dop;
    wire _PR_Write_R_dop;
    wire _PA_Select_PC_high_dop;
    wire _PR_Write_IX_high_dop;
    wire _PR_Write_IX_low_dop;
    wire _PR_Write_IY_high_dop;
    wire _PR_Write_IY_low_dop;
    wire _PI_SelectAdt1_dop;
    wire _PR_Dec_SP_dop;
    wire _PI_SelectDt_IX_high_dop;
    wire _PI_SelectDt_IY_high_dop;
    wire _PI_SelectDt_IX_low_dop;
    wire _PI_SelectDt_IY_low_dop;
    wire _PR_Write_SP_high_dop;
    wire _PR_Write_SP_low_dop;
    wire _PF_Select_H_bit21_dop;
    wire _PA_Select_0x66_low_dop;
    wire _PC_RA0_dop;
    wire _PC_RA1_dop;
    wire _PC_RA2_dop;
    wire _PA_AND_dop;
    wire _PA_XOR_dop;
    wire _PF_Select_C_bit23_dop;
    wire _PF_Select_C_bit16_dop;
    wire _P2_Reset_IFF1_dop;
    wire _P2_Reset_IFF2_dop;
    wire _PI_SelectDt_PC_high_dop;
    wire _PI_SelectDt_PC_low_dop;
    wire _PA_Select_0x18_low_dop;
    wire _PA_Select_0x28_low_dop;
    wire _PA_Select_0x30_low_dop;
    wire _PA_Select_0x38_low_dop;
    wire _P2_Set_CMA_dop;

    DECODER_op dop(
        .not_enable_X1(not_enable_X1),
        .not_enable_XOTR(not_enable_XOTR),
        .not_enable_XBIT(not_enable_XBIT),
        .not_enable_XIX(not_enable_XIX),
        .not_enable_XIX4_1(not_enable_XIX4_1),
        .not_enable_XIX4_0(not_enable_XIX4_0),
        .is_Y(is_Y),
        .XPT(XPT),
        .notXPT(notXPT),
        .OP(OP),
        .Dtcs(Dtcs),
        .PD_Source_Dtcs(_PD_Source_Dtcs_dc),
        .Flag_H(Flag_H),
        .Flag_Z(Flag_Z),
        .Flag_C(Flag_C),
        .Flag_S(Flag_S),
        .Flag_N(Flag_N),
        .Flag_PV(Flag_PV),
        .notFlag_Z(notFlag_Z),
        .PR_Inc_PC(_PR_Inc_PC_dop),
        .PR_Reset_XPT(_PR_Reset_XPT_dop),
        .P2_Set_CM1(_P2_Set_CM1_dop),
        .Pa_Ophd(_Pa_Ophd_dop),
        .P2_Reset_XBIT(P2_Reset_XBIT),
        .PR_Write_B(_PR_Write_B_dop),
        .PR_Write_C(_PR_Write_C_dop),
        .PR_Write_D(_PR_Write_D_dop),
        .PR_Write_E(_PR_Write_E_dop),
        .PR_Write_H(_PR_Write_H_dop),
        .PR_Write_L(_PR_Write_L_dop),
        .PR_Write_A(_PR_Write_A_dop),
        .PA_Select_B_low(PA_Select_B_low),
        .PA_Select_C_low(PA_Select_C_low),
        .PA_Select_D_low(PA_Select_D_low),
        .PA_Select_E_low(PA_Select_E_low),
        .PA_Select_H_low(PA_Select_H_low),
        .PA_Select_L_low(PA_Select_L_low),
        .PA_Select_A_low(PA_Select_A_low),
        .PA_Select_B_high(_PA_Select_B_high_dop),
        .PA_Select_C_high(PA_Select_C_high),
        .PA_Select_D_high(PA_Select_D_high),
        .PA_Select_E_high(PA_Select_E_high),
        .PA_Select_H_high(PA_Select_H_high),
        .PA_Select_L_high(PA_Select_L_high),
        .PA_Select_A_high(_PA_Select_A_high_dop),
        .PR_InvertIn(_PR_InvertIn_dop),
        .PI_SelectAd_HL(_PI_SelectAd_HL_dop),
        .PR_Write_Dt(_PR_Write_Dt_dop),
        .PC_R0(_PC_R0_dop),
        .PC_R1(_PC_R1_dop),
        .PC_R2(_PC_R2_dop),
        .PA_Select_Dt_low(PA_Select_Dt_low),
        .PA_Select_Dt_high(_PA_Select_Dt_high_dop),
        .PI_SelectDt_Dt(_PI_SelectDt_Dt_dop),
        .PC_W0(_PC_W0_dop),
        .PC_W1(_PC_W1_dop),
        .PC_W2(_PC_W2_dop),
        .PR_Write_Dtex(_PR_Write_Dtex_dop),
        .PI_SelectAd_DtexDt(_PI_SelectAd_DtexDt_dop),
        .P2_Reset_XIX4(P2_Reset_XIX4),
        .P2_Reset_XIY4(P2_Reset_XIY4),
        .PI_SelectAd_ALU(_PI_SelectAd_ALU_dop),
        .PA_Select_OPold_low(_PA_Select_OPold_low_dop),
        .PA_ADD(_PA_ADD_dop),
        .PA_Select_IX_high(_PA_Select_IX_high_dop),
        .PA_Select_IY_high(_PA_Select_IY_high_dop),
        .PF_Write_Z(_PF_Write_Z_dop),
        .PF_Write_N(_PF_Write_N_dop),
        .PF_Write_H(_PF_Write_H_dop),
        .PF_Write_C(_PF_Write_C_dop),
        .PF_Write_PV(_PF_Write_PV_dop),
        .PF_Write_S(_PF_Write_S_dop),
        .PF_Select_N_bit16(_PF_Select_N_bit16_dop),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_dop),
        .PF_Select_S_bit7(_PF_Select_S_bit7_dop),
        .PF_Select_PV_bit27(_PF_Select_PV_bit27_dop),
        .PF_Select_H_bit16(_PF_Select_H_bit16_dop),
        .PF_Select_C_bit38(PF_Select_C_bit38),
        .PF_Select_C_bit37(PF_Select_C_bit37),
        .PF_Select_H_bit17(_PF_Select_H_bit17_dop),
        .PA_RLC(PA_RLC),
        .PA_RL(PA_RL),
        .PA_SLA(PA_SLA),
        .PA_RRC(PA_RRC),
        .PA_RR(PA_RR),
        .PA_SRA(PA_SRA),
        .PA_SRL(PA_SRL),
        .PA_NOP(_PA_NOP_dop),
        .PA_OR(_PA_OR_dop),
        .PA_NLAND(PA_NLAND),
        .PF_Select_Z_bit40(PF_Select_Z_bit40),
        .PF_Select_Z_bit41(PF_Select_Z_bit41),
        .PF_Select_Z_bit42(PF_Select_Z_bit42),
        .PF_Select_Z_bit43(PF_Select_Z_bit43),
        .PF_Select_Z_bit44(PF_Select_Z_bit44),
        .PF_Select_Z_bit45(PF_Select_Z_bit45),
        .PF_Select_Z_bit46(PF_Select_Z_bit46),
        .PF_Select_Z_bit47(PF_Select_Z_bit47),
        .PA_Select_0x1_low(_PA_Select_0x1_low_dop),
        .PA_Select_0x2_low(PA_Select_0x2_low),
        .PA_Select_0x4_low(PA_Select_0x4_low),
        .PA_Select_0x8_low(_PA_Select_0x8_low_dop),
        .PA_Select_0x10_low(_PA_Select_0x10_low_dop),
        .PA_Select_0x20_low(_PA_Select_0x20_low_dop),
        .PA_Select_0x40_low(PA_Select_0x40_low),
        .PA_Select_0x80_low(PA_Select_0x80_low),
        .P2_Set_CMR(_P2_Set_CMR_dop),
        .P2_Set_XIX4_1(P2_Set_XIX4_1),
        .P2_Set_XIY4_1(P2_Set_XIY4_1),
        .PI_SelectAd_BC(PI_SelectAd_BC),
        .PI_SelectDt_B(_PI_SelectDt_B_dop),
        .PI_SelectDt_C(PI_SelectDt_C),
        .PI_SelectDt_D(_PI_SelectDt_D_dop),
        .PI_SelectDt_E(PI_SelectDt_E),
        .PI_SelectDt_H(_PI_SelectDt_H_dop),
        .PI_SelectDt_L(_PI_SelectDt_L_dop),
        .PI_SelectDt_A(_PI_SelectDt_A_dop),
        .PC_I0(_PC_I0_dop),
        .PC_I1(_PC_I1_dop),
        .PC_I2(_PC_I2_dop),
        .PC_I3(_PC_I3_dop),
        .PC_O0(_PC_O0_dop),
        .PC_O1(_PC_O1_dop),
        .PC_O2(_PC_O2_dop),
        .PC_O3(_PC_O3_dop),
        .P2_Reset_XOTR(P2_Reset_XOTR),
        .PA_Select_HL_high(PA_Select_HL_high),
        .PF_Select_Z_bit34(PF_Select_Z_bit34),
        .PF_Select_PV_bit33(PF_Select_PV_bit33),
        .PF_Select_S_bit15(PF_Select_S_bit15),
        .PA_SBC(_PA_SBC_dop),
        .PF_Select_C_bit36(PF_Select_C_bit36),
        .PF_Select_N_bit17(_PF_Select_N_bit17_dop),
        .PF_Select_H_bit35(PF_Select_H_bit35),
        .PA_ADC(_PA_ADC_dop),
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
        .PA_SUB(_PA_SUB_dop),
        .PF_Select_C_bit26(_PF_Select_C_bit26_dop),
        .PF_Select_PV_bit25(_PF_Select_PV_bit25_dop),
        .PF_Select_H_bit22(_PF_Select_H_bit22_dop),
        .PI_SelectAd_SP(_PI_SelectAd_SP_dop),
        .PR_Inc_SP(PR_Inc_SP),
        .PR_Write_PC_low(_PR_Write_PC_low_dop),
        .PR_Write_PC_high(_PR_Write_PC_high_dop),
        .P2_RestoreIFF(P2_RestoreIFF),
        .P2_IM0(_P2_IM0_dop),
        .P2_IM1(P2_IM1),
        .P2_IM2(P2_IM2),
        .PR_Write_I(_PR_Write_I_dop),
        .PR_Write_R(_PR_Write_R_dop),
        .PF_Select_Z_bit19(PF_Select_Z_bit19),
        .PF_Select_PV_bit18(PF_Select_PV_bit18),
        .PA_Select_I_low(PA_Select_I_low),
        .PA_Select_R_low(PA_Select_R_low),
        .PA_RRD(PA_RRD),
        .PA_RLD(PA_RLD),
        .PA_Select_BC_high(PA_Select_BC_high),
        .PF_Select_PV_bit20(PF_Select_PV_bit20),
        .PA_Select_PC_high(_PA_Select_PC_high_dop),
        .PI_SelectAd_DE(PI_SelectAd_DE),
        .PA_Select_DE_high(PA_Select_DE_high),
        .PR_Write_IX_high(_PR_Write_IX_high_dop),
        .PR_Write_IX_low(_PR_Write_IX_low_dop),
        .P2_Reset_XIX(P2_Reset_XIX),
        .PR_Write_IY_high(_PR_Write_IY_high_dop),
        .PR_Write_IY_low(_PR_Write_IY_low_dop),
        .P2_Reset_XIY(P2_Reset_XIY),
        .PA_Select_IX_low(PA_Select_IX_low),
        .PA_Select_IY_low(PA_Select_IY_low),
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
        .PI_SelectDt_Dtex(PI_SelectDt_Dtex),
        .PI_SelectAdt1(_PI_SelectAdt1_dop),
        .PR_Dec_SP(_PR_Dec_SP_dop),
        .PI_SelectDt_IX_high(_PI_SelectDt_IX_high_dop),
        .PI_SelectDt_IY_high(_PI_SelectDt_IY_high_dop),
        .PI_SelectDt_IX_low(_PI_SelectDt_IX_low_dop),
        .PI_SelectDt_IY_low(_PI_SelectDt_IY_low_dop),
        .P2_Set_LHALT(P2_Set_LHALT),
        .PR_Ex_AF_AF(PR_Ex_AF_AF),
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
        .P2_Set_ILDlnnlHL_0(P2_Set_ILDlnnlHL_0),
        .P2_Set_ILDHLlnnl_0(P2_Set_ILDHLlnnl_0),
        .P2_Set_ILDlnnlA_0(P2_Set_ILDlnnlA_0),
        .P2_Set_ILDAlnnl_0(P2_Set_ILDAlnnl_0),
        .PA_Select_SP_high(PA_Select_SP_high), 
        .PR_Write_SP_high(_PR_Write_SP_high_dop), // <
        .PR_Write_SP_low(_PR_Write_SP_low_dop), // >
        .PF_Select_H_bit21(_PF_Select_H_bit21_dop),
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
        .PF_Select_H_bit28(PF_Select_H_bit28),
        .PA_Select_0x60_low(PA_Select_0x60_low),
        .PA_Select_0x06_low(PA_Select_0x06_low),
        .PA_Select_0x66_low(_PA_Select_0x66_low_dop),
        .PA_NOT(PA_NOT),
        .PF_Select_H_bit30(PF_Select_H_bit30),
        .PF_Select_C_bit0(PF_Select_C_bit0),
        .PF_Select_C_bit17(PF_Select_C_bit17),
        .PA_Select_F_low(PA_Select_F_low),
        .PC_RA0(_PC_RA0_dop),
        .PC_RA1(_PC_RA1_dop),
        .PC_RA2(_PC_RA2_dop),
        .PA_AND(_PA_AND_dop),
        .PA_XOR(_PA_XOR_dop),
        .PF_Select_C_bit23(_PF_Select_C_bit23_dop),
        .PF_Select_C_bit16(_PF_Select_C_bit16_dop),
        .PR_Exx(PR_Exx),
        .PR_Write_F(PR_Write_F),
        .P2_Set_XBIT(P2_Set_XBIT),
        .PR_Ex_DE_HL(PR_Ex_DE_HL),
        .P2_Reset_IFF1(_P2_Reset_IFF1_dop), // <
        .P2_Reset_IFF2(_P2_Reset_IFF2_dop), // >
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
        .P2_Set_CMA(_P2_Set_CMA_dop),
        .P2_Set_IADDAn(P2_Set_IADDAn),
        .P2_Set_IADCAn(P2_Set_IADCAn),
        .P2_Set_ISUBAn(P2_Set_ISUBAn),
        .P2_Set_ISBCAn(P2_Set_ISBCAn),
        .P2_Set_IANDn(P2_Set_IANDn),
        .P2_Set_IXORn(P2_Set_IXORn),
        .P2_Set_IORn(P2_Set_IORn),
        .P2_Set_ICPn(P2_Set_ICPn),
        .PI_SelectDt_PC_high(_PI_SelectDt_PC_high_dop),
        .PI_SelectDt_PC_low(_PI_SelectDt_PC_low_dop),
        .PA_Select_0x18_low(_PA_Select_0x18_low_dop),
        .PA_Select_0x28_low(_PA_Select_0x28_low_dop),
        .PA_Select_0x30_low(_PA_Select_0x30_low_dop),
        .PA_Select_0x38_low(_PA_Select_0x38_low_dop)
    );

    wire _notPhI_Flag_BUSAK = _PhI_Flag_BUSAK_pohd ~| _PhI_Flag_BUSACK_dc;
    wire _PI_Flag_BUSAK_dff;
    DECODER_dff busack(
        .Clk(notClk),
        .notClk(Clk),
        .notD(_notPhI_Flag_BUSAK),
        .Q(_PI_Flag_BUSAK_dff)
    );
    assign PI_Flag_BUSAK = (_PI_Flag_BUSAK_pohd | _PI_Flag_BUSACK_dc | _PI_Flag_BUSAK_dff); // 4

    wire _notPhI_Flag_IORQ = _PhI_Flag_IORQ_dc ~| _PhI_Flag_IORQ_db;
    wire _PI_Flag_IORQ_dff;
    DECODER_dff iorq(
        .Clk(notClk),
        .notClk(Clk),
        .notD(_notPhI_Flag_IORQ),
        .Q(_PI_Flag_IORQ_dff)
    );
    assign PI_Flag_IORQ = (_PI_Flag_IORQ_dc | _PI_Flag_IORQ_db | _PI_Flag_IORQ_dff); // 4

    wire _notPhI_Flag_MREQ = _PhI_Flag_MREQ_dc ~| _PhI_Flag_MREQ_db;
    wire _PI_Flag_MREQ_dff;
    DECODER_dff mreq(
        .Clk(notClk),
        .notClk(Clk),
        .notD(_notPhI_Flag_MREQ),
        .Q(_PI_Flag_MREQ_dff)
    );
    assign PI_Flag_MREQ = (_PI_Flag_MREQ_db | _PI_Flag_MREQ_dff); // 2

    wire _PI_Flag_WR_dff;
    DECODER_dff wr(
        .Clk(notClk),
        .notClk(Clk),
        .notD(_PhI_Flag_WR_db),
        .notQ(_PI_Flag_WR_dff)
    );
    assign PI_Flag_WR = (_PI_Flag_WR_db | _PI_Flag_WR_dff); // 2

    wire _PI_Flag_RD_dff;
    DECODER_dff rd(
        .Clk(notClk),
        .notClk(Clk),
        .notD(_PhI_Flag_RD_db),
        .notQ(_PI_Flag_RD_dff)
    );
    assign PI_Flag_RD = (_PI_Flag_RD_db | _PI_Flag_RD_dff); // 2

    wire _PI_Activate_Dt_dff;
    DECODER_dff acdt(
        .Clk(notClk),
        .notClk(Clk),
        .notD(_PhI_Activate_Dt_db),
        .notQ(_PI_Activate_Dt_dff)
    );
    assign PI_Activate_Dt = (_PI_Activate_Dt_db | _PI_Activate_Dt_dff); // 2

    assign P2_Set_CBUSRQ = (_P2_Set_CBUSRQ_pohd | _P2_Set_CBUSRQ_dc); // 2
    assign PI_Nullify_MREQ = (_PI_Nullify_MREQ_pohd | _PI_Nullify_MREQ_dc); // 2
    assign PI_Nullify_RD = (_PI_Nullify_RD_pohd | _PI_Nullify_RD_dc); // 
    assign PI_Nullify_WR = (_PI_Nullify_WR_pohd | _PI_Nullify_WR_dc); // 2
    assign PI_Nullify_IORQ = (_PI_Nullify_IORQ_pohd | _PI_Nullify_IORQ_dc); // 2
    assign PI_Activate_Ad_high = (_PI_Activate_Ad_high_pohd | _PI_Activate_Ad_high_dc | _PI_Activate_Ad_high_db); // 4
    assign PI_Activate_Ad_low = (_PI_Activate_Ad_low_pohd | _PI_Activate_Ad_low_dc | _PI_Activate_Ad_low_db); // 4
    assign PI_SelectAd_PC = (_PI_SelectAd_PC_pohd | _PI_SelectAd_PC_dc | _PI_SelectAd_PC_db); // 4
    assign PI_Flag_M1 = (_PI_Flag_M1_pohd | _PI_Flag_M1_dc | _PI_Flag_M1_db); // 4
    assign PR_Halt_XPT = (_PR_Halt_XPT_pohd | _PR_Halt_XPT_dc | _PR_Halt_XPT_db); // 4
    assign P2_Reset_IFF1 = (_P2_Reset_IFF1_pohd | _P2_Reset_IFF1_dc | _P2_Reset_IFF1_dop); // 4
    assign P2_Reset_IFF2 = (_P2_Reset_IFF2_pohd | _P2_Reset_IFF2_dc | _P2_Reset_IFF2_dop); // 4
    assign PR_Reset_XPT = (_PR_Reset_XPT_dc | _PR_Reset_XPT_di | _PR_Reset_XPT_dop); // 4
    assign PA_NOP = (_PA_NOP_dc | _PA_NOP_db | _PA_NOP_di | _PA_NOP_dop); // 6
    assign PR_Write_PC_low = (_PR_Write_PC_low_dc | _PR_Write_PC_low_di | _PR_Write_PC_low_dop); // 4
    assign PR_Write_PC_high = (_PR_Write_PC_high_dc | _PR_Write_PC_high_di | _PR_Write_PC_high_dop); // 4
    assign PR_Write_I = (_PR_Write_I_dc | _PR_Write_I_dop); // 2
    assign PR_Write_R = (_PR_Write_R_dc | _PR_Write_R_dop); // 2
    assign P2_Set_CM1 = (_P2_Set_CM1_dc | _P2_Set_CM1_di | _P2_Set_CM1_dop); // 4
    assign P2_IM0 = (_P2_IM0_dc | _P2_IM0_dop); // 2
    assign PR_Dec_SP = (_PR_Dec_SP_dc | _PR_Dec_SP_di | _PR_Dec_SP_dop); // 4
    assign PI_SelectDt_PC_high = (_PI_SelectDt_PC_high_dc | _PI_SelectDt_PC_high_di | _PI_SelectDt_PC_high_dop); // 4
    assign PI_SelectDt_PC_low = (_PI_SelectDt_PC_low_dc | _PI_SelectDt_PC_low_di | _PI_SelectDt_PC_low_dop); // 4
    assign PI_SelectAd_SP = (_PI_SelectAd_SP_dc | _PI_SelectAd_SP_di | _PI_SelectAd_SP_dop); // 4
    assign PA_Select_0x66_low = (_PA_Select_0x66_low_dc | _PA_Select_0x66_low_dop); // 2
    assign PA_Select_0x8_low = (_PA_Select_0x8_low_dc | _PA_Select_0x8_low_dop); // 2
    assign PA_Select_0x10_low = (_PA_Select_0x10_low_dc | _PA_Select_0x10_low_dop); // 2
    assign PA_Select_0x18_low = (_PA_Select_0x18_low_dc | _PA_Select_0x18_low_dop); // 2
    assign PA_Select_0x20_low = (_PA_Select_0x20_low_dc | _PA_Select_0x20_low_dop); // 2
    assign PA_Select_0x28_low = (_PA_Select_0x28_low_dc | _PA_Select_0x28_low_dop); // 2
    assign PA_Select_0x30_low = (_PA_Select_0x30_low_dc | _PA_Select_0x30_low_dop); // 2
    assign PA_Select_0x38_low = (_PA_Select_0x38_low_dc | _PA_Select_0x38_low_dop); // 2
    assign PA_Select_OPOPold_low = (_PA_Select_OPOPold_low_dc | _PA_Select_OPOPold_low_di); // 2
    assign PA_Select_Din_low = (_PA_Select_Din_low_dc | _PA_Select_Din_low_db); // 2
    assign PR_Write_OP = (_PR_Write_OP_dc | _PR_Write_OP_db); // 2
    assign PI_SelectAd_IR = (_PI_SelectAd_IR_dc | _PI_SelectAd_IR_db); // 2
    assign PI_Flag_RFSH = (_PI_Flag_RFSH_dc | _PI_Flag_RFSH_db); // 2
    assign PR_Inc_R = (_PR_Inc_R_dc | _PR_Inc_R_db); // 2
    assign PR_Inc_PC = (_PR_Inc_PC_db | _PR_Inc_PC_dop); // 2
    assign PI_SelectAd_HL = (_PI_SelectAd_HL_di | _PI_SelectAd_HL_dop); // 2
    assign P2_Set_CMR = (_P2_Set_CMR_di | _P2_Set_CMR_dop); // 2
    assign PI_SelectDt_L = (_PI_SelectDt_L_di | _PI_SelectDt_L_dop); // 2
    assign PI_SelectDt_H = (_PI_SelectDt_H_di | _PI_SelectDt_H_dop); // 2
    assign PI_SelectAdt1 = (_PI_SelectAdt1_di | _PI_SelectAdt1_dop); // 2
    assign PR_Write_A = (_PR_Write_A_di | _PR_Write_A_dop); // 2
    assign PR_InvertIn = (_PR_InvertIn_di | _PR_InvertIn_dop); // 2
    assign P2_Set_CMA = (_P2_Set_CMA_di | _P2_Set_CMA_dop); // 2
    assign PR_Write_B = (_PR_Write_B_di | _PR_Write_B_dop); // 2
    assign PR_Write_C = (_PR_Write_C_di | _PR_Write_C_dop); // 2
    assign PR_Write_D = (_PR_Write_D_di | _PR_Write_D_dop); // 2
    assign PR_Write_E = (_PR_Write_E_di | _PR_Write_E_dop); // 2
    assign PR_Write_H = (_PR_Write_H_di | _PR_Write_H_dop); // 2
    assign PR_Write_L = (_PR_Write_L_di | _PR_Write_L_dop); // 2
    assign PA_Select_IX_high = (_PA_Select_IX_high_di | _PA_Select_IX_high_dop); // 2
    assign PA_Select_IY_high = (_PA_Select_IY_high_di | _PA_Select_IY_high_dop); // 2
    assign PA_ADD = (_PA_ADD_di | _PA_ADD_dop); // 2
    assign PR_Write_Dt = (_PR_Write_Dt_di | _PR_Write_Dt_dop); // 2
    assign PR_Write_Dtex = (_PR_Write_Dtex_di | _PR_Write_Dtex_dop); // 2
    assign PI_SelectAd_DtexDt = (_PI_SelectAd_DtexDt_di | _PI_SelectAd_DtexDt_dop); // 2
    assign PR_Write_SP_low = (_PR_Write_SP_low_di | _PR_Write_SP_low_dop); // 2
    assign PR_Write_SP_high = (_PR_Write_SP_high_di | _PR_Write_SP_high_dop); // 2
    assign PI_SelectDt_A = (_PI_SelectDt_A_di | _PI_SelectDt_A_dop); // 2
    assign PI_SelectDt_B = (_PI_SelectDt_B_di | _PI_SelectDt_B_dop); // 2
    assign PI_SelectDt_D = (_PI_SelectDt_D_di | _PI_SelectDt_D_dop); // 2
    assign PA_Select_A_high = (_PA_Select_A_high_di | _PA_Select_A_high_dop); // 2
    assign PF_Write_S = (_PF_Write_S_di | _PF_Write_S_dop); // 2
    assign PF_Select_S_bit7 = (_PF_Select_S_bit7_di | _PF_Select_S_bit7_dop); // 2
    assign PF_Write_Z = (_PF_Write_Z_di | _PF_Write_Z_dop); // 2
    assign PF_Select_Z_bit24 = (_PF_Select_Z_bit24_di | _PF_Select_Z_bit24_dop); // 2
    assign PF_Write_H = (_PF_Write_H_di | _PF_Write_H_dop); // 2
    assign PF_Write_PV = (_PF_Write_PV_di | _PF_Write_PV_dop); // 2
    assign PF_Write_N = (_PF_Write_N_di | _PF_Write_N_dop); // 2
    assign PF_Write_C = (_PF_Write_C_di | _PF_Write_C_dop); // 2
    assign PA_ADC = (_PA_ADC_di | _PA_ADC_dop); // 2
    assign PA_SUB = (_PA_SUB_di | _PA_SUB_dop); // 2
    assign PA_SBC = (_PA_SBC_di | _PA_SBC_dop); // 2
    assign PA_AND = (_PA_AND_di | _PA_AND_dop); // 2
    assign PA_OR = (_PA_OR_di | _PA_OR_dop); // 2
    assign PA_XOR = (_PA_XOR_di | _PA_XOR_dop); // 2
    assign PF_Select_H_bit22 = (_PF_Select_H_bit22_di | _PF_Select_H_bit22_dop); // 2
    assign PF_Select_N_bit17 = (_PF_Select_N_bit17_di | _PF_Select_N_bit17_dop); // 2
    assign PF_Select_C_bit26 = (_PF_Select_C_bit26_di | _PF_Select_C_bit26_dop); // 2
    assign PF_Select_H_bit21 = (_PF_Select_H_bit21_di | _PF_Select_H_bit21_dop); // 2
    assign PF_Select_C_bit23 = (_PF_Select_C_bit23_di | _PF_Select_C_bit23_dop); // 2
    assign PF_Select_H_bit16 = (_PF_Select_H_bit16_di | _PF_Select_H_bit16_dop); // 2
    assign PF_Select_PV_bit27 = (_PF_Select_PV_bit27_di | _PF_Select_PV_bit27_dop); // 2
    assign PF_Select_C_bit16 = (_PF_Select_C_bit16_di | _PF_Select_C_bit16_dop); // 2
    assign PF_Select_H_bit17 = (_PF_Select_H_bit17_di | _PF_Select_H_bit17_dop); // 2
    assign PF_Select_N_bit16 = (_PF_Select_N_bit16_di | _PF_Select_N_bit16_dop); // 2
    assign PF_Select_PV_bit25 = (_PF_Select_PV_bit25_di | _PF_Select_PV_bit25_dop); // 2
    assign PR_Write_IX_low = (_PR_Write_IX_low_di | _PR_Write_IX_low_dop); // 2
    assign PR_Write_IY_low = (_PR_Write_IY_low_di | _PR_Write_IY_low_dop); // 2
    assign PI_SelectDt_IX_low = (_PI_SelectDt_IX_low_di | _PI_SelectDt_IX_low_dop); // 2
    assign PI_SelectDt_IY_low = (_PI_SelectDt_IY_low_di | _PI_SelectDt_IY_low_dop); // 2
    assign PI_SelectDt_IX_high = (_PI_SelectDt_IX_high_di | _PI_SelectDt_IX_high_dop); // 2
    assign PI_SelectDt_IY_high = (_PI_SelectDt_IY_high_di | _PI_SelectDt_IY_high_dop); // 2
    assign PA_Select_PC_high = (_PA_Select_PC_high_di | _PA_Select_PC_high_dop); // 2
    assign PA_Select_B_high = (_PA_Select_B_high_di | _PA_Select_B_high_dop); // 2
    assign PA_Select_0x1_low = (_PA_Select_0x1_low_di | _PA_Select_0x1_low_dop); // 2
    assign PA_Select_Dt_high = (_PA_Select_Dt_high_di | _PA_Select_Dt_high_dop); // 2
    assign PI_SelectAd_ALU = (_PI_SelectAd_ALU_di | _PI_SelectAd_ALU_dop); // 2
    assign PI_SelectDt_Dt = (_PI_SelectDt_Dt_di | _PI_SelectDt_Dt_dop); // 2
    assign PA_Select_OPold_low = (_PA_Select_OPold_low_di | _PA_Select_OPold_low_dop); // 2

endmodule
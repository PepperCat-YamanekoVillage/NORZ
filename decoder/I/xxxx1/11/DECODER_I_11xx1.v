// 45(182)
module DECODER_I_11xx1(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire PA_Select_IX_high,
        output wire PA_Select_IY_high,
        output wire PA_Select_OP_low,
        output wire PR_Write_Dt,
        output wire PR_Write_Dtex,
        output wire PI_SelectAd_DtexDt,
        output wire PC_RA0,
        output wire PC_RA1,
        output wire PC_RA2,
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1, // <
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd, // >
        output wire PA_Select_A_high,
        output wire PR_InvertIn,
        output wire PF_Write_S,
        output wire PF_Write_Z,
        output wire PF_Write_H,
        output wire PF_Write_PV,
        output wire PF_Write_N,
        output wire PF_Write_C,
        output wire PR_Write_A,
        output wire PA_ADD,
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
        output wire PF_Select_Z_bit24,
        output wire PF_Select_S_bit7,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PA_Select_Dt_high,
        output wire PA_Select_0x1_low,
        output wire PI_SelectAd_ALU,
        output wire PI_SelectDt_Dt,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire P2_Set_ILDlIXtdln_1,
        output wire P2_Set_ILDlIYtdln_1,
        output wire P2_Set_CMR,
        output wire PA_Select_OPold_low,
        output wire PI_SelectDt_OP
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _110x1xxx;
    wire _111x1xxx;

    DECODER_1bit_decoder d_11dx1xxx(
        .notEnable(_not_enable),
        .In(ITABLE[5]),
        .notIn(notITABLE[5]),
        .out0(_110x1xxx),
        .out1(_111x1xxx)
    );

    wire _PA_Select_IX_high_0;
    wire _PA_Select_IY_high_0;
    wire _PA_Select_OP_low_0;
    wire _PR_Write_Dt_0;
    wire _PR_Write_Dtex_0;
    wire _PI_SelectAd_DtexDt_0;
    wire _PR_Reset_XPT_0;
    wire _P2_Set_CM1_0; // <
    wire _P2_Reset_ITABLE_0;
    wire _Pa_Ophd_0; // >
    wire _PF_Write_S_0;
    wire _PF_Write_Z_0;
    wire _PF_Write_H_0;
    wire _PF_Write_PV_0;
    wire _PF_Write_N_0;
    wire _PA_ADD_0;
    wire _PA_SUB_0;
    wire _PF_Select_H_bit22_0;
    wire _PF_Select_N_bit17_0;
    wire _PF_Select_H_bit21_0;
    wire _PF_Select_N_bit16_0;
    wire _PF_Select_PV_bit25_0;
    wire _PF_Select_Z_bit24_0;
    wire _PF_Select_S_bit7_0;

    DECODER_I_110x1 d110x1(
        .enable(_110x1xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PA_Select_IX_high(_PA_Select_IX_high_0),
        .PA_Select_IY_high(_PA_Select_IY_high_0),
        .PA_Select_OP_low(_PA_Select_OP_low_0),
        .PR_Write_Dt(_PR_Write_Dt_0),
        .PR_Write_Dtex(_PR_Write_Dtex_0),
        .PI_SelectAd_DtexDt(_PI_SelectAd_DtexDt_0),
        .PC_RA0(PC_RA0),
        .PC_RA1(PC_RA1),
        .PC_RA2(PC_RA2),
        .PR_Reset_XPT(_PR_Reset_XPT_0), // <
        .P2_Set_CM1(_P2_Set_CM1_0),
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_0),
        .PA_Select_A_high(PA_Select_A_high),
        .PR_InvertIn(PR_InvertIn),
        .PF_Write_S(_PF_Write_S_0),
        .PF_Write_Z(_PF_Write_Z_0),
        .PF_Write_H(_PF_Write_H_0),
        .PF_Write_PV(_PF_Write_PV_0),
        .PF_Write_N(_PF_Write_N_0),
        .PF_Write_C(PF_Write_C),
        .Pa_Ophd(_Pa_Ophd_0), // >
        .PR_Write_A(PR_Write_A),
        .PA_ADD(_PA_ADD_0),
        .PA_ADC(PA_ADC),
        .PA_SUB(_PA_SUB_0),
        .PA_SBC(PA_SBC),
        .PA_AND(PA_AND),
        .PA_OR(PA_OR),
        .PA_XOR(PA_XOR),
        .PF_Select_H_bit22(_PF_Select_H_bit22_0),
        .PF_Select_N_bit17(_PF_Select_N_bit17_0),
        .PF_Select_C_bit26(PF_Select_C_bit26),
        .PF_Select_H_bit21(_PF_Select_H_bit21_0),
        .PF_Select_C_bit23(PF_Select_C_bit23),
        .PF_Select_H_bit16(PF_Select_H_bit16),
        .PF_Select_PV_bit27(PF_Select_PV_bit27),
        .PF_Select_C_bit16(PF_Select_C_bit16),
        .PF_Select_H_bit17(PF_Select_H_bit17),
        .PF_Select_N_bit16(_PF_Select_N_bit16_0),
        .PF_Select_PV_bit25(_PF_Select_PV_bit25_0),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_0),
        .PF_Select_S_bit7(_PF_Select_S_bit7_0)
    );

    wire _PA_Select_IX_high_1;
    wire _PA_Select_IY_high_1;
    wire _PA_Select_OP_low_1;
    wire _PR_Write_Dt_1;
    wire _PR_Write_Dtex_1;
    wire _PI_SelectAd_DtexDt_1;
    wire _PR_Reset_XPT_1;
    wire _P2_Set_CM1_1; // <
    wire _P2_Reset_ITABLE_1;
    wire _Pa_Ophd_1; // >
    wire _PF_Write_S_1;
    wire _PF_Write_Z_1;
    wire _PF_Write_H_1;
    wire _PF_Write_PV_1;
    wire _PF_Write_N_1;
    wire _PA_ADD_1;
    wire _PA_SUB_1;
    wire _PF_Select_H_bit22_1;
    wire _PF_Select_N_bit17_1;
    wire _PF_Select_H_bit21_1;
    wire _PF_Select_N_bit16_1;
    wire _PF_Select_PV_bit25_1;
    wire _PF_Select_Z_bit24_1;
    wire _PF_Select_S_bit7_1;

    DECODER_I_11111 d11111(
        .enable(_111x1xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PA_Select_IX_high(_PA_Select_IX_high_1),
        .PA_Select_IY_high(_PA_Select_IY_high_1),
        .PA_Select_OP_low(_PA_Select_OP_low_1),
        .PF_Select_N_bit16(_PF_Select_N_bit16_1),
        .PF_Select_H_bit21(_PF_Select_H_bit21_1),
        .PF_Select_N_bit17(_PF_Select_N_bit17_1),
        .PF_Select_H_bit22(_PF_Select_H_bit22_1),
        .PA_SUB(_PA_SUB_1),
        .PA_ADD(_PA_ADD_1),
        .PR_Write_Dtex(_PR_Write_Dtex_1),
        .PR_Write_Dt(_PR_Write_Dt_1),
        .PI_SelectAd_DtexDt(_PI_SelectAd_DtexDt_1),
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PA_Select_Dt_high(PA_Select_Dt_high),
        .PA_Select_0x1_low(PA_Select_0x1_low),
        .PF_Write_S(_PF_Write_S_1),
        .PF_Select_S_bit7(_PF_Select_S_bit7_1),
        .PF_Write_Z(_PF_Write_Z_1),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_1),
        .PF_Write_H(_PF_Write_H_1),
        .PF_Write_PV(_PF_Write_PV_1),
        .PF_Select_PV_bit25(_PF_Select_PV_bit25_1),
        .PF_Write_N(_PF_Write_N_1),
        .PI_SelectAd_ALU(PI_SelectAd_ALU),
        .PI_SelectDt_Dt(PI_SelectDt_Dt),
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .PR_Reset_XPT(_PR_Reset_XPT_1),
        .P2_Set_CM1(_P2_Set_CM1_1), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_1),
        .Pa_Ophd(_Pa_Ophd_1), // >
        .P2_Set_ILDlIXtdln_1(P2_Set_ILDlIXtdln_1),
        .P2_Set_ILDlIYtdln_1(P2_Set_ILDlIYtdln_1),
        .P2_Set_CMR(P2_Set_CMR),
        .PA_Select_OPold_low(PA_Select_OPold_low),
        .PI_SelectDt_OP(PI_SelectDt_OP)
    );

    assign P2_Set_CM1 = (_P2_Set_CM1_0 | _P2_Set_CM1_1); // 2
    assign P2_Reset_ITABLE = P2_Set_CM1;
    assign Pa_Ophd = P2_Set_CM1;

    assign PA_Select_IX_high = (_PA_Select_IX_high_0 | _PA_Select_IX_high_1); // 2
    assign PA_Select_IY_high = (_PA_Select_IY_high_0 | _PA_Select_IY_high_1); // 2
    assign PA_Select_OP_low = (_PA_Select_OP_low_0 | _PA_Select_OP_low_1); // 2
    assign PR_Write_Dt = (_PR_Write_Dt_0 | _PR_Write_Dt_1); // 2
    assign PR_Write_Dtex = (_PR_Write_Dtex_0 | _PR_Write_Dtex_1); // 2
    assign PI_SelectAd_DtexDt = (_PI_SelectAd_DtexDt_0 | _PI_SelectAd_DtexDt_1); // 2
    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2
    assign PF_Write_S = (_PF_Write_S_0 | _PF_Write_S_1); // 2
    assign PF_Write_Z = (_PF_Write_Z_0 | _PF_Write_Z_1); // 2
    assign PF_Write_H = (_PF_Write_H_0 | _PF_Write_H_1); // 2
    assign PF_Write_PV = (_PF_Write_PV_0 | _PF_Write_PV_1); // 2
    assign PF_Write_N = (_PF_Write_N_0 | _PF_Write_N_1); // 2
    assign PA_ADD = (_PA_ADD_0 | _PA_ADD_1); // 2
    assign PA_SUB = (_PA_SUB_0 | _PA_SUB_1); // 2
    assign PF_Select_H_bit22 = (_PF_Select_H_bit22_0 | _PF_Select_H_bit22_1); // 2
    assign PF_Select_N_bit17 = (_PF_Select_N_bit17_0 | _PF_Select_N_bit17_1); // 2
    assign PF_Select_H_bit21 = (_PF_Select_H_bit21_0 | _PF_Select_H_bit21_1); // 2
    assign PF_Select_N_bit16 = (_PF_Select_N_bit16_0 | _PF_Select_N_bit16_1); // 2
    assign PF_Select_PV_bit25 = (_PF_Select_PV_bit25_0 | _PF_Select_PV_bit25_1); // 2
    assign PF_Select_Z_bit24 = (_PF_Select_Z_bit24_0 | _PF_Select_Z_bit24_1); // 2
    assign PF_Select_S_bit7 = (_PF_Select_S_bit7_0 | _PF_Select_S_bit7_1); // 2

endmodule
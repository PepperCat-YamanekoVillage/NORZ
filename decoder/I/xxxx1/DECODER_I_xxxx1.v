// 71(716)
module DECODER_I_xxxx1(
        input wire enable,
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
        output wire PR_Reset_XPT,
        output wire P2_Set_CMR,
        output wire PR_Write_IX_low,
        output wire PR_Write_IY_low,
        output wire P2_Set_ILDlnnlA_1,
        output wire P2_Set_ILDIXnn_1,
        output wire P2_Set_ILDHLlnnl_1,
        output wire P2_Set_ILDIYnn_1,
        output wire P2_Set_ILDIXlnnl_1,
        output wire P2_Set_ILDIYlnnl_1,
        output wire P2_Set_ICALLnn_1,
        output wire PI_SelectAd_OPOPold,
        output wire PI_SelectDt_A,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire P2_Set_CM1, // <
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd, // >
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Write_L,
        output wire PI_SelectAdt1,
        output wire PR_Write_H,
        output wire PR_InvertIn,
        output wire PR_Write_IX_high,
        output wire PR_Write_IY_high,
        output wire PR_Dec_SP,
        output wire PI_SelectDt_PC_high,
        output wire PI_SelectAd_SP,
        output wire PI_SelectDt_PC_low,
        output wire PA_Select_OPOPold_low,
        output wire PA_NOP,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low,
        output wire PC_I0,
        output wire PC_I1,
        output wire PC_I2,
        output wire PC_I3,
        output wire PC_O0,
        output wire PC_O1,
        output wire PC_O2,
        output wire PC_O3,
        output wire PR_Write_A,
        output wire PI_SelectAd_AOP,
        output wire P2_Set_ILDlnnlIX_1,
        output wire P2_Set_ILDlnnlIY_1,
        output wire PI_SelectDt_IX_low,
        output wire PI_SelectDt_IY_low,
        output wire PI_SelectDt_IX_high,
        output wire PI_SelectDt_IY_high,
        output wire PA_Select_PC_high,
        output wire PA_ADD,
        output wire PA_Select_OP_low,
        output wire PA_Select_0xffOP_low,
        output wire PA_Select_B_high,
        output wire PA_Select_0x1_low,
        output wire PA_SUB,
        output wire PR_Write_B,
        output wire P2_Set_IJPccnn_0_1,
        output wire P2_Set_IJPccnn_1_1,
        output wire P2_Set_IJPccnn_2_1,
        output wire P2_Set_IJPccnn_3_1,
        output wire P2_Set_IJPccnn_4_1,
        output wire P2_Set_IJPccnn_5_1,
        output wire P2_Set_IJPccnn_6_1,
        output wire P2_Set_IJPccnn_7_1,
        output wire P2_Set_CMA,
        output wire PA_Select_OPxx_low,
        output wire P2_Set_ICALLccnn_0_1,
        output wire P2_Set_ICALLccnn_1_1,
        output wire P2_Set_ICALLccnn_2_1,
        output wire P2_Set_ICALLccnn_3_1,
        output wire P2_Set_ICALLccnn_4_1,
        output wire P2_Set_ICALLccnn_5_1,
        output wire P2_Set_ICALLccnn_6_1,
        output wire P2_Set_ICALLccnn_7_1,
        output wire PA_Select_IX_high,
        output wire PA_Select_IY_high,
        output wire PR_Write_Dt,
        output wire PR_Write_Dtex,
        output wire PI_SelectAd_DtexDt,
        output wire PC_RA0,
        output wire PC_RA1,
        output wire PC_RA2,
        output wire PA_Select_A_high,
        output wire PF_Write_S,
        output wire PF_Write_Z,
        output wire PF_Write_H,
        output wire PF_Write_PV,
        output wire PF_Write_N,
        output wire PF_Write_C,
        output wire PA_ADC,
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
        output wire PA_Select_Dt_high,
        output wire PI_SelectAd_ALU,
        output wire PI_SelectDt_Dt,
        output wire P2_Set_ILDlIXtdln_1,
        output wire P2_Set_ILDlIYtdln_1,
        output wire PA_Select_OPold_low,
        output wire PI_SelectDt_OP
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _00xx1xxx;
    wire _01xx1xxx;
    wire _10xx1xxx;
    wire _11xx1xxx;

    DECODER_2bit_decoder d_ddxx1xxx( // 8
        .notEnable(_not_enable),
        .In(ITABLE[7:6]),
        .notIn(notITABLE[7:6]),
        .out00(_00xx1xxx),
        .out01(_01xx1xxx),
        .out10(_10xx1xxx),
        .out11(_11xx1xxx)
    );

    wire _PR_Reset_XPT_00;
    wire _P2_Set_CMR_00;
    wire _PC_W0_00;
    wire _PC_W1_00;
    wire _PC_W2_00;
    wire _P2_Set_CM1_00; // <
    wire _P2_Reset_ITABLE_00;
    wire _Pa_Ophd_00; // >
    wire _PC_R0_00;
    wire _PC_R1_00;
    wire _PC_R2_00;
    wire _PR_InvertIn_00;
    wire _PR_Dec_SP_00;
    wire _PI_SelectDt_PC_high_00;
    wire _PI_SelectAd_SP_00;
    wire _PI_SelectDt_PC_low_00;
    wire _PA_Select_OPOPold_low_00;
    wire _PA_NOP_00;
    wire _PR_Write_PC_high_00;
    wire _PR_Write_PC_low_00;
    wire _PR_Write_A_00;
    wire _PA_ADD_00;
    wire _PA_Select_OP_low_00;
    wire _PA_Select_0x1_low_00;
    wire _PA_SUB_00;

    DECODER_I_00xx1 d00xx1(
        .enable(_00xx1xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .Flag_C(Flag_C),
        .Flag_Z(Flag_Z),
        .notIsResultLow0(notIsResultLow0),
        .OP7(OP7),
        .notOP7(notOP7),
        .PR_Reset_XPT(_PR_Reset_XPT_00),
        .P2_Set_CMR(_P2_Set_CMR_00),
        .PR_Write_IX_low(PR_Write_IX_low),
        .PR_Write_IY_low(PR_Write_IY_low),
        .P2_Set_ILDlnnlA_1(P2_Set_ILDlnnlA_1),
        .P2_Set_ILDIXnn_1(P2_Set_ILDIXnn_1),
        .P2_Set_ILDHLlnnl_1(P2_Set_ILDHLlnnl_1),
        .P2_Set_ILDIYnn_1(P2_Set_ILDIYnn_1),
        .P2_Set_ILDIXlnnl_1(P2_Set_ILDIXlnnl_1),
        .P2_Set_ILDIYlnnl_1(P2_Set_ILDIYlnnl_1),
        .P2_Set_ICALLnn_1(P2_Set_ICALLnn_1),
        .PI_SelectAd_OPOPold(PI_SelectAd_OPOPold),
        .PI_SelectDt_A(PI_SelectDt_A),
        .PC_W0(_PC_W0_00),
        .PC_W1(_PC_W1_00),
        .PC_W2(_PC_W2_00),
        .P2_Set_CM1(_P2_Set_CM1_00), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_00),
        .Pa_Ophd(_Pa_Ophd_00), // >
        .PC_R0(_PC_R0_00),
        .PC_R1(_PC_R1_00),
        .PC_R2(_PC_R2_00),
        .PR_Write_L(PR_Write_L),
        .PI_SelectAdt1(PI_SelectAdt1),
        .PR_Write_H(PR_Write_H),
        .PR_InvertIn(_PR_InvertIn_00),
        .PR_Write_IX_high(PR_Write_IX_high),
        .PR_Write_IY_high(PR_Write_IY_high),
        .PR_Dec_SP(_PR_Dec_SP_00),
        .PI_SelectDt_PC_high(_PI_SelectDt_PC_high_00),
        .PI_SelectAd_SP(_PI_SelectAd_SP_00),
        .PI_SelectDt_PC_low(_PI_SelectDt_PC_low_00),
        .PA_Select_OPOPold_low(_PA_Select_OPOPold_low_00),
        .PA_NOP(_PA_NOP_00),
        .PR_Write_PC_high(_PR_Write_PC_high_00),
        .PR_Write_PC_low(_PR_Write_PC_low_00),
        .PC_I0(PC_I0),
        .PC_I1(PC_I1),
        .PC_I2(PC_I2),
        .PC_I3(PC_I3),
        .PC_O0(PC_O0),
        .PC_O1(PC_O1),
        .PC_O2(PC_O2),
        .PC_O3(PC_O3),
        .PR_Write_A(_PR_Write_A_00),
        .PI_SelectAd_AOP(PI_SelectAd_AOP),
        .P2_Set_ILDlnnlIX_1(P2_Set_ILDlnnlIX_1),
        .P2_Set_ILDlnnlIY_1(P2_Set_ILDlnnlIY_1),
        .PI_SelectDt_IX_low(PI_SelectDt_IX_low),
        .PI_SelectDt_IY_low(PI_SelectDt_IY_low),
        .PI_SelectDt_IX_high(PI_SelectDt_IX_high),
        .PI_SelectDt_IY_high(PI_SelectDt_IY_high),
        .PA_Select_PC_high(PA_Select_PC_high),
        .PA_ADD(_PA_ADD_00),
        .PA_Select_OP_low(_PA_Select_OP_low_00),
        .PA_Select_0xffOP_low(PA_Select_0xffOP_low),
        .PA_Select_B_high(PA_Select_B_high),
        .PA_Select_0x1_low(_PA_Select_0x1_low_00),
        .PA_SUB(_PA_SUB_00),
        .PR_Write_B(PR_Write_B)
    );

    wire _PR_Reset_XPT_01;
    wire _PA_NOP_01;
    wire _PR_Write_PC_high_01;
    wire _PR_Write_PC_low_01;
    wire _PR_InvertIn_01;
    wire _P2_Set_CM1_01; // <
    wire _P2_Reset_ITABLE_01;
    wire _Pa_Ophd_01; // >

    DECODER_I_010x1 d010x1(
        .enable(_01xx1xxx),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .Flag_Z(Flag_Z),  // 00 0->is0 1->is1
        .Flag_C(Flag_C),  // 01
        .Flag_PV(Flag_PV), // 10
        .Flag_S(Flag_S),  // 11
        .P2_Set_IJPccnn_0_1(P2_Set_IJPccnn_0_1),
        .P2_Set_IJPccnn_1_1(P2_Set_IJPccnn_1_1),
        .P2_Set_IJPccnn_2_1(P2_Set_IJPccnn_2_1),
        .P2_Set_IJPccnn_3_1(P2_Set_IJPccnn_3_1),
        .P2_Set_IJPccnn_4_1(P2_Set_IJPccnn_4_1),
        .P2_Set_IJPccnn_5_1(P2_Set_IJPccnn_5_1),
        .P2_Set_IJPccnn_6_1(P2_Set_IJPccnn_6_1),
        .P2_Set_IJPccnn_7_1(P2_Set_IJPccnn_7_1),
        .P2_Set_CMA(P2_Set_CMA),
        .PR_Reset_XPT(_PR_Reset_XPT_01),
        .PA_Select_OPxx_low(PA_Select_OPxx_low), // <
        .PA_NOP(_PA_NOP_01),
        .PR_Write_PC_high(_PR_Write_PC_high_01),
        .PR_Write_PC_low(_PR_Write_PC_low_01),
        .PR_InvertIn(_PR_InvertIn_01), // >
        .P2_Set_CM1(_P2_Set_CM1_01), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_01),
        .Pa_Ophd(_Pa_Ophd_01) // >
    );

    wire _P2_Set_CMR_10;
    wire _PR_Dec_SP_10;
    wire _PI_SelectDt_PC_high_10;
    wire _PI_SelectAd_SP_10;
    wire _PC_W0_10;
    wire _PC_W1_10;
    wire _PC_W2_10;
    wire _PI_SelectDt_PC_low_10;
    wire _PR_Reset_XPT_10;
    wire _P2_Set_CM1_10; // <
    wire _P2_Reset_ITABLE_10;
    wire _Pa_Ophd_10; // >
    wire _PA_Select_OPOPold_low_10;
    wire _PA_NOP_10;
    wire _PR_Write_PC_high_10;
    wire _PR_Write_PC_low_10;

    DECODER_I_100x1 d100x1(
        .enable(_10xx1xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .Flag_Z(Flag_Z),
        .Flag_C(Flag_C),
        .Flag_PV(Flag_PV),
        .Flag_S(Flag_S),
        .P2_Set_ICALLccnn_0_1(P2_Set_ICALLccnn_0_1),
        .P2_Set_ICALLccnn_1_1(P2_Set_ICALLccnn_1_1),
        .P2_Set_ICALLccnn_2_1(P2_Set_ICALLccnn_2_1),
        .P2_Set_ICALLccnn_3_1(P2_Set_ICALLccnn_3_1),
        .P2_Set_ICALLccnn_4_1(P2_Set_ICALLccnn_4_1),
        .P2_Set_ICALLccnn_5_1(P2_Set_ICALLccnn_5_1),
        .P2_Set_ICALLccnn_6_1(P2_Set_ICALLccnn_6_1),
        .P2_Set_ICALLccnn_7_1(P2_Set_ICALLccnn_7_1),
        .P2_Set_CMR(_P2_Set_CMR_10),
        .PR_Dec_SP(_PR_Dec_SP_10),
        .PI_SelectDt_PC_high(_PI_SelectDt_PC_high_10),
        .PI_SelectAd_SP(_PI_SelectAd_SP_10),
        .PC_W0(_PC_W0_10),
        .PC_W1(_PC_W1_10),
        .PC_W2(_PC_W2_10),
        .PI_SelectDt_PC_low(_PI_SelectDt_PC_low_10),
        .PR_Reset_XPT(_PR_Reset_XPT_10),
        .P2_Set_CM1(_P2_Set_CM1_10), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_10),
        .Pa_Ophd(_Pa_Ophd_10), // >
        .PA_Select_OPOPold_low(_PA_Select_OPOPold_low_10), // <
        .PA_NOP(_PA_NOP_10),
        .PR_Write_PC_high(_PR_Write_PC_high_10),
        .PR_Write_PC_low(_PR_Write_PC_low_10) // >
    );

    wire _PA_Select_OP_low_11;
    wire _PR_Reset_XPT_11;
    wire _P2_Set_CM1_11; // <
    wire _P2_Reset_ITABLE_11;
    wire _Pa_Ophd_11; // >
    wire _PR_InvertIn_11;
    wire _PR_Write_A_11;
    wire _PA_ADD_11;
    wire _PA_SUB_11;
    wire _PC_R0_11;
    wire _PC_R1_11;
    wire _PC_R2_11;
    wire _PA_Select_0x1_low_11;
    wire _PC_W0_11;
    wire _PC_W1_11;
    wire _PC_W2_11;
    wire _P2_Set_CMR_11;

    DECODER_I_11xx1 d11xx1(
        .enable(_11xx1xxx),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PA_Select_IX_high(PA_Select_IX_high),
        .PA_Select_IY_high(PA_Select_IY_high),
        .PA_Select_OP_low(_PA_Select_OP_low_11),
        .PR_Write_Dt(PR_Write_Dt),
        .PR_Write_Dtex(PR_Write_Dtex),
        .PI_SelectAd_DtexDt(PI_SelectAd_DtexDt),
        .PC_RA0(PC_RA0),
        .PC_RA1(PC_RA1),
        .PC_RA2(PC_RA2),
        .PR_Reset_XPT(_PR_Reset_XPT_11),
        .P2_Set_CM1(_P2_Set_CM1_11), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_11),
        .Pa_Ophd(_Pa_Ophd_11), // >
        .PA_Select_A_high(PA_Select_A_high),
        .PR_InvertIn(_PR_InvertIn_11),
        .PF_Write_S(PF_Write_S),
        .PF_Write_Z(PF_Write_Z),
        .PF_Write_H(PF_Write_H),
        .PF_Write_PV(PF_Write_PV),
        .PF_Write_N(PF_Write_N),
        .PF_Write_C(PF_Write_C),
        .PR_Write_A(_PR_Write_A_11),
        .PA_ADD(_PA_ADD_11),
        .PA_ADC(PA_ADC),
        .PA_SUB(_PA_SUB_11),
        .PA_SBC(PA_SBC),
        .PA_AND(PA_AND),
        .PA_OR(PA_OR),
        .PA_XOR(PA_XOR),
        .PF_Select_H_bit22(PF_Select_H_bit22),
        .PF_Select_N_bit17(PF_Select_N_bit17),
        .PF_Select_C_bit26(PF_Select_C_bit26),
        .PF_Select_H_bit21(PF_Select_H_bit21),
        .PF_Select_C_bit23(PF_Select_C_bit23),
        .PF_Select_H_bit16(PF_Select_H_bit16),
        .PF_Select_PV_bit27(PF_Select_PV_bit27),
        .PF_Select_C_bit16(PF_Select_C_bit16),
        .PF_Select_H_bit17(PF_Select_H_bit17),
        .PF_Select_N_bit16(PF_Select_N_bit16),
        .PF_Select_PV_bit25(PF_Select_PV_bit25),
        .PF_Select_Z_bit24(PF_Select_Z_bit24),
        .PF_Select_S_bit7(PF_Select_S_bit7),
        .PC_R0(_PC_R0_11),
        .PC_R1(_PC_R1_11),
        .PC_R2(_PC_R2_11),
        .PA_Select_Dt_high(PA_Select_Dt_high),
        .PA_Select_0x1_low(_PA_Select_0x1_low_11),
        .PI_SelectAd_ALU(PI_SelectAd_ALU),
        .PI_SelectDt_Dt(PI_SelectDt_Dt),
        .PC_W0(_PC_W0_11),
        .PC_W1(_PC_W1_11),
        .PC_W2(_PC_W2_11),
        .P2_Set_ILDlIXtdln_1(P2_Set_ILDlIXtdln_1),
        .P2_Set_ILDlIYtdln_1(P2_Set_ILDlIYtdln_1),
        .P2_Set_CMR(_P2_Set_CMR_11),
        .PA_Select_OPold_low(PA_Select_OPold_low),
        .PI_SelectDt_OP(PI_SelectDt_OP)
    );

    assign P2_Set_CM1 = (_P2_Set_CM1_00 | _P2_Set_CM1_01 | _P2_Set_CM1_10 | _P2_Set_CM1_11); // 6
    assign P2_Reset_ITABLE = P2_Set_CM1;
    assign Pa_Ophd = P2_Set_CM1;

    assign PR_Reset_XPT = (_PR_Reset_XPT_00 | _PR_Reset_XPT_01 | _PR_Reset_XPT_10 | _PR_Reset_XPT_11); // 6

    assign PR_InvertIn = (_PR_InvertIn_00 | _PR_InvertIn_01 | _PR_InvertIn_11); // 4
    assign PA_NOP = (_PA_NOP_00 | _PA_NOP_01 | _PA_NOP_10); // 4
    assign PR_Write_PC_high = (_PR_Write_PC_high_00 | _PR_Write_PC_high_01 | _PR_Write_PC_high_10); // 4
    assign PR_Write_PC_low = (_PR_Write_PC_low_00 | _PR_Write_PC_low_01 | _PR_Write_PC_low_10); // 4
    assign PC_W0 = (_PC_W0_00 | _PC_W0_10 | _PC_W0_11); // 4
    assign PC_W1 = (_PC_W1_00 | _PC_W1_10 | _PC_W1_11); // 4
    assign PC_W2 = (_PC_W2_00 | _PC_W2_10 | _PC_W2_11); // 4
    assign P2_Set_CMR = (_P2_Set_CMR_00 | _P2_Set_CMR_10 | _P2_Set_CMR_11); // 4

    assign PC_R0 = (_PC_R0_00 | _PC_R0_11); // 2
    assign PC_R1 = (_PC_R1_00 | _PC_R1_11); // 2
    assign PC_R2 = (_PC_R2_00 | _PC_R2_11); // 2
    assign PR_Dec_SP = (_PR_Dec_SP_00 | _PR_Dec_SP_10); // 2
    assign PI_SelectDt_PC_high = (_PI_SelectDt_PC_high_00 | _PI_SelectDt_PC_high_10); // 2
    assign PI_SelectAd_SP = (_PI_SelectAd_SP_00 | _PI_SelectAd_SP_10); // 2
    assign PI_SelectDt_PC_low = (_PI_SelectDt_PC_low_00 | _PI_SelectDt_PC_low_10); // 2
    assign PA_Select_OPOPold_low = (_PA_Select_OPOPold_low_00 | _PA_Select_OPOPold_low_10); // 2
    assign PR_Write_A = (_PR_Write_A_00 | _PR_Write_A_11); // 2
    assign PA_ADD = (_PA_ADD_00 | _PA_ADD_11); // 2
    assign PA_Select_OP_low = (_PA_Select_OP_low_00 | _PA_Select_OP_low_11); // 2
    assign PA_Select_0x1_low = (_PA_Select_0x1_low_00 | _PA_Select_0x1_low_11); // 2
    assign PA_SUB = (_PA_SUB_00 | _PA_SUB_11); // 2


endmodule
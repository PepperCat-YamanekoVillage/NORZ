// 89(368)
module DECODER_op_X1_00(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        input wire Flag_H,
        input wire Flag_Z,
        input wire Flag_C,
        input wire Flag_S,
        input wire Flag_N,
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1, // <
        output wire Pa_Ophd, // >
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
        output wire PA_Select_SP_high, // <
        output wire PR_Write_SP_high,
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
        output wire PF_Write_PV, // <
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
        output wire PA_Select_F_low
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _00xxx00x;
    wire _00xxx01x;
    wire _00xxx10x;
    wire _00xxx11x;

    DECODER_2bit_decoder d_00xxxddx( // 8
        .notEnable(_not_enable),
        .In(Source[2:1]),
        .notIn(notSource[2:1]),
        .out00(_00xxx00x),
        .out01(_00xxx01x),
        .out10(_00xxx10x),
        .out11(_00xxx11x)
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
    wire _PA_Select_HL_high_00;

    DECODER_op_X1_00xxx00 d00xxx00(
        .enable(_00xxx00x),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
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
        .PA_ADD(_PA_ADD_00), // <
        .PR_Write_H(_PR_Write_H_00),
        .PR_Write_L(_PR_Write_L_00),
        .PF_Write_C(_PF_Write_C_00),
        .PF_Write_N(_PF_Write_N_00),
        .PF_Write_H(_PF_Write_H_00),
        .PF_Select_C_bit32(PF_Select_C_bit32),
        .PF_Select_N_bit16(_PF_Select_N_bit16_00),
        .PF_Select_H_bit31(PF_Select_H_bit31),
        .PA_Select_HL_high(_PA_Select_HL_high_00), // >
        .PA_Select_BC_low(PA_Select_BC_low),
        .PA_Select_DE_low(PA_Select_DE_low),
        .PA_Select_HL_low(PA_Select_HL_low),
        .PA_Select_SP_low(PA_Select_SP_low)
    );

    wire _PR_Reset_XPT_01;
    wire _P2_Set_CM1_01; // <
    wire _Pa_Ophd_01; // >
    wire _PC_R0_01;
    wire _PC_R1_01;
    wire _PC_R2_01;
    wire _PC_W0_01;
    wire _PC_W1_01;
    wire _PC_W2_01;
    wire _PR_Write_A_01; // <
    wire _PR_InvertIn_01; // >
    wire _P2_Set_CMR_01;
    wire _PA_Select_0x1_low_01;
    wire _PA_ADD_01;
    wire _PA_SUB_01;
    wire _PR_Write_B_01; // <
    wire _PR_Write_C_01; // >
    wire _PR_Write_D_01; // <
    wire _PR_Write_E_01; // >
    wire _PA_Select_HL_high_01; // <
    wire _PR_Write_H_01;
    wire _PR_Write_L_01; // >

    DECODER_op_X1_00xxx01 d00xxx01(
        .enable(_00xxx01x),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_01),
        .P2_Set_CM1(_P2_Set_CM1_01), // <
        .Pa_Ophd(_Pa_Ophd_01), // >
        .PI_SelectAd_BC(PI_SelectAd_BC),
        .PI_SelectAd_DE(PI_SelectAd_DE),
        .PI_SelectDt_A(PI_SelectDt_A),
        .PC_R0(_PC_R0_01),
        .PC_R1(_PC_R1_01),
        .PC_R2(_PC_R2_01),
        .PC_W0(_PC_W0_01),
        .PC_W1(_PC_W1_01),
        .PC_W2(_PC_W2_01),
        .PR_Write_A(_PR_Write_A_01), // <
        .PR_InvertIn(_PR_InvertIn_01), // >
        .P2_Set_CMR(_P2_Set_CMR_01),
        .P2_Set_ILDlnnlHL_0(P2_Set_ILDlnnlHL_0),
        .P2_Set_ILDHLlnnl_0(P2_Set_ILDHLlnnl_0),
        .P2_Set_ILDlnnlA_0(P2_Set_ILDlnnlA_0),
        .P2_Set_ILDAlnnl_0(P2_Set_ILDAlnnl_0),
        .PA_Select_0x1_low(_PA_Select_0x1_low_01),
        .PA_ADD(_PA_ADD_01),
        .PA_SUB(_PA_SUB_01),
        .PA_Select_BC_high(PA_Select_BC_high), // <
        .PR_Write_B(_PR_Write_B_01),
        .PR_Write_C(_PR_Write_C_01), // >
        .PA_Select_DE_high(PA_Select_DE_high), // <
        .PR_Write_D(_PR_Write_D_01),
        .PR_Write_E(_PR_Write_E_01), // >
        .PA_Select_HL_high(_PA_Select_HL_high_01), // <
        .PR_Write_H(_PR_Write_H_01),
        .PR_Write_L(_PR_Write_L_01), // >
        .PA_Select_SP_high(PA_Select_SP_high), // <
        .PR_Write_SP_high(PR_Write_SP_high),
        .PR_Write_SP_low(PR_Write_SP_low) // >
    );

    wire _PR_Write_B_10;
    wire _PR_Write_C_10;
    wire _PR_Write_D_10;
    wire _PR_Write_E_10;
    wire _PR_Write_H_10;
    wire _PR_Write_L_10;
    wire _PA_Select_A_high_10; // <
    wire _PR_Write_A_10; // >
    wire _PR_InvertIn_10;
    wire _PR_Reset_XPT_10; // <
    wire _P2_Set_CM1_10;
    wire _Pa_Ophd_10; // >
    wire _PA_Select_0x1_low_10; // <
    wire _PF_Write_S_10;
    wire _PF_Write_Z_10;
    wire _PF_Write_H_10;
    wire _PF_Write_PV_10;
    wire _PF_Write_N_10;
    wire _PF_Select_S_bit7_10;
    wire _PF_Select_Z_bit24_10; // >
    wire _PA_ADD_10; // <
    wire _PF_Select_N_bit16_10; // >
    wire _PA_SUB_10;
    wire _PF_Select_N_bit17_10;
    wire _PC_R0_10;
    wire _PC_R1_10;
    wire _PC_R2_10;
    wire _PC_W0_10;
    wire _PC_W1_10;
    wire _PC_W2_10;

    DECODER_op_X1_00xxx10 d00xxx10(
        .enable(_00xxx10x),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PA_Select_B_high(PA_Select_B_high), // <
        .PR_Write_B(_PR_Write_B_10), // >
        .PA_Select_C_high(PA_Select_C_high), // <
        .PR_Write_C(_PR_Write_C_10), // >
        .PA_Select_D_high(PA_Select_D_high), // <
        .PR_Write_D(_PR_Write_D_10), // >
        .PA_Select_E_high(PA_Select_E_high), // <
        .PR_Write_E(_PR_Write_E_10), // >
        .PA_Select_H_high(PA_Select_H_high), // <
        .PR_Write_H(_PR_Write_H_10), // >
        .PA_Select_L_high(PA_Select_L_high), // <
        .PR_Write_L(_PR_Write_L_10), // >
        .PA_Select_A_high(_PA_Select_A_high_10), // <
        .PR_Write_A(_PR_Write_A_10), // >
        .PR_InvertIn(_PR_InvertIn_10),
        .PR_Reset_XPT(_PR_Reset_XPT_10), // <
        .P2_Set_CM1(_P2_Set_CM1_10),
        .Pa_Ophd(_Pa_Ophd_10), // >
        .PA_Select_0x1_low(_PA_Select_0x1_low_10), // <
        .PF_Write_S(_PF_Write_S_10),
        .PF_Write_Z(_PF_Write_Z_10),
        .PF_Write_H(_PF_Write_H_10),
        .PF_Write_PV(_PF_Write_PV_10),
        .PF_Write_N(_PF_Write_N_10),
        .PF_Select_S_bit7(_PF_Select_S_bit7_10),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_10),
        .PF_Select_PV_bit25(PF_Select_PV_bit25), // >
        .PA_ADD(_PA_ADD_10), // <
        .PF_Select_H_bit21(PF_Select_H_bit21),
        .PF_Select_N_bit16(_PF_Select_N_bit16_10), // >
        .PA_SUB(_PA_SUB_10), // <
        .PF_Select_H_bit22(PF_Select_H_bit22),
        .PF_Select_N_bit17(_PF_Select_N_bit17_10), // >
        .PI_SelectAd_HL(PI_SelectAd_HL),
        .PC_R0(_PC_R0_10),
        .PC_R1(_PC_R1_10),
        .PC_R2(_PC_R2_10),
        .PR_Write_Dt(PR_Write_Dt),
        .PA_Select_Dt_high(PA_Select_Dt_high),
        .PI_SelectDt_Dt(PI_SelectDt_Dt),
        .PC_W0(_PC_W0_10),
        .PC_W1(_PC_W1_10),
        .PC_W2(_PC_W2_10)
    );

    wire _PR_Reset_XPT_11;
    wire _P2_Set_CM1_11; // <
    wire _Pa_Ophd_11; // >
    wire _P2_Set_CMR_11;
    wire _PA_Select_A_high_11;
    wire _PF_Write_S_11;
    wire _PF_Write_Z_11;
    wire _PR_Write_A_11; // <
    wire _PR_InvertIn_11; // >
    wire _PF_Write_C_11;
    wire _PF_Write_H_11;
    wire _PF_Write_PV_11; // <
    wire _PF_Select_Z_bit24_11;
    wire _PF_Select_S_bit7_11; // >
    wire _PA_ADD_11;
    wire _PA_SUB_11;
    wire _PF_Write_N_11;
    wire _PF_Select_N_bit16_11;
    wire _PF_Select_N_bit17_11;

    DECODER_op_X1_00xxx11 d00xxx11(
        .enable(_00xxx11x),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .Flag_H(Flag_H),
        .Flag_Z(Flag_Z),
        .Flag_C(Flag_C),
        .Flag_S(Flag_S),
        .Flag_N(Flag_N),
        .PR_Reset_XPT(_PR_Reset_XPT_11),
        .P2_Set_CM1(_P2_Set_CM1_11), // <
        .Pa_Ophd(_Pa_Ophd_11), // >
        .P2_Set_CMR(_P2_Set_CMR_11),
        .P2_Set_ILDrn_B(P2_Set_ILDrn_B),
        .P2_Set_ILDrn_C(P2_Set_ILDrn_C),
        .P2_Set_ILDrn_D(P2_Set_ILDrn_D),
        .P2_Set_ILDrn_E(P2_Set_ILDrn_E),
        .P2_Set_ILDrn_H(P2_Set_ILDrn_H),
        .P2_Set_ILDrn_L(P2_Set_ILDrn_L),
        .P2_Set_ILDrn_A(P2_Set_ILDrn_A),
        .P2_Set_ILDlHLln(P2_Set_ILDlHLln),
        .PA_Select_A_high(_PA_Select_A_high_11), // <
        .PA_Select_0x99_low(PA_Select_0x99_low),
        .PF_Select_S_bit23(PF_Select_S_bit23),
        .PF_Select_Z_bit21(PF_Select_Z_bit21), // >
        .PF_Write_S(_PF_Write_S_11),
        .PF_Write_Z(_PF_Write_Z_11),
        .PR_Write_A(_PR_Write_A_11), // <
        .PR_InvertIn(_PR_InvertIn_11), // >
        .PF_Write_C(_PF_Write_C_11),
        .PF_Write_H(_PF_Write_H_11),
        .PF_Write_PV(_PF_Write_PV_11), // <
        .PF_Select_C_bit29(PF_Select_C_bit29),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_11),
        .PF_Select_PV_bit27(PF_Select_PV_bit27),
        .PF_Select_S_bit7(_PF_Select_S_bit7_11),
        .PF_Select_H_bit28(PF_Select_H_bit28), // >
        .PA_ADD(_PA_ADD_11),
        .PA_SUB(_PA_SUB_11),
        .PA_Select_0x60_low(PA_Select_0x60_low),
        .PA_Select_0x06_low(PA_Select_0x06_low),
        .PA_Select_0x66_low(PA_Select_0x66_low),
        .PF_Write_N(_PF_Write_N_11),
        .PA_Select_A_low(PA_Select_A_low),
        .PF_Select_N_bit16(_PF_Select_N_bit16_11),
        .PA_RLC(PA_RLC),
        .PA_RL(PA_RL),
        .PA_RRC(PA_RRC),
        .PA_RR(PA_RR),
        .PA_NOT(PA_NOT),
        .PF_Select_C_bit38(PF_Select_C_bit38),
        .PF_Select_C_bit37(PF_Select_C_bit37),
        .PF_Select_H_bit16(PF_Select_H_bit16),
        .PF_Select_H_bit30(PF_Select_H_bit30),
        .PF_Select_H_bit17(PF_Select_H_bit17),
        .PF_Select_N_bit17(_PF_Select_N_bit17_11),
        .PF_Select_C_bit0(PF_Select_C_bit0),
        .PF_Select_C_bit17(PF_Select_C_bit17),
        .PA_Select_F_low(PA_Select_F_low)
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_00 | _PR_Reset_XPT_01 | _PR_Reset_XPT_10 | _PR_Reset_XPT_11); // 6
    assign P2_Set_CMR = (_P2_Set_CMR_00 | _P2_Set_CMR_01 | _P2_Set_CMR_11); // 6

    assign P2_Set_CM1 = (_P2_Set_CM1_00 | _P2_Set_CM1_01 | _P2_Set_CM1_10 | _P2_Set_CM1_11); // 6
    assign Pa_Ophd = P2_Set_CM1;

    assign PC_R0 = (_PC_R0_01 | _PC_R0_10); // 2
    assign PC_R1 = (_PC_R1_01 | _PC_R1_10); // 2
    assign PC_R2 = (_PC_R2_01 | _PC_R2_10); // 2
    assign PC_W0 = (_PC_W0_01 | _PC_W0_10); // 2
    assign PC_W1 = (_PC_W1_01 | _PC_W1_10); // 2
    assign PC_W2 = (_PC_W2_01 | _PC_W2_10); // 2

    assign PA_ADD = (_PA_ADD_00 | _PA_ADD_01 | _PA_ADD_10 | _PA_ADD_11); // 6
    assign PA_SUB = (_PA_SUB_01 | _PA_SUB_10 | _PA_SUB_11); // 4
    assign PR_Write_H = (_PR_Write_H_00 | _PR_Write_H_01 | _PR_Write_H_10); // 4
    assign PR_Write_L = (_PR_Write_L_00 | _PR_Write_L_01 | _PR_Write_L_10); // 4
    assign PF_Write_C = (_PF_Write_C_00 | _PF_Write_C_11); // 6
    assign PF_Write_N = (_PF_Write_N_00 | _PF_Write_N_10 | _PF_Write_N_11); // 4
    assign PF_Write_H = (_PF_Write_H_00 | _PF_Write_H_10 | _PF_Write_H_11); // 4
    assign PF_Write_S = (_PF_Write_S_10 | _PF_Write_S_11); // 2
    assign PF_Write_Z = (_PF_Write_Z_10 | _PF_Write_Z_11); // 2
    assign PF_Select_N_bit16 = (_PF_Select_N_bit16_00 | _PF_Select_N_bit16_10 | _PF_Select_N_bit16_11); // 4
    assign PF_Select_N_bit17 = (_PF_Select_N_bit17_10 | _PF_Select_N_bit17_11); // 2
    assign PA_Select_0x1_low = (_PA_Select_0x1_low_01 | _PA_Select_0x1_low_10); // 2
    assign PR_Write_B = (_PR_Write_B_01 | _PR_Write_B_10); // 2
    assign PR_Write_C = (_PR_Write_C_01 | _PR_Write_C_10); // 2
    assign PR_Write_D = (_PR_Write_D_01 | _PR_Write_D_10); // 2
    assign PR_Write_E = (_PR_Write_E_01 | _PR_Write_E_10); // 2
    assign PA_Select_HL_high = (_PA_Select_HL_high_00 | _PA_Select_HL_high_01); // 2
    assign PA_Select_A_high = (_PA_Select_A_high_10 | _PA_Select_A_high_11); // 2

    assign PF_Write_PV = (_PF_Write_PV_10 | _PF_Write_PV_11); // 2
    assign PF_Select_Z_bit24 = PF_Write_PV;
    assign PF_Select_S_bit7 = PF_Write_PV;

    wire _PR_Write_A_13 = (_PR_Write_A_01 | _PR_Write_A_11); // 2
    assign PR_Write_A = (_PR_Write_A_13 | _PR_Write_A_10); // 2
    assign PR_InvertIn = (_PR_Write_A_13 | _PR_InvertIn_10); // 2

endmodule
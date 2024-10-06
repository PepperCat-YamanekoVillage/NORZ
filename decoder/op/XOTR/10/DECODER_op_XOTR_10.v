// 83(249)
module DECODER_op_XOTR_10(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        input wire Flag_PV,
        input wire notFlag_Z,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_XOTR,
        output wire Pa_Ophd, // >
        output wire PA_Select_HL_high, // <
        output wire PR_Write_H,
        output wire PR_Write_L, // >
        output wire PA_Select_BC_high, // <
        output wire PR_Write_C,
        output wire PF_Write_PV,
        output wire PF_Select_PV_bit20, // >
        output wire PA_Select_PC_high,
        output wire PA_Select_0x1_low,
        output wire PA_SUB,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low,
        output wire PA_ADD,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PI_SelectAd_HL,
        output wire PR_Write_Dt,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectAd_DE,
        output wire PI_SelectDt_Dt,
        output wire PA_Select_DE_high,
        output wire PR_Write_D,
        output wire PR_Write_E,
        output wire PR_Write_B,
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Select_N_bit16,
        output wire PF_Select_H_bit16,
        output wire PA_Select_A_high,
        output wire PA_Select_Dt_low,
        output wire PF_Write_Z,
        output wire PF_Write_S,
        output wire PF_Select_Z_bit19,
        output wire PF_Select_S_bit7,
        output wire PF_Select_H_bit22,
        output wire PF_Select_N_bit17,
        output wire PC_I0,
        output wire PC_I1,
        output wire PC_I2,
        output wire PC_I3,
        output wire PI_SelectAd_BC,
        output wire PA_Select_B_high,
        output wire PF_Select_Z_bit24,
        output wire PC_O0,
        output wire PC_O1,
        output wire PC_O2,
        output wire PC_O3
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _101xx000;
    wire _101xx001;
    wire _101xx010;
    wire _101xx011;

    DECODER_2bit_decoder d_101xx0dd( // 8
        .notEnable(_not_enable),
        .In(Source[1:0]),
        .notIn(notSource[1:0]),
        .out00(_101xx000),
        .out01(_101xx001),
        .out10(_101xx010),
        .out11(_101xx011)
    );

    wire _PA_Select_0x1_low_b; // <
    wire _PA_SUB_b; // >

    DECODER_op_XOTR_101_base base(
        .enable(enable),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .Flag_PV(Flag_PV),
        .notFlag_Z(notFlag_Z),
        .PA_Select_PC_high(PA_Select_PC_high), // <
        .PA_Select_0x1_low(_PA_Select_0x1_low_b),
        .PA_SUB(_PA_SUB_b),
        .PR_Write_PC_high(PR_Write_PC_high),
        .PR_Write_PC_low(PR_Write_PC_low), // >
        .PR_Reset_XPT(PR_Reset_XPT), // <
        .P2_Set_CM1(P2_Set_CM1),
        .P2_Reset_XOTR(P2_Reset_XOTR),
        .Pa_Ophd(Pa_Ophd) // >
    );

    wire _PA_ADD_00;
    wire _PA_SUB_00;
    wire _PC_R0_00;
    wire _PC_R1_00;
    wire _PC_R2_00;
    wire _PI_SelectAd_HL_00;
    wire _PR_Write_Dt_00;
    wire _PC_W0_00;
    wire _PC_W1_00;
    wire _PC_W2_00;
    wire _PI_SelectDt_Dt_00;
    wire _PA_Select_0x1_low_00;
    wire _PA_Select_BC_high_00; // <
    wire _PR_Write_B_00;
    wire _PR_Write_C_00;
    wire _PF_Write_PV_00;
    wire _PF_Write_N_00;
    wire _PF_Write_H_00;
    wire _PF_Select_PV_bit20_00; // >
    wire _PA_Select_HL_high_00; // <
    wire _PR_Write_H_00;
    wire _PR_Write_L_00; // >

    DECODER_op_XOTR_101xx000 d101xx000(
        .enable(_101xx000),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PA_ADD(_PA_ADD_00),
        .PA_SUB(_PA_SUB_00),
        .PC_R0(_PC_R0_00),
        .PC_R1(_PC_R1_00),
        .PC_R2(_PC_R2_00),
        .PI_SelectAd_HL(_PI_SelectAd_HL_00),
        .PR_Write_Dt(_PR_Write_Dt_00),
        .PC_W0(_PC_W0_00),
        .PC_W1(_PC_W1_00),
        .PC_W2(_PC_W2_00),
        .PI_SelectAd_DE(PI_SelectAd_DE), // <
        .PI_SelectDt_Dt(_PI_SelectDt_Dt_00), // >
        .PA_Select_DE_high(PA_Select_DE_high), // <
        .PR_Write_D(PR_Write_D),
        .PR_Write_E(PR_Write_E), // >
        .PA_Select_0x1_low(_PA_Select_0x1_low_00),
        .PA_Select_BC_high(_PA_Select_BC_high_00), // <
        .PR_Write_B(_PR_Write_B_00),
        .PR_Write_C(_PR_Write_C_00),
        .PF_Write_PV(_PF_Write_PV_00),
        .PF_Write_N(_PF_Write_N_00),
        .PF_Write_H(_PF_Write_H_00),
        .PF_Select_PV_bit20(_PF_Select_PV_bit20_00),
        .PF_Select_N_bit16(PF_Select_N_bit16),
        .PF_Select_H_bit16(PF_Select_H_bit16), // >
        .PA_Select_HL_high(_PA_Select_HL_high_00), // <
        .PR_Write_H(_PR_Write_H_00),
        .PR_Write_L(_PR_Write_L_00) // >
    );

    wire _PA_ADD_01;
    wire _PA_SUB_01;
    wire _PC_R0_01;
    wire _PC_R1_01;
    wire _PC_R2_01;
    wire _PI_SelectAd_HL_01;
    wire _PR_Write_Dt_01;
    wire _PF_Write_Z_01; // <
    wire _PF_Write_H_01; // >
    wire _PA_Select_BC_high_01; // <
    wire _PR_Write_B_01;
    wire _PR_Write_C_01;
    wire _PF_Write_PV_01;
    wire _PF_Select_PV_bit20_01; // >
    wire _PA_Select_0x1_low_01;
    wire _PA_Select_HL_high_01; // <
    wire _PR_Write_H_01;
    wire _PR_Write_L_01;
    wire _PF_Write_N_01;
    wire _PF_Select_N_bit17_01; // >

    DECODER_op_XOTR_101xx001 d101xx001(
        .enable(_101xx001),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PA_ADD(_PA_ADD_01),
        .PA_SUB(_PA_SUB_01),
        .PC_R0(_PC_R0_01),
        .PC_R1(_PC_R1_01),
        .PC_R2(_PC_R2_01),
        .PI_SelectAd_HL(_PI_SelectAd_HL_01),
        .PR_Write_Dt(_PR_Write_Dt_01),
        .PA_Select_A_high(PA_Select_A_high), // <
        .PA_Select_Dt_low(PA_Select_Dt_low),
        .PF_Write_Z(_PF_Write_Z_01),
        .PF_Write_S(PF_Write_S),
        .PF_Write_H(_PF_Write_H_01),
        .PF_Select_Z_bit19(PF_Select_Z_bit19),
        .PF_Select_S_bit7(PF_Select_S_bit7),
        .PF_Select_H_bit22(PF_Select_H_bit22), // >
        .PA_Select_BC_high(_PA_Select_BC_high_01), //<
        .PR_Write_B(_PR_Write_B_01),
        .PR_Write_C(_PR_Write_C_01),
        .PF_Write_PV(_PF_Write_PV_01),
        .PF_Select_PV_bit20(_PF_Select_PV_bit20_01), // >
        .PA_Select_0x1_low(_PA_Select_0x1_low_01),
        .PA_Select_HL_high(_PA_Select_HL_high_01), // <
        .PR_Write_H(_PR_Write_H_01),
        .PR_Write_L(_PR_Write_L_01),
        .PF_Write_N(_PF_Write_N_01),
        .PF_Select_N_bit17(_PF_Select_N_bit17_01) // >
    );

    wire _PA_ADD_10;
    wire _PA_SUB_10;
    wire _PI_SelectAd_BC_10;
    wire _PR_Write_Dt_10;
    wire _PI_SelectAd_HL_10; // <
    wire _PI_SelectDt_Dt_10; // >
    wire _PA_Select_0x1_low_10;
    wire _PA_Select_B_high_10; // <
    wire _PR_Write_B_10;
    wire _PF_Write_Z_10;
    wire _PF_Write_N_10;
    wire _PF_Select_Z_bit24_10;
    wire _PF_Select_N_bit17_10; // >
    wire _PC_W0_10;
    wire _PC_W1_10;
    wire _PC_W2_10;
    wire _PA_Select_HL_high_10; // <
    wire _PR_Write_H_10;
    wire _PR_Write_L_10; // >

    DECODER_op_XOTR_101xx010 d101xx010(
        .enable(_101xx010),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PA_ADD(_PA_ADD_10),
        .PA_SUB(_PA_SUB_10),
        .PC_I0(PC_I0),
        .PC_I1(PC_I1),
        .PC_I2(PC_I2),
        .PC_I3(PC_I3),
        .PI_SelectAd_BC(_PI_SelectAd_BC_10),
        .PR_Write_Dt(_PR_Write_Dt_10),
        .PI_SelectAd_HL(_PI_SelectAd_HL_10), // <
        .PI_SelectDt_Dt(_PI_SelectDt_Dt_10), // >
        .PA_Select_0x1_low(_PA_Select_0x1_low_10),
        .PA_Select_B_high(_PA_Select_B_high_10), // <
        .PR_Write_B(_PR_Write_B_10),
        .PF_Write_Z(_PF_Write_Z_10),
        .PF_Write_N(_PF_Write_N_10),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_10),
        .PF_Select_N_bit17(_PF_Select_N_bit17_10), // >
        .PC_W0(_PC_W0_10),
        .PC_W1(_PC_W1_10),
        .PC_W2(_PC_W2_10),
        .PA_Select_HL_high(_PA_Select_HL_high_10), // <
        .PR_Write_H(_PR_Write_H_10),
        .PR_Write_L(_PR_Write_L_10) // >
    );

    wire _PA_ADD_11;
    wire _PA_SUB_11;
    wire _PC_R0_11;
    wire _PC_R1_11;
    wire _PC_R2_11;
    wire _PI_SelectAd_HL_11;
    wire _PR_Write_Dt_11;
    wire _PI_SelectAd_BC_11; // <
    wire _PI_SelectDt_Dt_11; // >
    wire _PA_Select_0x1_low_11;
    wire _PA_Select_B_high_11;
    wire _PF_Write_Z_11; // <
    wire _PF_Write_N_11;
    wire _PF_Select_Z_bit24_11;
    wire _PF_Select_N_bit17_11; // >
    wire _PA_Select_HL_high_11; // <
    wire _PR_Write_H_11;
    wire _PR_Write_L_11; // >
    wire _PR_Write_B_11;

    DECODER_op_XOTR_101xx011 d101xx011(
        .enable(_101xx011),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PA_ADD(_PA_ADD_11),
        .PA_SUB(_PA_SUB_11),
        .PC_R0(_PC_R0_11),
        .PC_R1(_PC_R1_11),
        .PC_R2(_PC_R2_11),
        .PI_SelectAd_HL(_PI_SelectAd_HL_11),
        .PR_Write_Dt(_PR_Write_Dt_11),
        .PI_SelectAd_BC(_PI_SelectAd_BC_11), // <
        .PI_SelectDt_Dt(_PI_SelectDt_Dt_11), // >
        .PA_Select_0x1_low(_PA_Select_0x1_low_11),
        .PA_Select_B_high(_PA_Select_B_high_11),
        .PC_O0(PC_O0),
        .PC_O1(PC_O1),
        .PC_O2(PC_O2),
        .PC_O3(PC_O3),
        .PF_Write_Z(_PF_Write_Z_11), // <
        .PF_Write_N(_PF_Write_N_11),
        .PF_Select_Z_bit24(_PF_Select_Z_bit24_11),
        .PF_Select_N_bit17(_PF_Select_N_bit17_11), // >
        .PA_Select_HL_high(_PA_Select_HL_high_11), // <
        .PR_Write_H(_PR_Write_H_11),
        .PR_Write_L(_PR_Write_L_11), // >
        .PR_Write_B(_PR_Write_B_11)
    );

    assign PA_ADD = (_PA_ADD_00 | _PA_ADD_01 | _PA_ADD_10 | _PA_ADD_11); // 6
    assign PA_SUB = (_PA_SUB_b | _PA_SUB_00 | _PA_SUB_01 | _PA_SUB_10 | _PA_SUB_11); // 8
    assign PC_R0 = (_PC_R0_00 | _PC_R0_01 | _PC_R0_11); // 4
    assign PC_R1 = (_PC_R1_00 | _PC_R1_01 | _PC_R1_11); // 4
    assign PC_R2 = (_PC_R2_00 | _PC_R2_01 | _PC_R2_11); // 4
    assign PI_SelectAd_HL = (_PI_SelectAd_HL_00 | _PI_SelectAd_HL_01 | _PI_SelectAd_HL_10 | _PI_SelectAd_HL_11); // 6
    assign PA_Select_0x1_low = (_PA_Select_0x1_low_b | _PA_Select_0x1_low_00 | _PA_Select_0x1_low_01 | _PA_Select_0x1_low_10 | _PA_Select_0x1_low_11); // 8
    assign PC_W0 = (_PC_W0_00 | _PC_W0_10); // 2
    assign PC_W1 = (_PC_W1_00 | _PC_W1_10); // 2
    assign PC_W2 = (_PC_W2_00 | _PC_W2_10); // 2
    assign PR_Write_Dt = (_PR_Write_Dt_00 | _PR_Write_Dt_01 | _PR_Write_Dt_10 | _PR_Write_Dt_11); // 6
    assign PI_SelectDt_Dt = (_PI_SelectDt_Dt_00 | _PI_SelectDt_Dt_10 | _PI_SelectDt_Dt_11); // 4
    assign PI_SelectAd_BC = (_PI_SelectAd_BC_10 | _PI_SelectAd_BC_11); // 2
    assign PA_Select_B_high = (_PA_Select_B_high_10 | _PA_Select_B_high_11); // 2
    assign PF_Write_H = (_PF_Write_H_00 | _PF_Write_H_01); // 2

    assign PA_Select_HL_high = (_PA_Select_HL_high_00 | _PA_Select_HL_high_01 | _PA_Select_HL_high_10 | _PA_Select_HL_high_11); // 6
    assign PR_Write_H = PA_Select_HL_high;
    assign PR_Write_L = PA_Select_HL_high;

    assign PA_Select_BC_high = (_PA_Select_BC_high_00 | _PA_Select_BC_high_01); // 2
    assign PR_Write_C = PA_Select_BC_high;
    assign PF_Write_PV = PA_Select_BC_high;
    assign PF_Select_PV_bit20 = PA_Select_BC_high;

    assign PR_Write_B = (PA_Select_BC_high | _PR_Write_B_10 | _PR_Write_B_11); // 4

    assign PF_Select_Z_bit24 = (_PF_Select_Z_bit24_10 | _PF_Select_Z_bit24_11); // 2
    assign PF_Write_Z = (PF_Select_Z_bit24 | _PF_Write_Z_01); // 2
    assign PF_Select_N_bit17 = (PF_Select_Z_bit24 | _PF_Select_N_bit17_01); // 2
    assign PF_Write_N = (PF_Select_N_bit17 | _PF_Write_N_00); // 2

endmodule
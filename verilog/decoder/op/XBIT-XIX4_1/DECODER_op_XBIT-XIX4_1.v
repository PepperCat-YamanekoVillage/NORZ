// 24(229)
module DECODER_op_XBIT_XIX4_1(
        input wire not_enable_XBIT,
        input wire not_enable_XIX4_1,
        input wire is_Y,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PR_Inc_PC,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd, // >
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
        output wire PA_Select_0x80_low
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    wire _enable_bit_XBIT;
    wire _PR_Reset_XPT_XBIT; // <
    wire _P2_Set_CM1_XBIT;
    wire _Pa_Ophd_XBIT; // >
    wire _PR_Write_Dt_XBIT;
    wire _PC_R0_XBIT;
    wire _PC_R1_XBIT;
    wire _PC_R2_XBIT;
    wire _PA_Select_Dt_low_XBIT;
    wire _PA_Select_Dt_high_XBIT;
    wire _PI_SelectDt_Dt_XBIT;
    wire _PC_W0_XBIT;
    wire _PC_W1_XBIT;
    wire _PC_W2_XBIT;

    DECODER_op_XBIT xbit(
        .not_enable(not_enable_XBIT),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .enable_bit(_enable_bit_XBIT),
        .PR_Inc_PC(PR_Inc_PC),
        .PR_Reset_XPT(_PR_Reset_XPT_XBIT), // <
        .P2_Set_CM1(_P2_Set_CM1_XBIT),
        .P2_Reset_XBIT(P2_Reset_XBIT),
        .Pa_Ophd(_Pa_Ophd_XBIT), // >
        .PR_Write_B(PR_Write_B),
        .PR_Write_C(PR_Write_C),
        .PR_Write_D(PR_Write_D),
        .PR_Write_E(PR_Write_E),
        .PR_Write_H(PR_Write_H),
        .PR_Write_L(PR_Write_L),
        .PR_Write_A(PR_Write_A),
        .PA_Select_B_low(PA_Select_B_low),
        .PA_Select_C_low(PA_Select_C_low),
        .PA_Select_D_low(PA_Select_D_low),
        .PA_Select_E_low(PA_Select_E_low),
        .PA_Select_H_low(PA_Select_H_low),
        .PA_Select_L_low(PA_Select_L_low),
        .PA_Select_A_low(PA_Select_A_low),
        .PA_Select_B_high(PA_Select_B_high),
        .PA_Select_C_high(PA_Select_C_high),
        .PA_Select_D_high(PA_Select_D_high),
        .PA_Select_E_high(PA_Select_E_high),
        .PA_Select_H_high(PA_Select_H_high),
        .PA_Select_L_high(PA_Select_L_high),
        .PA_Select_A_high(PA_Select_A_high),
        .PR_InvertIn(PR_InvertIn),
        .PI_SelectAd_HL(PI_SelectAd_HL),
        .PR_Write_Dt(_PR_Write_Dt_XBIT),
        .PC_R0(_PC_R0_XBIT),
        .PC_R1(_PC_R1_XBIT),
        .PC_R2(_PC_R2_XBIT),
        .PA_Select_Dt_low(_PA_Select_Dt_low_XBIT),
        .PA_Select_Dt_high(_PA_Select_Dt_high_XBIT),
        .PI_SelectDt_Dt(_PI_SelectDt_Dt_XBIT),
        .PC_W0(_PC_W0_XBIT),
        .PC_W1(_PC_W1_XBIT),
        .PC_W2(_PC_W2_XBIT)
    );

    wire _enable_bit_XIX4;
    wire _PC_R0_XIX4;
    wire _PC_R1_XIX4;
    wire _PC_R2_XIX4;
    wire _PA_Select_Dt_low_XIX4;
    wire _PA_Select_Dt_high_XIX4;
    wire _PR_Write_Dt_XIX4;
    wire _PR_Reset_XPT_XIX4; // <
    wire _P2_Set_CM1_XIX4;
    wire _Pa_Ophd_XIX4; // >
    wire _PC_W0_XIX4;
    wire _PC_W1_XIX4;
    wire _PC_W2_XIX4;
    wire _PI_SelectDt_Dt_XIX4;

    DECODER_op_XIX4_1 xix4_1(
        .not_enable(not_enable_XIX4_1),
        .is_Y(is_Y),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .enable_bit(_enable_bit_XIX4),
        .PR_Write_Dtex(PR_Write_Dtex),
        .PC_R0(_PC_R0_XIX4),
        .PC_R1(_PC_R1_XIX4),
        .PC_R2(_PC_R2_XIX4),
        .PI_SelectAd_DtexDt(PI_SelectAd_DtexDt),
        .PA_Select_Dt_low(_PA_Select_Dt_low_XIX4),
        .PA_Select_Dt_high(_PA_Select_Dt_high_XIX4),
        .PR_Write_Dt(_PR_Write_Dt_XIX4),
        .PR_Reset_XPT(_PR_Reset_XPT_XIX4), // <
        .P2_Set_CM1(_P2_Set_CM1_XIX4),
        .Pa_Ophd(_Pa_Ophd_XIX4), // >
        .P2_Reset_XIX4(P2_Reset_XIX4),
        .P2_Reset_XIY4(P2_Reset_XIY4),
        .PC_W0(_PC_W0_XIX4),
        .PC_W1(_PC_W1_XIX4),
        .PC_W2(_PC_W2_XIX4),
        .PI_SelectAd_ALU(PI_SelectAd_ALU),
        .PI_SelectDt_Dt(_PI_SelectDt_Dt_XIX4),
        .PA_Select_OPold_low(PA_Select_OPold_low),
        .PA_ADD(PA_ADD),
        .PA_Select_IX_high(PA_Select_IX_high),
        .PA_Select_IY_high(PA_Select_IY_high)
    );

    wire _enable_bit = (_enable_bit_XBIT | _enable_bit_XIX4); // 2

    DECODER_op_bit bit_(
        .enable(_enable_bit),
        .Source(Source),
        .notSource(notSource),
        .PF_Write_Z(PF_Write_Z), // <
        .PF_Write_N(PF_Write_N),
        .PF_Write_H(PF_Write_H),
        .PF_Select_N_bit16(PF_Select_N_bit16), // >
        .PF_Write_C(PF_Write_C), // <
        .PF_Write_PV(PF_Write_PV),
        .PF_Write_S(PF_Write_S),
        .PF_Select_Z_bit24(PF_Select_Z_bit24),
        .PF_Select_S_bit7(PF_Select_S_bit7),
        .PF_Select_PV_bit27(PF_Select_PV_bit27),
        .PF_Select_H_bit16(PF_Select_H_bit16), // >
        .PF_Select_C_bit38(PF_Select_C_bit38),
        .PF_Select_C_bit37(PF_Select_C_bit37),
        .PF_Select_H_bit17(PF_Select_H_bit17),
        .PA_RLC(PA_RLC),
        .PA_RL(PA_RL),
        .PA_SLA(PA_SLA),
        .PA_RRC(PA_RRC),
        .PA_RR(PA_RR),
        .PA_SRA(PA_SRA),
        .PA_SRL(PA_SRL),
        .PA_NOP(PA_NOP),
        .PA_OR(PA_OR),
        .PA_NLAND(PA_NLAND),
        .PF_Select_Z_bit40(PF_Select_Z_bit40),
        .PF_Select_Z_bit41(PF_Select_Z_bit41),
        .PF_Select_Z_bit42(PF_Select_Z_bit42),
        .PF_Select_Z_bit43(PF_Select_Z_bit43),
        .PF_Select_Z_bit44(PF_Select_Z_bit44),
        .PF_Select_Z_bit45(PF_Select_Z_bit45),
        .PF_Select_Z_bit46(PF_Select_Z_bit46),
        .PF_Select_Z_bit47(PF_Select_Z_bit47),
        .PA_Select_0x1_low(PA_Select_0x1_low),
        .PA_Select_0x2_low(PA_Select_0x2_low),
        .PA_Select_0x4_low(PA_Select_0x4_low),
        .PA_Select_0x8_low(PA_Select_0x8_low),
        .PA_Select_0x10_low(PA_Select_0x10_low),
        .PA_Select_0x20_low(PA_Select_0x20_low),
        .PA_Select_0x40_low(PA_Select_0x40_low),
        .PA_Select_0x80_low(PA_Select_0x80_low)
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_XBIT | _PR_Reset_XPT_XIX4); // 2
    assign P2_Set_CM1 = PR_Reset_XPT;
    assign Pa_Ophd = PR_Reset_XPT;

    assign PR_Write_Dt = (_PR_Write_Dt_XBIT | _PR_Write_Dt_XIX4); // 2
    assign PC_R0 = (_PC_R0_XBIT | _PC_R0_XIX4); // 2
    assign PC_R1 = (_PC_R1_XBIT | _PC_R1_XIX4); // 2
    assign PC_R2 = (_PC_R2_XBIT | _PC_R2_XIX4); // 2
    assign PC_W0 = (_PC_W0_XBIT | _PC_W0_XIX4); // 2
    assign PC_W1 = (_PC_W1_XBIT | _PC_W1_XIX4); // 2
    assign PC_W2 = (_PC_W2_XBIT | _PC_W2_XIX4); // 2
    assign PA_Select_Dt_low = (_PA_Select_Dt_low_XBIT | _PA_Select_Dt_low_XIX4); // 2
    assign PA_Select_Dt_high = (_PA_Select_Dt_high_XBIT | _PA_Select_Dt_high_XIX4); // 2
    assign PI_SelectDt_Dt = (_PI_SelectDt_Dt_XBIT | _PI_SelectDt_Dt_XIX4); // 2

endmodule
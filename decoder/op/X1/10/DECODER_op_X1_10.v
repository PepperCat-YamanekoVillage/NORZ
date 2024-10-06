// 9(71)
module DECODER_op_X1_10(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PI_SelectAd_HL,
        output wire PC_RA0,
        output wire PC_RA1,
        output wire PC_RA2,
        output wire PA_Select_B_low,
        output wire PA_Select_C_low,
        output wire PA_Select_D_low,
        output wire PA_Select_E_low,
        output wire PA_Select_H_low,
        output wire PA_Select_L_low,
        output wire PA_Select_A_low,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd,
        output wire PA_Select_A_high,
        output wire PR_InvertIn,
        output wire PF_Write_S,
        output wire PF_Write_Z,
        output wire PF_Write_H,
        output wire PF_Write_PV,
        output wire PF_Write_N,
        output wire PF_Write_C,
        output wire PF_Select_S_bit7,
        output wire PF_Select_Z_bit24, // >
        output wire PR_Write_A,
        output wire PA_ADD,
        output wire PA_ADC,
        output wire PA_SUB,
        output wire PA_SBC,
        output wire PA_AND,
        output wire PA_XOR,
        output wire PA_OR,
        output wire PF_Select_H_bit21, // <
        output wire PF_Select_C_bit23, // >
        output wire PF_Select_H_bit22, // <
        output wire PF_Select_N_bit17,
        output wire PF_Select_C_bit26, // >
        output wire PF_Select_PV_bit25,
        output wire PF_Select_H_bit17,
        output wire PF_Select_H_bit16,
        output wire PF_Select_PV_bit27, // <
        output wire PF_Select_C_bit16, // >
        output wire PF_Select_N_bit16
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _10xxx110 = ~(_not_enable | notSource[2] | notSource[1] | Source[0]); // 5

    wire _10other = _not_enable ~| _10xxx110;

    wire _enable_alu_110;

    DECODER_op_X1_10xxx110 d10xxx110(
        .enable(_10xxx110),
        .XPT(XPT),
        .notXPT(notXPT),
        .enable_alu(_enable_alu_110),
        .PI_SelectAd_HL(PI_SelectAd_HL),
        .PC_RA0(PC_RA0),
        .PC_RA1(PC_RA1),
        .PC_RA2(PC_RA2)
    );

    wire _enable_alu_otr;

    DECODER_op_X1_10other d10other(
        .enable(_10other),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .enable_alu(_enable_alu_otr),
        .PA_Select_B_low(PA_Select_B_low),
        .PA_Select_C_low(PA_Select_C_low),
        .PA_Select_D_low(PA_Select_D_low),
        .PA_Select_E_low(PA_Select_E_low),
        .PA_Select_H_low(PA_Select_H_low),
        .PA_Select_L_low(PA_Select_L_low),
        .PA_Select_A_low(PA_Select_A_low)
    );

    wire _enable_alu = (_enable_alu_110 | _enable_alu_otr); // 2

    DECODER_op_X1_10_alu alu(
        .enable(_enable_alu),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(PR_Reset_XPT), // <
        .P2_Set_CM1(P2_Set_CM1),
        .Pa_Ophd(Pa_Ophd),
        .PA_Select_A_high(PA_Select_A_high),
        .PR_InvertIn(PR_InvertIn),
        .PF_Write_S(PF_Write_S),
        .PF_Write_Z(PF_Write_Z),
        .PF_Write_H(PF_Write_H),
        .PF_Write_PV(PF_Write_PV),
        .PF_Write_N(PF_Write_N),
        .PF_Write_C(PF_Write_C),
        .PF_Select_S_bit7(PF_Select_S_bit7),
        .PF_Select_Z_bit24(PF_Select_Z_bit24), // >
        .PR_Write_A(PR_Write_A),
        .PA_ADD(PA_ADD),
        .PA_ADC(PA_ADC),
        .PA_SUB(PA_SUB),
        .PA_SBC(PA_SBC),
        .PA_AND(PA_AND),
        .PA_XOR(PA_XOR),
        .PA_OR(PA_OR),
        .PF_Select_H_bit21(PF_Select_H_bit21), // <
        .PF_Select_C_bit23(PF_Select_C_bit23), // >
        .PF_Select_H_bit22(PF_Select_H_bit22), // <
        .PF_Select_N_bit17(PF_Select_N_bit17),
        .PF_Select_C_bit26(PF_Select_C_bit26), // >
        .PF_Select_PV_bit25(PF_Select_PV_bit25),
        .PF_Select_H_bit17(PF_Select_H_bit17),
        .PF_Select_H_bit16(PF_Select_H_bit16),
        .PF_Select_PV_bit27(PF_Select_PV_bit27), // <
        .PF_Select_C_bit16(PF_Select_C_bit16), // >
        .PF_Select_N_bit16(PF_Select_N_bit16)
    );

endmodule
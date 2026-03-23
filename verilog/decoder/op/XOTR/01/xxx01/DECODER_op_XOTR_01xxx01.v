// 3(50)
module DECODER_op_XOTR_01xxx01(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PA_Select_HL_high, // <
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PF_Write_C,
        output wire PF_Write_Z,
        output wire PF_Write_PV,
        output wire PF_Write_S,
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Select_Z_bit34,
        output wire PF_Select_PV_bit33,
        output wire PF_Select_S_bit15, // >
        output wire PA_SBC,
        output wire PF_Select_C_bit36,
        output wire PF_Select_N_bit17,
        output wire PF_Select_H_bit35,
        output wire PA_ADC,
        output wire PF_Select_C_bit32,
        output wire PF_Select_N_bit16,
        output wire PF_Select_H_bit31,
        output wire PA_Select_BC_low,
        output wire PA_Select_DE_low,
        output wire PA_Select_HL_low,
        output wire PA_Select_SP_low,
        output wire PR_Reset_XPT, // <
        output wire P2_Reset_XOTR, // >
        output wire P2_Set_CM1, // <
        output wire Pa_Ophd, // >
        output wire P2_Set_ILDlnnldd_BC_0,
        output wire P2_Set_ILDlnnldd_DE_0,
        output wire P2_Set_ILDlnnldd_HL_0,
        output wire P2_Set_ILDlnnldd_SP_0,
        output wire P2_Set_ILDddlnnl_BC_0,
        output wire P2_Set_ILDddlnnl_DE_0,
        output wire P2_Set_ILDddlnnl_HL_0,
        output wire P2_Set_ILDddlnnl_SP_0,
        output wire P2_Set_CMR
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _01xxx010;
    wire _01xxx011;

    DECODER_1bit_decoder d_01xxx01d(
        .notEnable(_not_enable),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_01xxx010),
        .out1(_01xxx011)
    );

    wire _PR_Reset_XPT_0; // <
    wire _P2_Reset_XOTR_0; // >

    DECODER_op_XOTR_01xxx010 d01xxx010(
        .enable(_01xxx010),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PA_Select_HL_high(PA_Select_HL_high), // <
        .PR_Write_H(PR_Write_H),
        .PR_Write_L(PR_Write_L),
        .PF_Write_C(PF_Write_C),
        .PF_Write_Z(PF_Write_Z),
        .PF_Write_PV(PF_Write_PV),
        .PF_Write_S(PF_Write_S),
        .PF_Write_N(PF_Write_N),
        .PF_Write_H(PF_Write_H),
        .PF_Select_Z_bit34(PF_Select_Z_bit34),
        .PF_Select_PV_bit33(PF_Select_PV_bit33),
        .PF_Select_S_bit15(PF_Select_S_bit15), // >
        .PA_SBC(PA_SBC), // <
        .PF_Select_C_bit36(PF_Select_C_bit36),
        .PF_Select_N_bit17(PF_Select_N_bit17),
        .PF_Select_H_bit35(PF_Select_H_bit35), // >
        .PA_ADC(PA_ADC), // <
        .PF_Select_C_bit32(PF_Select_C_bit32),
        .PF_Select_N_bit16(PF_Select_N_bit16),
        .PF_Select_H_bit31(PF_Select_H_bit31), // >
        .PA_Select_BC_low(PA_Select_BC_low),
        .PA_Select_DE_low(PA_Select_DE_low),
        .PA_Select_HL_low(PA_Select_HL_low),
        .PA_Select_SP_low(PA_Select_SP_low),
        .PR_Reset_XPT(_PR_Reset_XPT_0), // <
        .P2_Set_CM1(P2_Set_CM1),
        .P2_Reset_XOTR(_P2_Reset_XOTR_0),
        .Pa_Ophd(Pa_Ophd) // >
    );

    wire _PR_Reset_XPT_1; // <
    wire _P2_Reset_XOTR_1; // >

    DECODER_op_XOTR_01xxx011 d01xxx011(
        .enable(_01xxx011),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_1), // <
        .P2_Set_CMR(P2_Set_CMR),
        .P2_Reset_XOTR(_P2_Reset_XOTR_1), // >
        .P2_Set_ILDlnnldd_BC_0(P2_Set_ILDlnnldd_BC_0),
        .P2_Set_ILDlnnldd_DE_0(P2_Set_ILDlnnldd_DE_0),
        .P2_Set_ILDlnnldd_HL_0(P2_Set_ILDlnnldd_HL_0),
        .P2_Set_ILDlnnldd_SP_0(P2_Set_ILDlnnldd_SP_0),
        .P2_Set_ILDddlnnl_BC_0(P2_Set_ILDddlnnl_BC_0),
        .P2_Set_ILDddlnnl_DE_0(P2_Set_ILDddlnnl_DE_0),
        .P2_Set_ILDddlnnl_HL_0(P2_Set_ILDddlnnl_HL_0),
        .P2_Set_ILDddlnnl_SP_0(P2_Set_ILDddlnnl_SP_0)
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2
    assign P2_Reset_XOTR = PR_Reset_XPT;

endmodule
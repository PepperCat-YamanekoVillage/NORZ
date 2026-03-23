// 3(29)
module DECODER_op_X1_00xxx001(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PR_Reset_XPT,
        output wire P2_Set_CMR,
        output wire P2_Set_ILDddnn_BC_0,
        output wire P2_Set_ILDddnn_DE_0,
        output wire P2_Set_ILDddnn_HL_0,
        output wire P2_Set_ILDddnn_SP_0,
        output wire P2_Set_CM1, // <
        output wire Pa_Ophd,
        output wire PA_ADD,
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PF_Write_C,
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Select_C_bit32,
        output wire PF_Select_N_bit16,
        output wire PF_Select_H_bit31,
        output wire PA_Select_HL_high, // >
        output wire PA_Select_BC_low,
        output wire PA_Select_DE_low,
        output wire PA_Select_HL_low,
        output wire PA_Select_SP_low
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _00xx0001;
    wire _00xx1001;

    DECODER_1bit_decoder d_00xxd001(
        .notEnable(_not_enable),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_00xx0001),
        .out1(_00xx1001)
    );

    wire _PR_Reset_XPT_0;

    DECODER_op_X1_00xx0001 d00xx0001(
        .enable(_00xx0001),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_0), // <
        .P2_Set_CMR(P2_Set_CMR), // >
        .P2_Set_ILDddnn_BC_0(P2_Set_ILDddnn_BC_0),
        .P2_Set_ILDddnn_DE_0(P2_Set_ILDddnn_DE_0),
        .P2_Set_ILDddnn_HL_0(P2_Set_ILDddnn_HL_0),
        .P2_Set_ILDddnn_SP_0(P2_Set_ILDddnn_SP_0)
    );

    wire _PR_Reset_XPT_1;

    DECODER_op_X1_00xx1001 d00xx1001(
        .enable(_00xx1001),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_1), // <
        .P2_Set_CM1(P2_Set_CM1),
        .Pa_Ophd(Pa_Ophd),
        .PA_ADD(PA_ADD),
        .PR_Write_H(PR_Write_H),
        .PR_Write_L(PR_Write_L),
        .PF_Write_C(PF_Write_C),
        .PF_Write_N(PF_Write_N),
        .PF_Write_H(PF_Write_H),
        .PF_Select_C_bit32(PF_Select_C_bit32),
        .PF_Select_N_bit16(PF_Select_N_bit16),
        .PF_Select_H_bit31(PF_Select_H_bit31),
        .PA_Select_HL_high(PA_Select_HL_high), // >
        .PA_Select_BC_low(PA_Select_BC_low),
        .PA_Select_DE_low(PA_Select_DE_low),
        .PA_Select_HL_low(PA_Select_HL_low),
        .PA_Select_SP_low(PA_Select_SP_low)
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2

endmodule
// 7(62)
module DECODER_op_X1_00xxx00(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
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
        output wire PA_ADD, // <
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

    wire _00xxx000;
    wire _00xxx001;

    DECODER_1bit_decoder d_00xxx00d(
        .notEnable(_not_enable),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_00xxx000),
        .out1(_00xxx001)
    );

    wire _PR_Reset_XPT_0;
    wire _P2_Set_CM1_0; // <
    wire _Pa_Ophd_0; // >
    wire _P2_Set_CMR_0;

    DECODER_op_X1_00xxx000 d00xxx00(
        .enable(_00xxx000),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_0),
        .P2_Set_CM1(_P2_Set_CM1_0), // <
        .Pa_Ophd(_Pa_Ophd_0), // >
        .PR_Ex_AF_AF(PR_Ex_AF_AF),
        .P2_Set_CMR(_P2_Set_CMR_0),
        .P2_Set_IDJNZe(P2_Set_IDJNZe),
        .P2_Set_IJRNZe(P2_Set_IJRNZe),
        .P2_Set_IJRNCe(P2_Set_IJRNCe),
        .P2_Set_IJRe(P2_Set_IJRe),
        .P2_Set_IJRZe(P2_Set_IJRZe),
        .P2_Set_IJRCe(P2_Set_IJRCe)
    );

    wire _PR_Reset_XPT_1;
    wire _P2_Set_CM1_1; // <
    wire _Pa_Ophd_1; // >
    wire _P2_Set_CMR_1;

    DECODER_op_X1_00xxx001 d00xxx001(
        .enable(_00xxx001),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_1),
        .P2_Set_CMR(_P2_Set_CMR_1),
        .P2_Set_ILDddnn_BC_0(P2_Set_ILDddnn_BC_0),
        .P2_Set_ILDddnn_DE_0(P2_Set_ILDddnn_DE_0),
        .P2_Set_ILDddnn_HL_0(P2_Set_ILDddnn_HL_0),
        .P2_Set_ILDddnn_SP_0(P2_Set_ILDddnn_SP_0),
        .P2_Set_CM1(_P2_Set_CM1_1), // <
        .Pa_Ophd(_Pa_Ophd_1),
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
    assign P2_Set_CMR = (_P2_Set_CMR_0 | _P2_Set_CMR_1); // 2

    assign P2_Set_CM1 = (_P2_Set_CM1_0 | _P2_Set_CM1_1); // 2
    assign Pa_Ophd = P2_Set_CM1;

endmodule
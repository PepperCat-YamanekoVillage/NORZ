// 19(91)
module DECODER_op_X1_00xxx11(
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
        output wire [3:0] _decodedXPT,
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1, // <
        output wire Pa_Ophd, // >
        output wire P2_Set_CMR,
        output wire P2_Set_ILDrn_B,
        output wire P2_Set_ILDrn_C,
        output wire P2_Set_ILDrn_D,
        output wire P2_Set_ILDrn_E,
        output wire P2_Set_ILDrn_H,
        output wire P2_Set_ILDrn_L,
        output wire P2_Set_ILDrn_A,
        output wire P2_Set_ILDlHLln,
        output wire PA_Select_A_high, // <
        output wire PA_Select_0x99_low,
        output wire PF_Select_S_bit23,
        output wire PF_Select_Z_bit21, // >
        output wire PF_Write_S,
        output wire PF_Write_Z,
        output wire PR_Write_A, // <
        output wire PR_InvertIn, // >
        output wire PF_Write_C,
        output wire PF_Write_H,
        output wire PF_Write_PV, // <
        output wire PF_Select_C_bit29,
        output wire PF_Select_Z_bit24,
        output wire PF_Select_PV_bit27,
        output wire PF_Select_S_bit7,
        output wire PF_Select_H_bit28, // >
        output wire PA_ADD,
        output wire PA_SUB,
        output wire PA_Select_0x60_low,
        output wire PA_Select_0x06_low,
        output wire PA_Select_0x66_low,
        output wire PF_Write_N,
        output wire PA_Select_A_low,
        output wire PF_Select_N_bit16,
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
        output wire PF_Select_N_bit17,
        output wire PF_Select_C_bit0,
        output wire PF_Select_C_bit17,
        output wire PA_Select_F_low
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    DECODER_1bit_decoder t_1d(
        .notEnable(_not_enable),
        .In(XPT[0]),
        .notIn(notXPT[0]),
        .out0(_decodedXPT[2]),
        .out1(_decodedXPT[3])
    );

    //
    // decoder
    //

    wire _nott2 = _decodedXPT[2] ~| _decodedXPT[2];

    wire _not00100111 = (notSource[5] | Source[4] | Source[3] | notSource[0]); // 5
    wire _00100111_t2 = _nott2 ~| _not00100111;

    wire _nott3 = _decodedXPT[3] ~| _decodedXPT[3];

    wire _00xxx110_t3;
    wire _00xxx111_t3;

    DECODER_1bit_decoder d_00xxx11d_t3(
        .notEnable(_nott3),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_00xxx110_t3),
        .out1(_00xxx111_t3)
    );

    wire _00100111_t3 = _nott3 ~| _not00100111;

    wire _not00xxx111_t3 = _00xxx111_t3 ~| _00xxx111_t3;

    wire _00eee111_t3 = _not00xxx111_t3 ~| _00100111_t3;

    // 3

    assign PR_Reset_XPT = _decodedXPT[3];

    assign P2_Set_CM1 = _00xxx111_t3;
    assign Pa_Ophd = _00xxx111_t3;

    DECODER_op_X1_00xxx110 d00xxx110(
        .enable(_00xxx110_t3),
        .Source(Source),
        .notSource(notSource),
        .P2_Set_CMR(P2_Set_CMR),
        .P2_Set_ILDrn_B(P2_Set_ILDrn_B),
        .P2_Set_ILDrn_C(P2_Set_ILDrn_C),
        .P2_Set_ILDrn_D(P2_Set_ILDrn_D),
        .P2_Set_ILDrn_E(P2_Set_ILDrn_E),
        .P2_Set_ILDrn_H(P2_Set_ILDrn_H),
        .P2_Set_ILDrn_L(P2_Set_ILDrn_L),
        .P2_Set_ILDrn_A(P2_Set_ILDrn_A),
        .P2_Set_ILDlHLln(P2_Set_ILDlHLln)
    );

    wire _PR_Write_A_100; // <
    wire _PR_InvertIn_100;
    wire _PF_Write_C_100;
    wire _PF_Write_H_100; // >

    DECODER_op_X1_00100111 d00100111(
        .t2(_00100111_t2),
        .t3(_00100111_t3),
        .Flag_H(Flag_H),
        .Flag_Z(Flag_Z),
        .Flag_C(Flag_C),
        .Flag_S(Flag_S),
        .Flag_N(Flag_N),
        .PA_Select_A_high(PA_Select_A_high), // <
        .PA_Select_0x99_low(PA_Select_0x99_low),
        .PF_Select_S_bit23(PF_Select_S_bit23),
        .PF_Select_Z_bit21(PF_Select_Z_bit21), // >
        .PF_Write_S(PF_Write_S),
        .PF_Write_Z(PF_Write_Z),
        .PR_Write_A(_PR_Write_A_100), // <
        .PR_InvertIn(_PR_InvertIn_100),
        .PF_Write_C(_PF_Write_C_100),
        .PF_Write_PV(PF_Write_PV),
        .PF_Write_H(_PF_Write_H_100),
        .PF_Select_C_bit29(PF_Select_C_bit29),
        .PF_Select_Z_bit24(PF_Select_Z_bit24),
        .PF_Select_PV_bit27(PF_Select_PV_bit27),
        .PF_Select_S_bit7(PF_Select_S_bit7),
        .PF_Select_H_bit28(PF_Select_H_bit28), // >
        .PA_ADD(PA_ADD),
        .PA_SUB(PA_SUB),
        .PA_Select_0x60_low(PA_Select_0x60_low),
        .PA_Select_0x06_low(PA_Select_0x06_low),
        .PA_Select_0x66_low(PA_Select_0x66_low)
    );

    wire _PR_Write_A_eee; // <
    wire _PR_InvertIn_eee; // >
    wire _PF_Write_C_eee;
    wire _PF_Write_H_eee;

    DECODER_op_X1_00eee111 d00eee111(
        .enable(_00eee111_t3),
        .Source(Source),
        .notSource(notSource),
        .PF_Write_N(PF_Write_N), // <
        .PF_Write_H(_PF_Write_H_eee), // >
        .PA_Select_A_low(PA_Select_A_low), // <
        .PR_Write_A(_PR_Write_A_eee),
        .PR_InvertIn(_PR_InvertIn_eee), // >
        .PF_Write_C(_PF_Write_C_eee), // <
        .PF_Select_N_bit16(PF_Select_N_bit16), // >
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
        .PF_Select_N_bit17(PF_Select_N_bit17),
        .PF_Select_C_bit0(PF_Select_C_bit0),
        .PF_Select_C_bit17(PF_Select_C_bit17),
        .PA_Select_F_low
    );

    assign PR_Write_A = (_PR_Write_A_100 | _PR_Write_A_eee); // 2
    assign PR_InvertIn = PR_Write_A;

    assign PF_Write_C = (_PF_Write_C_100 | _PF_Write_C_eee); // 2
    assign PF_Write_H = (_PF_Write_H_100 | _PF_Write_H_eee); // 2

endmodule
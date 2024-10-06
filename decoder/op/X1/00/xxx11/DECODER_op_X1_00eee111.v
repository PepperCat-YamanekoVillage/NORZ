// RLCA/RLA/RRCA/RRA/CPL/SCF/CCF
// 12(27)
module DECODER_op_X1_00eee111(
        input wire enable,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PF_Write_N, // <
        output wire PF_Write_H, // >
        output wire PA_Select_A_low, // <
        output wire PR_Write_A,
        output wire PR_InvertIn, // >
        output wire PF_Write_C, // <
        output wire PF_Select_N_bit16, // >
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

    // wire [7:0] notSource = ~Source;

    assign PF_Write_N = enable;
    assign PF_Write_H = enable;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _000xx111;
    wire _001xx111;

    DECODER_1bit_decoder d_00dxx111(
        .notEnable(_not_enable),
        .In(Source[5]),
        .notIn(notSource[5]),
        .out0(_000xx111),
        .out1(_001xx111)
    ); 

    wire _not000xx111 = _000xx111 ~| _000xx111;
    wire _not001xx111 = _001xx111 ~| _001xx111;

    wire _RLCA;
    wire _RLA;
    wire _RRCA;
    wire _RRA;
    wire _CPL;
    wire _SCF;
    wire _CCF;

    DECODER_2bit_decoder d_000dd111( // 8
        .notEnable(_not000xx111),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out00(_RLCA),
        .out01(_RRCA),
        .out10(_RLA),
        .out11(_RRA)
    );

    wire _xCF;

    DECODER_2bit_decoder d_001dd111( // 5
        .notEnable(_not001xx111),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out0x(_CPL),
        .out10(_SCF),
        .out11(_CCF),
        .out1x(_xCF)
    );

    assign PA_Select_A_low = _not_enable ~| _xCF;
    assign PR_Write_A = PA_Select_A_low;
    assign PR_InvertIn = PA_Select_A_low;

    assign PF_Write_C = _not_enable ~| _CPL;
    assign PF_Select_N_bit16 = PF_Write_C;

    assign PA_RLC = _RLCA;
    assign PA_RL = _RLA;
    assign PA_RRC = _RRCA;
    assign PA_RR = _RRA;

    assign PF_Select_C_bit38 = (_RLCA | _RLA); // 2
    assign PF_Select_C_bit37 = (_RRCA | _RRA); // 2

    assign PA_NOT = (_CPL | _CCF); // 2

    assign PF_Select_H_bit16 = _not_enable ~| PA_NOT;

    assign PF_Select_H_bit30 = _CCF;
    assign PF_Select_H_bit17 = _CPL;
    assign PF_Select_N_bit17 = _CPL;
    assign PF_Select_C_bit0 = _CCF;
    assign PF_Select_C_bit17 = _SCF;

    assign PA_Select_F_low = _CCF;

endmodule
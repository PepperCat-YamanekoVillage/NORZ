// RLC/RL/RRC/RR/SLA/SRA/SRL r / BIT/SET/RES b,r
// 28(46)
module DECODER_op_XBIT_r(
        input wire decodedXPT3,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire enable_bit,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_XBIT,
        output wire Pa_Ophd, // >
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
        output wire PR_InvertIn
    );

    // wire [7:0] notSource = ~Source;

    //
    // r
    //

    wire _notdecodedXPT3 = decodedXPT3 ~| decodedXPT3;

    wire _xxxxxxx0;
    wire _xxxxxxx1;

    DECODER_1bit_decoder d_xxxxxxxxd(
        .notEnable(_notdecodedXPT3),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_xxxxxxx0),
        .out1(_xxxxxxx1)
    ); 

    wire _notxxxxxxx0 = _xxxxxxx0 ~| _xxxxxxx0;
    wire _notxxxxxxx1 = _xxxxxxx1 ~| _xxxxxxx1;

    wire _B;  // 000
    wire _C;  // 001
    wire _D;  // 010
    wire _E;  // 011
    wire _H;  // 100
    wire _L;  // 101
    wire _HL; // 110
    wire _A;  // 111

    DECODER_2bit_decoder d_xxxxxdd0( // 8
        .notEnable(_notxxxxxxx0),
        .In(Source[2:1]),
        .notIn(notSource[2:1]),
        .out00(_B),
        .out01(_D),
        .out10(_H),
        .out11(_HL)
    );

    DECODER_2bit_decoder d_xxxxxdd1( // 8
        .notEnable(_notxxxxxxx1),
        .In(Source[2:1]),
        .notIn(notSource[2:1]),
        .out00(_C),
        .out01(_E),
        .out10(_L),
        .out11(_A)
    );

    wire enable_bit = _notdecodedXPT3 ~| _HL;

    assign PR_Reset_XPT = enable_bit;
    assign P2_Set_CM1 = enable_bit;
    assign P2_Reset_XBIT = enable_bit;
    assign Pa_Ophd = enable_bit;

    assign PR_Write_B = _B;
    assign PR_Write_C = _C;
    assign PR_Write_D = _D;
    assign PR_Write_E = _E;
    assign PR_Write_H = _H;
    assign PR_Write_L = _L;
    assign PR_Write_A = _A;

    wire _notB = _B ~| _B;
    wire _notC = _C ~| _C;
    wire _notD = _D ~| _D;
    wire _notE = _E ~| _E;
    wire _notH = _H ~| _H;
    wire _notL = _L ~| _L;
    wire _notA = _A ~| _A;

    assign PA_Select_B_low = _notB ~| Source[7];
    assign PA_Select_C_low = _notC ~| Source[7];
    assign PA_Select_D_low = _notD ~| Source[7];
    assign PA_Select_E_low = _notE ~| Source[7];
    assign PA_Select_H_low = _notH ~| Source[7];
    assign PA_Select_L_low = _notL ~| Source[7];
    assign PA_Select_A_low = _notA ~| Source[7];

    assign PA_Select_B_high = _notB ~| notSource[7];
    assign PA_Select_C_high = _notC ~| notSource[7];
    assign PA_Select_D_high = _notD ~| notSource[7];
    assign PA_Select_E_high = _notE ~| notSource[7];
    assign PA_Select_H_high = _notH ~| notSource[7];
    assign PA_Select_L_high = _notL ~| notSource[7];
    assign PA_Select_A_high = _notA ~| notSource[7];

    wire _BorDorH = _notxxxxxxx0 ~| _HL;
    wire _BorDorHorA = (_BorDorH | _A); // 2
    assign PR_InvertIn = _BorDorHorA;

endmodule
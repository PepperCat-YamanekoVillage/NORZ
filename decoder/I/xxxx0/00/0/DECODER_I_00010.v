// LD r,n
// 10(24)
module DECODER_I_00010(
        input wire enable,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire PR_Write_A,
        output wire PR_Write_B,
        output wire PR_Write_C,
        output wire PR_Write_D,
        output wire PR_Write_E,
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd, // >
        output wire PR_InvertIn
    );

    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _BC;
    wire _DE;
    wire _HL;
    wire _A;

    DECODER_2bit_decoder d_00010ddx( // 8
        .notEnable(_not_enable),
        .In(ITABLE[2:1]),
        .notIn(notITABLE[2:1]),
        .out00(_BC),
        .out01(_DE),
        .out10(_HL),
        .out11(_A)
    );

    wire _notBC = _BC ~| _BC;
    wire _notDE = _DE ~| _DE;
    wire _notHL = _HL ~| _HL;

    wire _B;
    wire _C;
    wire _D;
    wire _E;
    wire _H;
    wire _L;

    DECODER_1bit_decoder d_0001000d(
        .notEnable(_notBC),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(_B),
        .out1(_C),
    );

    DECODER_1bit_decoder d_0001001d(
        .notEnable(_notDE),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(_D),
        .out1(_E),
    );

    DECODER_1bit_decoder d_0001010d(
        .notEnable(_notHL),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(_H),
        .out1(_L),
    );

    assign PR_Write_A = _A;
    assign PR_Write_B = _B;
    assign PR_Write_C = _C;
    assign PR_Write_D = _D;
    assign PR_Write_E = _E;
    assign PR_Write_H = _H;
    assign PR_Write_L = _L;

    assign PR_Reset_XPT = enable;
    assign P2_Set_CM1 = enable;
    assign P2_Reset_ITABLE = enable;
    assign Pa_Ophd = enable;

    assign PR_InvertIn = (_A | _B | _D | _H); // 6

endmodule
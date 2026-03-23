// LD I/R,A
// 3(5)
module DECODER_op_XOTR_0100x111(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_XOTR,
        output wire PA_Select_A_low,
        output wire PA_NOP,
        output wire Pa_Ophd, // >
        output wire PR_Write_I,
        output wire PR_InvertIn,
        output wire PR_Write_R
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _decodedXPT4 = _not_enable ~| notXPT[2];

    //
    // decoder
    //

    wire _notdecodedXPT4 = _decodedXPT4 ~| _decodedXPT4;

    wire _I;
    wire _R;

    DECODER_1bit_decoder d_0100d111(
        .notEnable(_notdecodedXPT4),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_I),
        .out1(_R)
    );

    assign PR_Reset_XPT = _decodedXPT4;
    assign P2_Set_CM1 = _decodedXPT4;
    assign P2_Reset_XOTR = _decodedXPT4;
    assign PA_Select_A_low = _decodedXPT4;
    assign PA_NOP = _decodedXPT4;
    assign Pa_Ophd = _decodedXPT4;

    assign PR_Write_I = _I;
    assign PR_InvertIn = _I;

    assign PR_Write_R = _R;

endmodule
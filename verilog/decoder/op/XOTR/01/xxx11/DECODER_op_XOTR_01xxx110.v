// IM 0/1/2
// 3(8)
module DECODER_op_XOTR_01xxx110(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_XOTR,
        output wire Pa_Ophd, // >
        output wire P2_IM0,
        output wire P2_IM1,
        output wire P2_IM2
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _decodedXPT3 = _not_enable ~| notXPT[0];

    assign PR_Reset_XPT = _decodedXPT3;
    assign P2_Set_CM1 = _decodedXPT3;
    assign P2_Reset_XOTR = _decodedXPT3;
    assign Pa_Ophd = _decodedXPT3;

    wire _notdecodedXPT3 = _decodedXPT3 ~| _decodedXPT3;

    DECODER_2bit_decoder d_01xdd110( // 5
        .notEnable(_notdecodedXPT3),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out0x(P2_IM0),
        .out10(P2_IM1),
        .out11(P2_IM2)
    );

endmodule
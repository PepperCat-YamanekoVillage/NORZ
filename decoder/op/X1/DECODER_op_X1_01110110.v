// HALT
// 1(3)
module DECODER_op_X1_01110110(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        output wire [3:0] _decodedXPT,
        output wire P2_Set_LHALT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd // >
    );

    // wire [4:0] notXPT = ~XPT;

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

    assign P2_Set_LHALT = _decodedXPT[2];

    assign PR_Reset_XPT = _decodedXPT[3];
    assign P2_Set_CM1 = _decodedXPT[3];
    assign Pa_Ophd = _decodedXPT[3];

endmodule
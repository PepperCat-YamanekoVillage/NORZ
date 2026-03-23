// NOP / EX AF,A'F'
// 2
module DECODER_op_X1_0000x000(
        input wire enable,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire P2_Set_CM1, // <
        output wire Pa_Ophd, // >
        output wire PR_Ex_AF_AF
    );

    // wire [7:0] notSource = ~Source;

    assign P2_Set_CM1 = enable;
    assign Pa_Ophd = enable;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    assign PR_Ex_AF_AF = _not_enable ~| notSource[3];

endmodule
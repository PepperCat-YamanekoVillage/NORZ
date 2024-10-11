// 2
module DECODER_1bit_decoder(
        input wire notEnable,
        input wire In,
        input wire notIn,
        output wire out0,
        output wire out1
    );

    // wire notIn = ~In;

    assign out0 = In ~| notEnable;
    assign out1 = notIn ~| notEnable;

endmodule
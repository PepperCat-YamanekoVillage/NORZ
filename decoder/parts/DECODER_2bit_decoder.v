// 8
module DECODER_2bit_decoder(
        input wire notEnable,
        input wire [1:0] In,
        input wire [1:0] notIn,
        output wire out0x,
        output wire out1x,

        // -1(セット)
        // -1
        output wire out00,
        // -1
        output wire out01,

        // -1(セット)
        // -1
        output wire out10,
        // -1
        output wire out11
    );

    // wire [1:0] notIn = ~In;

    assign out0x = In[1] ~| notEnable;
    assign out1x = notIn[1] ~| notEnable;

    wire _not_out0x = out0x ~| out0x;
    wire _not_out1x = out1x ~| out1x;

    assign out00 = In[0] ~| _not_out0x;
    assign out01 = notIn[0] ~| _not_out0x;

    assign out10 = In[0] ~| _not_out1x;
    assign out11 = notIn[0] ~| _not_out1x;

endmodule
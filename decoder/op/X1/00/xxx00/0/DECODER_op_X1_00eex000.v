// JR e / JR Z/NZ/C/NC,e / DJNZ e
// 3(15)
module DECODER_op_X1_00eex000(
        input wire enable,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire P2_Set_CMR,
        output wire P2_Set_IDJNZe,
        output wire P2_Set_IJRNZe,
        output wire P2_Set_IJRNCe,
        output wire P2_Set_IJRe,
        output wire P2_Set_IJRZe,
        output wire P2_Set_IJRCe
    );

    // wire [7:0] notSource = ~Source;

    assign P2_Set_CMR = enable;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _00xx0000;
    wire _00xx1000;

    DECODER_1bit_decoder d_00xxd000(
        .notEnable(_not_enable),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_00xx0000),
        .out1(_00xx1000)
    ); 

    wire _not00xx0000 = _00xx0000 ~| _00xx0000;
    wire _not00xx1000 = _00xx1000 ~| _00xx1000;

    DECODER_2bit_decoder d_00dd0000( // 5
        .notEnable(_not00xx0000),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out0x(P2_Set_IDJNZe),
        .out10(P2_Set_IJRNZe),
        .out11(P2_Set_IJRNCe)
    );

    DECODER_2bit_decoder d_00dd1000( // 5
        .notEnable(_not00xx1000),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out0x(P2_Set_IJRe),
        .out10(P2_Set_IJRZe),
        .out11(P2_Set_IJRCe)
    );

endmodule
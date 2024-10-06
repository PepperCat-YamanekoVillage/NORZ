// CALL nn / XIX / XIY / XOTR
// 2(10)
module DECODER_op_X1_11xx1101(
        input wire enable,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire P2_Set_ICALLnn_0,
        output wire P2_Set_XIX,
        output wire P2_Set_XOTR,
        output wire P2_Set_XIY,
        output wire P2_Set_CMR,
        output wire P2_Set_CM1
    );

    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    DECODER_2bit_decoder d_11dd1101( // 8
        .notEnable(_not_enable),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(P2_Set_ICALLnn_0),
        .out01(P2_Set_XIX),
        .out10(P2_Set_XOTR),
        .out11(P2_Set_XIY)
    );

    assign P2_Set_CMR = P2_Set_ICALLnn_0;
    assign P2_Set_CM1 = _not_enable ~| P2_Set_ICALLnn_0;

endmodule
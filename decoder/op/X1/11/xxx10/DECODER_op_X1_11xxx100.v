// CALL cc,nn
// 3(21)
module DECODER_op_X1_11xxx100(
        input wire enable,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire P2_Set_CMR,
        output wire P2_Set_ICALLccnn_0_0,
        output wire P2_Set_ICALLccnn_1_0,
        output wire P2_Set_ICALLccnn_2_0,
        output wire P2_Set_ICALLccnn_3_0,
        output wire P2_Set_ICALLccnn_4_0,
        output wire P2_Set_ICALLccnn_5_0,
        output wire P2_Set_ICALLccnn_6_0,
        output wire P2_Set_ICALLccnn_7_0
    );

    // wire [7:0] notSource = ~Source;

    assign P2_Set_CMR = enable;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _110xx100;
    wire _111xx100;

    DECODER_1bit_decoder d_11dxx100(
        .notEnable(_not_enable),
        .In(Source[5]),
        .notIn(notSource[5]),
        .out0(_110xx100),
        .out1(_111xx100)
    );

    wire _not110xx100 = _110xx100 ~| _110xx100;
    wire _not111xx100 = _111xx100 ~| _111xx100;

    DECODER_2bit_decoder d_110dd100( // 8
        .notEnable(_not110xx100),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out00(P2_Set_ICALLccnn_0_0),
        .out01(P2_Set_ICALLccnn_1_0),
        .out10(P2_Set_ICALLccnn_2_0),
        .out11(P2_Set_ICALLccnn_3_0)
    );

    DECODER_2bit_decoder d_111dd100( // 8
        .notEnable(_not111xx100),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out00(P2_Set_ICALLccnn_4_0),
        .out01(P2_Set_ICALLccnn_5_0),
        .out10(P2_Set_ICALLccnn_6_0),
        .out11(P2_Set_ICALLccnn_7_0)
    );

endmodule
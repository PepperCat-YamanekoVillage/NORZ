// JP nn / JP cc,nn / IN A,(n) / OUT (n),A
// 5(30)
module DECODER_op_X1_11eee01e(
        input wire enable,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire P2_Set_CMR,
        output wire P2_Set_IJPccnn_0_0,
        output wire P2_Set_IJPccnn_1_0,
        output wire P2_Set_IJPccnn_2_0,
        output wire P2_Set_IJPccnn_3_0,
        output wire P2_Set_IJPccnn_4_0,
        output wire P2_Set_IJPccnn_5_0,
        output wire P2_Set_IJPccnn_6_0,
        output wire P2_Set_IJPccnn_7_0,
        output wire P2_Set_IJPnn_0,
        output wire P2_Set_IOUTlnlA,
        output wire P2_Set_IINAlnl
    );

    // wire [7:0] notSource = ~Source;

    assign P2_Set_CMR = enable;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _11xxx010;
    wire _11xxx011;

    DECODER_1bit_decoder d_11xxx01d(
        .notEnable(_not_enable),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_11xxx010),
        .out1(_11xxx011)
    );

    wire _not11xxx010 = _11xxx010 ~| _11xxx010;
    wire _not11xxx011 = _11xxx011 ~| _11xxx011;

    wire _110xx010;
    wire _111xx010;

    DECODER_1bit_decoder d_11dxx010(
        .notEnable(_not11xxx010),
        .In(Source[5]),
        .notIn(notSource[5]),
        .out0(_110xx010),
        .out1(_111xx010)
    );

    wire _not110xx010 = _110xx010 ~| _110xx010;
    wire _not111xx010 = _111xx010 ~| _111xx010;

    DECODER_2bit_decoder d_110dd010( // 8
        .notEnable(_not110xx010),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out00(P2_Set_IJPccnn_0_0),
        .out01(P2_Set_IJPccnn_1_0),
        .out10(P2_Set_IJPccnn_2_0),
        .out11(P2_Set_IJPccnn_3_0)
    );

    DECODER_2bit_decoder d_111dd010( // 8
        .notEnable(_not111xx010),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out00(P2_Set_IJPccnn_4_0),
        .out01(P2_Set_IJPccnn_5_0),
        .out10(P2_Set_IJPccnn_6_0),
        .out11(P2_Set_IJPccnn_7_0)
    );

    DECODER_2bit_decoder d_110dd011( // 5
        .notEnable(_not11xxx011),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out0x(P2_Set_IJPnn_0),
        .out10(P2_Set_IOUTlnlA),
        .out11(P2_Set_IINAlnl)
    );

endmodule
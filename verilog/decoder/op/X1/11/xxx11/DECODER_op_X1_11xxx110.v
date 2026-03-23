// ADD/ADC/SUB/SBC/AND/XOR/OR/CP n
// 5(23)
module DECODER_op_X1_11xxx110(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [3:0] _decodedXPT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CMA, // >
        output wire P2_Set_IADDAn,
        output wire P2_Set_IADCAn,
        output wire P2_Set_ISUBAn,
        output wire P2_Set_ISBCAn,
        output wire P2_Set_IANDn,
        output wire P2_Set_IXORn,
        output wire P2_Set_IORn,
        output wire P2_Set_ICPn
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    assign _decodedXPT[3] = _not_enable ~| notXPT[0];

    assign PR_Reset_XPT = _decodedXPT[3];
    assign P2_Set_CMA = _decodedXPT[3];

    //
    // decoder
    //

    wire _nott3 = _decodedXPT[3] ~| _decodedXPT[3];

    wire _110xx110_t3;
    wire _111xx110_t3;

    DECODER_1bit_decoder d_11dxx110_t3(
        .notEnable(_nott3),
        .In(Source[5]),
        .notIn(notSource[5]),
        .out0(_110xx110_t3),
        .out1(_111xx110_t3)
    ); 

    wire _not110xx110_t3 = _110xx110_t3 ~| _110xx110_t3;
    wire _not111xx110_t3 = _111xx110_t3 ~| _111xx110_t3;

    DECODER_2bit_decoder d_110dd110_t3( // 8
        .notEnable(_not110xx110_t3),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out00(P2_Set_IADDAn),
        .out01(P2_Set_IADCAn),
        .out10(P2_Set_ISUBAn),
        .out11(P2_Set_ISBCAn)
    );

    DECODER_2bit_decoder d_111dd110_t3( // 8
        .notEnable(_not111xx110_t3),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out00(P2_Set_IANDn),
        .out01(P2_Set_IXORn),
        .out10(P2_Set_IORn),
        .out11(P2_Set_ICPn)
    );

endmodule
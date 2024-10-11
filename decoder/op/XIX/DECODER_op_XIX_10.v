// ADD/ADC/SUB/SBC/AND/XOR/OR/CP (IX/IY+d)
// 12(48)
module DECODER_op_XIX_10(
        input wire enable,
        input wire is_Y,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [3:0] _decodedXPT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CMR, // >
        output wire P2_Reset_XIX,
        output wire P2_Reset_XIY,
        output wire P2_Set_IADDAlIXtdl,
        output wire P2_Set_IADCAlIXtdl,
        output wire P2_Set_ISUBAlIXtdl,
        output wire P2_Set_ISBCAlIXtdl,
        output wire P2_Set_IANDlIXtdl,
        output wire P2_Set_IXORlIXtdl,
        output wire P2_Set_IORlIXtdl,
        output wire P2_Set_ICPlIXtdl,
        output wire P2_Set_IADDAlIYtdl,
        output wire P2_Set_IADCAlIYtdl,
        output wire P2_Set_ISUBAlIYtdl,
        output wire P2_Set_ISBCAlIYtdl,
        output wire P2_Set_IANDlIYtdl,
        output wire P2_Set_IXORlIYtdl,
        output wire P2_Set_IORlIYtdl,
        output wire P2_Set_ICPlIYtdl
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    assign _decodedXPT[3] = _not_enable ~| notXPT[0];

    assign PR_Reset_XPT = _decodedXPT[3];
    assign P2_Set_CMR = _decodedXPT[3];

    //
    // decoder
    //

    wire _nott3 = _decodedXPT[3] ~| _decodedXPT[3];

    wire _not_is_Y = is_Y ~| is_Y;

    assign P2_Reset_XIX = _nott3 ~| is_Y;
    assign P2_Reset_XIY = _nott3 ~| _not_is_Y;

    wire _nott3_X = P2_Reset_XIX ~| P2_Reset_XIX;
    wire _nott3_Y = P2_Reset_XIY ~| P2_Reset_XIY;

    // X

    wire _10xx0110_X;
    wire _10xx1110_X;

    DECODER_1bit_decoder d_10xxd110_t3_X(
        .notEnable(_nott3_X),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_10xx0110_X),
        .out1(_10xx1110_X)
    );

    wire _not10xx0110_X = _10xx0110_X ~| _10xx0110_X;
    wire _not10xx1110_X = _10xx1110_X ~| _10xx1110_X;

    DECODER_2bit_decoder d_10dd0110_t3_X( // 8
        .notEnable(_not10xx0110_X),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(P2_Set_IADDAlIXtdl),
        .out01(P2_Set_ISUBAlIXtdl),
        .out10(P2_Set_IANDlIXtdl),
        .out11(P2_Set_IORlIXtdl)
    );

    DECODER_2bit_decoder d_10dd1110_t3_X( // 8
        .notEnable(_not10xx1110_X),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(P2_Set_IADCAlIXtdl),
        .out01(P2_Set_ISBCAlIXtdl),
        .out10(P2_Set_IXORlIXtdl),
        .out11(P2_Set_ICPlIXtdl)
    );

    // Y

    wire _10xx0110_Y;
    wire _10xx1110_Y;

    DECODER_1bit_decoder d_10xxd110_t3_Y(
        .notEnable(_nott3_Y),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_10xx0110_Y),
        .out1(_10xx1110_Y)
    );

    wire _not10xx0110_Y = _10xx0110_Y ~| _10xx0110_Y;
    wire _not10xx1110_Y = _10xx1110_Y ~| _10xx1110_Y;

    DECODER_2bit_decoder d_10dd0110_t3_Y( // 8
        .notEnable(_not10xx0110_Y),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(P2_Set_IADDAlIYtdl),
        .out01(P2_Set_ISUBAlIYtdl),
        .out10(P2_Set_IANDlIYtdl),
        .out11(P2_Set_IORlIYtdl)
    );

    DECODER_2bit_decoder d_10dd1110_t3_Y( // 8
        .notEnable(_not10xx1110_Y),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(P2_Set_IADCAlIYtdl),
        .out01(P2_Set_ISBCAlIYtdl),
        .out10(P2_Set_IXORlIYtdl),
        .out11(P2_Set_ICPlIYtdl)
    );

endmodule
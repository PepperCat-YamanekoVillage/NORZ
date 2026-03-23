// ADD/ADC/SUB/SBC/AND/OR/XOR/CP (HL)
// 3(8)
module DECODER_op_X1_10xxx110(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        output wire [6:0] _decodedXPT,
        output wire enable_alu,
        output wire PI_SelectAd_HL,
        output wire PC_RA0,
        output wire PC_RA1,
        output wire PC_RA2
    );

    // wire [4:0] notXPT = ~XPT;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _t1xx = _not_enable ~| notXPT[2];

    wire _nott1xx = _t1xx ~| _t1xx;

    DECODER_2bit_decoder t_1dd( // 5
        .notEnable(_nott1xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out1x(_decodedXPT[6])
    );

    // 4~6

    assign PI_SelectAd_HL = _t1xx;

    // 4

    assign PC_RA0 = _decodedXPT[4];

    // 5

    assign PC_RA1 = _decodedXPT[5];

    // 6

    assign PC_RA2 = _decodedXPT[6];

    assign enable_alu = _decodedXPT[6];

endmodule
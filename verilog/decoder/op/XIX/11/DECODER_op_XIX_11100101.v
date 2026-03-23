// PUSH IX/IY
// 23(40)
module DECODER_op_XIX_11000101(
        input wire enable,
        input wire is_Y,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        output wire [10:0] _decodedXPT,
        output wire PR_Dec_SP,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_IX_high,
        output wire PI_SelectDt_IY_high,
        output wire PI_SelectDt_IX_low,
        output wire PI_SelectDt_IY_low,
        output wire PI_SelectAd_SP,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd, // >
        output wire P2_Reset_XIX,
        output wire P2_Reset_XIY
    );

    // wire [4:0] notXPT = ~XPT;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _t01xx;
    wire _t10xx;

    DECODER_2bit_decoder t_ddxx( // 4
        .notEnable(_not_enable),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out01(_t01xx),
        .out1x(_t10xx)
    );

    wire _nott01xx = _t01xx ~| _t01xx;
    wire _nott10xx = _t10xx ~| _t10xx;

    DECODER_2bit_decoder t_01dd( // 8
        .notEnable(_nott01xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7])
    );

    DECODER_2bit_decoder t_10dd( // 5
        .notEnable(_nott10xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[8]),
        .out01(_decodedXPT[9]),
        .out1x(_decodedXPT[10])
    );

    // 4or7

    assign PR_Dec_SP = (_decodedXPT[4] | _decodedXPT[7]); // 2

    // 5or8

    assign PC_W0 = (_decodedXPT[5] | _decodedXPT[8]); // 2

    // 6or9

    assign PC_W1 = (_decodedXPT[6] | _decodedXPT[9]); // 2

    // 7or10

    assign PC_W2 = (_decodedXPT[7] | _decodedXPT[10]); // 2

    // 5~7

    wire _t5_7 = _nott01xx ~| _decodedXPT[4];

    wire _nott5_7 = _t5_7 ~| _t5_7;

    wire _not_is_Y = is_Y ~| is_Y;

    assign PI_SelectDt_IX_high = _nott5_7 ~| is_Y;
    assign PI_SelectDt_IY_high = _nott5_7 ~| _not_is_Y;

    // 8~10

    assign PI_SelectDt_IX_low = _nott10xx ~| is_Y;
    assign PI_SelectDt_IY_low = _nott10xx ~| _not_is_Y;

    // 5~10

    assign PI_SelectAd_SP = (_t5_7 | _t10xx); // 2

    // 10

    assign PR_Reset_XPT = _decodedXPT[10];
    assign P2_Set_CM1 = _decodedXPT[10];
    assign Pa_Ophd = _decodedXPT[10];

    wire _nott10 = _decodedXPT[10] ~| _decodedXPT[10];

    assign P2_Reset_XIX = _nott10 ~| is_Y;
    assign P2_Reset_XIY = _nott10 ~| _not_is_Y;

endmodule
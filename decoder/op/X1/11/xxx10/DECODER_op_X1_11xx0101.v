// PUSH qq
// 15(48)
module DECODER_op_X1_11xx0101(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [10:0] _decodedXPT,
        output wire PR_Dec_SP,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_B,
        output wire PI_SelectDt_C,
        output wire PI_SelectDt_D,
        output wire PI_SelectDt_E,
        output wire PI_SelectDt_H,
        output wire PI_SelectDt_L,
        output wire PI_SelectDt_A,
        output wire PI_SelectDt_F,
        output wire PI_SelectAd_SP,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd // >
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

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

    DECODER_2bit_decoder d_11dd0101_t5_7( // 8
        .notEnable(_nott5_7),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(PI_SelectDt_B),
        .out01(PI_SelectDt_D),
        .out10(PI_SelectDt_H),
        .out11(PI_SelectDt_A)
    );

    // 8~10

    DECODER_2bit_decoder d_11dd0101_t8_10( // 8
        .notEnable(_nott10xx),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(PI_SelectDt_C),
        .out01(PI_SelectDt_E),
        .out10(PI_SelectDt_L),
        .out11(PI_SelectDt_F)
    );

    // 5~10

    assign PI_SelectAd_SP = (_t5_7 | _t10xx); // 2

    // 10

    assign PR_Reset_XPT = _decodedXPT[10];
    assign P2_Set_CM1 = _decodedXPT[10];
    assign Pa_Ophd = _decodedXPT[10];

endmodule
// LD (HL),r
// 5(25)
module DECODER_op_X1_01110xxx(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [6:0] _decodedXPT,
        output wire PI_SelectAd_HL,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd, // >
        output wire PI_SelectDt_B,
        output wire PI_SelectDt_C,
        output wire PI_SelectDt_D,
        output wire PI_SelectDt_E,
        output wire PI_SelectDt_H,
        output wire PI_SelectDt_L,
        output wire PI_SelectDt_A
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

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

    assign PC_W0 = _decodedXPT[4];

    // 5

    assign PC_W1 = _decodedXPT[5];

    // 6

    assign PC_W2 = _decodedXPT[6];

    assign PR_Reset_XPT = _decodedXPT[6];
    assign P2_Set_CM1 = _decodedXPT[6];
    assign Pa_Ophd = _decodedXPT[6];

    //
    // decoder
    //


    wire _01110xx0;
    wire _01110xx1;

    DECODER_1bit_decoder d_01110xxd(
        .notEnable(_nott1xx),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_01110xx0),
        .out1(_01110xx1)
    ); 

    wire _not01110xx0 = _01110xx0 ~| _01110xx0;
    wire _not01110xx1 = _01110xx1 ~| _01110xx1;

    DECODER_2bit_decoder d_01110dd0( // 5
        .notEnable(_not01110xx0),
        .In(Source[2:1]),
        .notIn(notSource[2:1]),
        .out00(PI_SelectDt_B),
        .out01(PI_SelectDt_D),
        .out1x(PI_SelectDt_H)
    );

    DECODER_2bit_decoder d_01110dd1( // 8
        .notEnable(_not01110xx1),
        .In(Source[2:1]),
        .notIn(notSource[2:1]),
        .out00(PI_SelectDt_C),
        .out01(PI_SelectDt_E),
        .out10(PI_SelectDt_L),
        .out11(PI_SelectDt_A)
    );

endmodule
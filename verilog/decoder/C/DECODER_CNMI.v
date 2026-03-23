// 16(34)
module DECODER_CNMI(
        input wire not_decodingIn,
        input wire notCNMI,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        output wire [10:0] _decodedXPT,
        output wire PC_M1,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PR_Dec_SP,
        output wire PI_SelectDt_PC_high,
        output wire PI_SelectDt_PC_low,
        output wire notPI_SelectAd_SP,
        output wire PR_Reset_XPT, // < 10
        output wire P2_Set_CM1,
        output wire P2_Reset_CNMI,
        output wire PA_Select_0x66_low,
        output wire PA_NOP,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low,
        output wire Pa_Ophd, // >
        output wire not_decodingOut
    );

    // wire [3:0] notXPT = ~XPT;

    wire _is_cnmi = not_decodingIn ~| notCNMI;

    wire _notEnable = _is_cnmi ~| _is_cnmi;

    wire _decodingOut = _is_cnmi ~| not_decodingIn;
    assign not_decodingOut = _decodingOut ~| _decodingOut;

    //
    // decoder
    //

    wire _00xx;
    wire _01xx;
    wire _10xx;

    DECODER_2bit_decoder d_ddxx( // 5
        .notEnable(_notEnable),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out00(_00xx),
        .out01(_01xx),
        .out1x(_10xx)
    );

    wire _not_01xx = _01xx ~| _01xx;
    wire _not_10xx = _10xx ~| _10xx;

    DECODER_2bit_decoder d_01dd( // 8
        .notEnable(_not_01xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7])
    );

    DECODER_2bit_decoder d_10dd( // 5
        .notEnable(_not_10xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[8]),
        .out01(_decodedXPT[9]),
        .out1x(_decodedXPT[10])
    );

    // 1~3

    assign PC_M1 = _00xx;

    // 4 or 7

    wire _not4or7 = _decodedXPT[4] ~| _decodedXPT[7];
    wire _4or7 = _not4or7 ~| _not4or7;
    assign PR_Dec_SP = _4or7;

    // 5 ~ 7

    wire _5or6or7 = _not_01xx ~| _decodedXPT[4];

    assign PI_SelectDt_PC_high = _5or6or7;

    // 5 or 8

    wire _not5or8 = _decodedXPT[5] ~| _decodedXPT[8];
    wire _5or8 = _not5or8 ~| _not5or8;
    assign PC_W0 = _5or8;

    // 5 ~ 10

    wire _not5_10 = _5or6or7 ~| _10xx;
    assign notPI_SelectAd_SP = _not5_10;

    // 6 or 9

    wire _not6or9 = _decodedXPT[6] ~| _decodedXPT[9];
    wire _6or9 = _not6or9 ~| _not6or9;
    assign PC_W1 = _6or9;

    // 7 or 10

    wire _not7or10 = _decodedXPT[7] ~| _decodedXPT[10];
    wire _7or10 = _not7or10 ~| _not7or10;
    assign PC_W2 = _7or10;

    // 8 ~ 10

    assign PI_SelectDt_PC_low = _10xx;

    // 10

    assign PR_Reset_XPT = _decodedXPT[10];
    assign P2_Set_CM1 = _decodedXPT[10];
    assign P2_Reset_CNMI = _decodedXPT[10];
    assign PA_Select_0x66_low = _decodedXPT[10];
    assign PA_NOP = _decodedXPT[10];
    assign PR_Write_PC_high = _decodedXPT[10];
    assign PR_Write_PC_low = _decodedXPT[10];
    assign Pa_Ophd = _decodedXPT[10];

endmodule
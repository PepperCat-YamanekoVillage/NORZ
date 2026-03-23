// 39(57)
module DECODER_CINT0_CALL(
        input wire not_decodingIn,
        input wire notCINT0_CALL,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        output wire [18:0] _decodedXPT,
        output wire PC_MR0,
        output wire PC_MR1,
        output wire PC_MR2,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PR_Dec_SP,
        output wire PI_SelectDt_PC_high,
        output wire PI_SelectAd_SP,
        output wire PI_SelectDt_PC_low,
        output wire PR_Reset_XPT, // < 18
        output wire P2_Set_CM1,
        output wire P2_Reset_CINT,
        output wire PA_Select_OPOPold_low,
        output wire PA_NOP,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low,
        output wire Pa_Ophd, // >
        output wire not_decodingOut
    );

    // wire [4:0] notXPT = ~XPT;

    wire _is_cint0_call = not_decodingIn ~| notCINT0_CALL;

    wire _decodingOut = _is_cint0_call ~| not_decodingIn;
    assign not_decodingOut = _decodingOut ~| _decodingOut;

    //
    // decoder
    //

    wire _00xxx;
    wire _01xxx;
    wire _10xxx;

    wire _not_is_cint0_call = _is_cint0_call ~| _is_cint0_call;

    DECODER_2bit_decoder d_ddxxx( // 5
        .notEnable(_not_is_cint0_call),
        .In(XPT[4:3]),
        .notIn(notXPT[4:3]),
        .out00(_00xxx),
        .out01(_01xxx),
        .out1x(_10xxx)
    );

    // 0011x

    wire _not00xxx = _00xxx ~| _00xxx;

    assign _decodedXPT[6] = XPT[0] ~| _not00xxx;
    assign _decodedXPT[7] = notXPT[0] ~| _not00xxx;

    wire _0100x;
    wire _0101x;
    wire _0110x;
    wire _0111x;

    wire _not_01xxx = _01xxx ~| _01xxx;

    DECODER_2bit_decoder d_01ddx( // 8
        .notEnable(_not_01xxx),
        .In(XPT[2:1]),
        .notIn(notXPT[2:1]),
        .out00(_0100x),
        .out01(_0101x),
        .out10(_0110x),
        .out11(_0111x)
    );

    // 0100x

    wire _not0100x = _0100x ~| _0100x;

    assign _decodedXPT[8] = XPT[0] ~| _not0100x;
    assign _decodedXPT[9] = notXPT[0] ~| _not0100x;

    // 0101x

    wire _not0101x = _0101x ~| _0101x;

    assign _decodedXPT[10] = XPT[0] ~| _not0101x;
    assign _decodedXPT[11] = notXPT[0] ~| _not0101x;

    // 0110x

    wire _not0110x = _0110x ~| _0110x;

    assign _decodedXPT[12] = XPT[0] ~| _not0110x;
    assign _decodedXPT[13] = notXPT[0] ~| _not0110x;

    // 0111x

    wire _not0111x = _0111x ~| _0111x;

    assign _decodedXPT[14] = XPT[0] ~| _not0111x;
    assign _decodedXPT[15] = notXPT[0] ~| _not0111x;

    wire _not_10xxx = _10xxx ~| _10xxx;

    DECODER_2bit_decoder d_100dd( // 5
        .notEnable(_not_10xxx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[16]),
        .out01(_decodedXPT[17]),
        .out1x(_decodedXPT[18])
    );

    // 6or9

    wire _not6or9 = _decodedXPT[6] ~| _decodedXPT[9];
    wire _6or9 = _not6or9 ~| _not6or9;

    assign PC_MR0 = _6or9;

    // 7or10

    wire _not7or10 = _decodedXPT[7] ~| _decodedXPT[10];
    wire _7or10 = _not7or10 ~| _not7or10;

    assign PC_MR1 = _7or10;

    // 8or11

    wire _not8or11 = _decodedXPT[8] ~| _decodedXPT[11];
    wire _8or11 = _not8or11 ~| _not8or11;

    assign PC_MR2 = _8or11;

    // 12or15

    wire _not12or15 = _decodedXPT[12] ~| _decodedXPT[15];
    wire _12or15 = _not12or15 ~| _not12or15;

    assign PR_Dec_SP = _12or15;

    // 13~15

    wire _not13_15 = _decodedXPT[13] ~| _0111x;
    wire _13_15 = _not13_15 ~| _not13_15;

    assign PI_SelectDt_PC_high = _13_15;

    // 13or16

    wire _not13or16 = _decodedXPT[13] ~| _decodedXPT[16];
    wire _13or16 = _not13or16 ~| _not13or16;

    assign PC_W0 = _13or16;

    // 14or17

    wire _not14or17 = _decodedXPT[14] ~| _decodedXPT[17];
    wire _14or17 = _not14or17 ~| _not14or17;

    assign PC_W1 = _14or17;

    // 15or18

    wire _not15or18 = _decodedXPT[15] ~| _decodedXPT[18];
    wire _15or18 = _not15or18 ~| _not15or18;

    assign PC_W2 = _15or18;

    // 13~18

    wire _not13_18 = _13_15 ~| _10xxx;
    wire _13_18 = _not13_18 ~| _not13_18;

    assign PI_SelectAd_SP = _13_18;

    // 16~18

    assign PI_SelectDt_PC_low = _10xxx;

    // 18

    assign PR_Reset_XPT = _decodedXPT[18];
    assign P2_Set_CM1 = _decodedXPT[18];
    assign P2_Reset_CINT = _decodedXPT[18];
    assign PA_Select_OPOPold_low = _decodedXPT[18];
    assign PA_NOP = _decodedXPT[18];
    assign PR_Write_PC_high = _decodedXPT[18];
    assign PR_Write_PC_low = _decodedXPT[18];
    assign Pa_Ophd = _decodedXPT[18];

endmodule
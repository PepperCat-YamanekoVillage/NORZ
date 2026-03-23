// 5
module DECODER_CINT1(
        input wire not_decodingIn,
        input wire notCINT1,
        input wire not_isXPT12,
        output wire enable_cint,
        output wire PA_Select_0x38_low,
        output wire not_decodingOut
    );

    wire _is_cint1 = not_decodingIn ~| notCINT1;

    wire _decodingOut = _is_cint1 ~| not_decodingIn;
    assign not_decodingOut = _decodingOut ~| _decodingOut;

    assign enable_cint = _is_cint1;

    //
    // decoder
    //

    wire _not_is_cint1 = _is_cint1 ~| _is_cint1;
    wire _is1100_1 = not_isXPT12 ~| _not_is_cint1;

    // 12

    assign PA_Select_0x38_low = _is1100_1;

endmodule
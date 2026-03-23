// DECODER_CINT1 と同じ
// 5
module DECODER_CINT2(
        input wire not_decodingIn,
        input wire notCINT2,
        input wire not_isXPT12,
        output wire enable_cint,
        output wire PA_Select_IOP_low,
        output wire not_decodingOut
    );

    wire _is_cint2 = not_decodingIn ~| notCINT2;

    wire _decodingOut = _is_cint2 ~| not_decodingIn;
    assign not_decodingOut = _decodingOut ~| _decodingOut;

    assign enable_cint = _is_cint2;

    //
    // decoder
    //

    wire _not_is_cint2 = _is_cint2 ~| _is_cint2;
    wire _is1100_1 = not_isXPT12 ~| _not_is_cint2;

    // 12

    assign PA_Select_IOP_low = _is1100_1;

endmodule
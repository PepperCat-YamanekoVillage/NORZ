// XPT = 0,1 -> XOR
// 5
module DECODER_CM1(
        input wire not_decodingIn,
        input wire notCM1,
        input wire XPT1,
        output wire PC_M1,
        output wire not_decodingOut
    );

    wire _is_cm1 = not_decodingIn ~| notCM1;
    wire _not_is_cm1 = _is_cm1 ~| _is_cm1;
    wire _is_xor = _not_is_cm1 ~| XPT1;

    wire _decodingOut = _is_xor ~| not_decodingIn;
    assign not_decodingOut = _decodingOut ~| _decodingOut;

    assign PC_M1 = _is_cm1;

endmodule
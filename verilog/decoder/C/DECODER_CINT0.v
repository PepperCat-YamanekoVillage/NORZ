// 13
module DECODER_CINT0(
        input wire not_decodingIn,
        input wire notCINT0,
        input wire OP1,
        input wire notXPT0,
        input wire XPT1,
        input wire notXPT2,
        output wire enable_cint,
        output wire P2_Reset_CINT,
        output wire P2_Set_CINT0_RST,
        output wire P2_Set_CINT0_CALL,
        output wire not_decodingOut
    );

    wire _is_cint0 = not_decodingIn ~| notCINT0;

    wire _decodingOut = _is_cint0 ~| not_decodingIn;
    assign not_decodingOut = _decodingOut ~| _decodingOut;

    assign enable_cint = _is_cint0;

    //
    // decoder
    //

    wire _not_is_cint0 = _is_cint0 ~| _is_cint0;

    wire _high = notXPT2 ~| XPT1;
    wire _not_high = _high ~| _high;
    wire _low = notXPT0 ~| _not_is_cint0;
    wire _not_low = _low ~| _low;
    wire _is101_1 = _not_high ~| _not_low;

    // 5

    assign P2_Reset_CINT = _is101_1;

    wire _not_is101_1 = _is101_1 ~| _is101_1;
    wire _notOP1 = OP1 ~| OP1;

    assign P2_Set_CINT0_RST = _notOP1 ~| _not_is101_1;
    assign P2_Set_CINT0_CALL = OP1 ~| _not_is101_1;


endmodule
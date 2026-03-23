// 32
module DECODER_X(
        input wire not_decodingIn,
        input wire notXIX,
        input wire notXIX4_0,
        input wire notXIX4_1,
        input wire notXIY,
        input wire notXIY4_0,
        input wire notXIY4_1,
        input wire notXOTR,
        input wire notXBIT,
        output wire not_enable_X1,
        output wire not_enable_XOTR,
        output wire not_enable_XBIT,
        output wire not_enable_XIX,
        output wire not_enable_XIX4_1,
        output wire not_enable_XIX4_0,
        output wire is_Y
    );

    wire _enable_XIX = not_decodingIn ~| notXIX;
    wire _decodingOut_XIX = _enable_XIX ~| not_decodingIn;
    wire _not_decodingOut_XIX = _decodingOut_XIX ~| _decodingOut_XIX;

    wire _enable_XIY = _not_decodingOut_XIX ~| notXIY;
    wire _decodingOut_XIY = _enable_XIY ~| _not_decodingOut_XIX;
    wire _not_decodingOut_XIY = _decodingOut_XIY ~| _decodingOut_XIY;

    wire _enable_XOTR = _not_decodingOut_XIY ~| notXOTR;
    assign not_enable_XOTR = _enable_XOTR ~| _enable_XOTR;
    wire _decodingOut_XOTR = _enable_XOTR ~| _not_decodingOut_XIY;
    wire _not_decodingOut_XOTR = _decodingOut_XOTR ~| _decodingOut_XOTR;

    wire _enable_XBIT = _not_decodingOut_XOTR ~| notXBIT;
    assign not_enable_XBIT = _enable_XBIT ~| _enable_XBIT;
    wire _decodingOut_XBIT = _enable_XBIT ~| _not_decodingOut_XOTR;
    wire _not_decodingOut_XBIT = _decodingOut_XBIT ~| _decodingOut_XBIT;

    wire _enable_XIX4_1 = _not_decodingOut_XBIT ~| notXIX4_1;
    wire _decodingOut_XIX4_1 = _enable_XIX4_1 ~| _not_decodingOut_XBIT;
    wire _not_decodingOut_XIX4_1 = _decodingOut_XIX4_1 ~| _decodingOut_XIX4_1;

    wire _enable_XIX4_0 = _not_decodingOut_XIX4_1 ~| notXIX4_0;
    wire _decodingOut_XIX4_0 = _enable_XIX4_0 ~| _not_decodingOut_XIX4_1;
    wire _not_decodingOut_XIX4_0 = _decodingOut_XIX4_0 ~| _decodingOut_XIX4_0;

    wire _enable_XIY4_1 = _not_decodingOut_XIX4_0 ~| notXIY4_1;
    wire _decodingOut_XIY4_1 = _enable_XIY4_1 ~| _not_decodingOut_XIX4_0;
    wire _not_decodingOut_XIY4_1 = _decodingOut_XIY4_1 ~| _decodingOut_XIY4_1;

    wire _enable_XIY4_0 = _not_decodingOut_XIY4_1 ~| notXIY4_0;
    wire _decodingOut_XIY4_0 = _enable_XIY4_0 ~| _not_decodingOut_XIY4_1;
    assign not_enable_X1 = _decodingOut_XIY4_0 ~| _decodingOut_XIY4_0;

    assign not_enable_XIX = _enable_XIX ~| _enable_XIY;
    assign not_enable_XIX4_1 = _enable_XIX4_1 ~| _enable_XIY4_1;
    assign not_enable_XIX4_0 = _enable_XIX4_0 ~| _enable_XIY4_0;

    assign is_Y = ~(_enable_XIX | _enable_XIX4_1 | _enable_XIX4_0); // 3

endmodule
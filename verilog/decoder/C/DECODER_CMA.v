// DECODER_CMRと同じ
// XPT = 0,1,2up -> XOR
// 6
module DECODER_CMA(
        input wire Clk,
        input wire not_decodingIn,
        input wire notCMA,
        input wire notXPT1,
        output wire PC_MA,
        output wire not_decodingOut
    );

    wire _is_cma = not_decodingIn ~| notCMA;
    wire _not_is_cma = _is_cma ~| _is_cma;

    wire _2d = Clk ~| notXPT1;

    wire _is_xor = _not_is_cma ~| _2d;

    wire _decodingOut = _is_xor ~| not_decodingIn;
    assign not_decodingOut = _decodingOut ~| _decodingOut;

    assign PC_MA = _is_cma;

endmodule
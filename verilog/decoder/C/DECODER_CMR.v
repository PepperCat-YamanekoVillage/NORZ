// XPT = 0,1,2up -> XOR
// 6
module DECODER_CMR(
        input wire Clk,
        input wire not_decodingIn,
        input wire notCMR,
        input wire notXPT1,
        output wire PC_MR,
        output wire PD_Source_Dtcs,
        output wire not_decodingOut
    );

    wire _is_cmr = not_decodingIn ~| notCMR;
    wire _not_is_cmr = _is_cmr ~| _is_cmr;

    wire _2d = Clk ~| notXPT1;

    wire _is_xor = _not_is_cmr ~| _2d;

    wire _decodingOut = _is_xor ~| not_decodingIn;
    assign not_decodingOut = _decodingOut ~| _decodingOut;

    assign PC_MR = _is_cmr;
    assign PD_Source_Dtcs = _is_cmr;

endmodule
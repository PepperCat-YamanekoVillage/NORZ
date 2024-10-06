// PA_Select_xxx はDirectInにすることでゲート数が削減できるのでそうするかも🦆
// 18(26)
module DECODER_CINT0_RST(
        input wire not_decodingIn,
        input wire notCINT0_RST,
        input wire [2:0] OP5_3,
        input wire [2:0] notOP5_3,
        input wire not_isXPT12,
        output wire enable_cint,
        output wire PA_Select_0x8_low,  // 001
        output wire PA_Select_0x10_low, // 010
        output wire PA_Select_0x18_low, // 011
        output wire PA_Select_0x20_low, // 100
        output wire PA_Select_0x28_low, // 101
        output wire PA_Select_0x30_low, // 110
        output wire PA_Select_0x38_low, // 111
        output wire not_decodingOut
    );

    wire _is_cint0_rst = not_decodingIn ~| notCINT0_RST;

    wire _decodingOut = _is_cint0_rst ~| not_decodingIn;
    assign not_decodingOut = _decodingOut ~| _decodingOut;

    assign enable_cint = _is_cint0_rst;

    //
    // decoder
    //

    wire _not_is_cint0_rst = _is_cint0_rst ~| _is_cint0_rst;
    wire _is1100_1 = not_isXPT12 ~| _not_is_cint0_rst;
    wire _not_is1100_1 = _is1100_1 ~| _is1100_1;

    // 12

    wire _00x;
    wire _01x;
    wire _10x;
    wire _11x;

    DECODER_2bit_decoder d_ddxx( // 8
        .notEnable(_not_is1100_1),
        .In(OP5_3[2:1]),
        .notIn(notOP5_3[2:1]),
        .out00(_00x),
        .out01(_01x),
        .out10(_10x),
        .out11(_11x)
    );

    wire _notOP3 = OP5_3[0] ~| OP5_3[0];

    wire _not00x = _00x ~| _00x;
    wire _not01x = _01x ~| _01x;
    wire _not10x = _10x ~| _10x;
    wire _not11x = _11x ~| _11x;

    wire _001 = _not00x ~| _notOP3;
    wire _010 = _not01x ~| OP5_3[0];
    wire _011 = _not01x ~| _notOP3;
    wire _100 = _not10x ~| OP5_3[0];
    wire _101 = _not10x ~| _notOP3;
    wire _110 = _not11x ~| OP5_3[0];
    wire _111 = _not11x ~| _notOP3;

    assign PA_Select_0x8_low = _001;
    assign PA_Select_0x10_low = _010;
    assign PA_Select_0x18_low = _011;
    assign PA_Select_0x20_low = _100;
    assign PA_Select_0x28_low = _101;
    assign PA_Select_0x30_low = _110;
    assign PA_Select_0x38_low = _111;

endmodule
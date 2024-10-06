// LD (HL),nn
// 3(10)
module DECODER_I_00000001(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        output wire [5:0] _decodedXPT,
        output wire PI_SelectAd_HL, // <
        output wire PI_SelectDt_OP, // >
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd // >
    );

    // wire [3:0] notXPT = ~XPT;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _4or5;

    DECODER_2bit_decoder d_00000ddx( // 7
        .notEnable(_not_enable),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out0x(_4or5),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out11(_decodedXPT[3])
    );

    // 3~5

    assign PI_SelectAd_HL = (_decodedXPT[3] | _4or5); // 2
    assign PI_SelectDt_OP = PI_SelectAd_HL;

    // 3

    assign PC_W0 = _decodedXPT[3];

    // 4

    assign PC_W1 = _decodedXPT[4];

    // 5

    assign PC_W2 = _decodedXPT[5];

    assign PR_Reset_XPT = _decodedXPT[5];
    assign P2_Set_CM1 = _decodedXPT[5];
    assign P2_Reset_ITABLE = _decodedXPT[5];
    assign Pa_Ophd = _decodedXPT[5];

endmodule

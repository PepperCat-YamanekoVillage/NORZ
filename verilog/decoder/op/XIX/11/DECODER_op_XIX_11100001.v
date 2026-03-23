// POP IX/IY
// 18(32)
module DECODER_op_XIX_11100001(
        input wire enable,
        input wire is_Y,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        output wire [9:0] _decodedXPT,
        output wire PI_SelectAd_SP,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Inc_SP,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd,
        output wire PR_InvertIn, // >
        output wire PR_Write_IX_low,
        output wire PR_Write_IY_low,
        output wire P2_Reset_XIX, // <
        output wire PR_Write_IX_high, // >
        output wire P2_Reset_XIY, // <
        output wire PR_Write_IY_high // >
    );

    // wire [4:0] notXPT = ~XPT;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _t01xx;
    wire _t10xx;

    DECODER_2bit_decoder t_ddxx( // 4
        .notEnable(_not_enable),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out01(_t01xx),
        .out1x(_t10xx)
    );

    wire _nott01xx = _t01xx ~| _t01xx;
    wire _nott10xx = _t10xx ~| _t10xx;

    DECODER_2bit_decoder t_01dd( // 8
        .notEnable(_nott01xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7])
    );

    DECODER_1bit_decoder t_0100d(
        .notEnable(_nott10xx),
        .In(XPT[0]),
        .notIn(notXPT[0]),
        .out0(_decodedXPT[8]),
        .out1(_decodedXPT[9])
    );

    // 4~9

    wire _t4_9 = (_t01xx | _t10xx); // 2

    assign PI_SelectAd_SP = _t4_9;

    // 4or7

    assign PC_R0 = (_decodedXPT[4] | _decodedXPT[7]); // 2

    // 5or8

    assign PC_R1 = (_decodedXPT[5] | _decodedXPT[8]); // 2

    // 6or9

    assign PC_R2 = (_decodedXPT[6] | _decodedXPT[9]); // 2

    assign PR_Inc_SP = PC_R2;

    // 6

    wire _nott6 = _decodedXPT[6] ~| _decodedXPT[6];

    wire _not_is_Y = is_Y ~| is_Y;

    assign PR_Write_IX_low = _nott6 ~| is_Y;

    assign PR_Write_IY_low = _nott6 ~| _not_is_Y;

    // 9 

    assign PR_Reset_XPT = _decodedXPT[9];
    assign P2_Set_CM1 = _decodedXPT[9];
    assign Pa_Ophd = _decodedXPT[9];
    assign PR_InvertIn = _decodedXPT[9];

    wire _nott9 = _decodedXPT[9] ~| _decodedXPT[9];

    assign P2_Reset_XIX = _nott9 ~| is_Y;
    assign PR_Write_IX_high = P2_Reset_XIX;
    assign P2_Reset_XIY = _nott9 ~| _not_is_Y;
    assign PR_Write_IY_high = P2_Reset_XIY;

endmodule
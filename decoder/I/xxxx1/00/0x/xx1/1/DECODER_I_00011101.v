// CALL nn
// 17(32)
module DECODER_I_00011101(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        output wire [9:0] _decodedXPT,
        output wire PR_Dec_SP,
        output wire PI_SelectDt_PC_high,
        output wire PI_SelectAd_SP,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_PC_low,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_ITABLE,
        output wire PA_Select_OPOPold_low,
        output wire PA_NOP,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low,
        output wire Pa_Ophd // >
    );

    // wire [3:0] notXPT = ~XPT;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _t00xx;
    wire _t01xx;
    wire _t10xx;

    DECODER_2bit_decoder t_ddxx( // 5
        .notEnable(_not_enable),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out00(_t00xx),
        .out01(_t01xx),
        .out1x(_t10xx)
    );

    wire _nott00xx = _t00xx ~| _t00xx;
    wire _nott01xx = _t01xx ~| _t01xx;
    wire _nott10xx = _t10xx ~| _t10xx;

    assign _decodedXPT[3] = _nott00xx ~| notXPT[0];

    DECODER_2bit_decoder t_01dd( // 8
        .notEnable(_nott01xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7])
    );

    DECODER_1bit_decoder t_100d(
        .notEnable(_nott10xx),
        .In(XPT[0]),
        .notIn(notXPT[0]),
        .out0(_decodedXPT[8]),
        .out1(_decodedXPT[9]),
    );

    // 3or6

    assign PR_Dec_SP = (_decodedXPT[3] | _decodedXPT[6]); // 2

    // 4~6

    assign PI_SelectDt_PC_high = _nott01xx ~| _decodedXPT[7];

    // 4~9

    assign PI_SelectAd_SP = _not_enable ~| _t00xx;

    // 4or7

    assign PC_W0 = (_decodedXPT[4] | _decodedXPT[7]); // 2

    // 5or8

    assign PC_W1 = (_decodedXPT[5] | _decodedXPT[8]); // 2

    // 6or9

    assign PC_W2 = (_decodedXPT[6] | _decodedXPT[9]); // 2

    // 7~9

    assign PI_SelectDt_PC_low = (_decodedXPT[7] | _t10xx); // 2

    // 9

    assign PR_Reset_XPT = _decodedXPT[9];
    assign P2_Set_CM1 = _decodedXPT[9];
    assign P2_Reset_ITABLE = _decodedXPT[9];
    assign PA_Select_OPOPold_low = _decodedXPT[9];
    assign PA_NOP = _decodedXPT[9];
    assign PR_Write_PC_high = _decodedXPT[9];
    assign PR_Write_PC_low = _decodedXPT[9];
    assign Pa_Ophd = _decodedXPT[9];
    
endmodule
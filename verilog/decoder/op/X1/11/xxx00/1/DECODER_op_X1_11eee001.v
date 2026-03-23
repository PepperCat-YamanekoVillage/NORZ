// RET / POP qq
// 15(49)
module DECODER_op_X1_11eee001(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
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
        output wire PR_Write_PC_low,
        output wire PR_Write_PC_high,
        output wire PR_Write_B,
        output wire PR_Write_C,
        output wire PR_Write_D,
        output wire PR_Write_E,
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PR_Write_A,
        output wire PR_Write_F
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

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

    DECODER_1bit_decoder t_100d(
        .notEnable(_nott10xx),
        .In(XPT[0]),
        .notIn(notXPT[0]),
        .out0(_decodedXPT[8]),
        .out1(_decodedXPT[9])
    );

    // 4~9

    assign PI_SelectAd_SP = (_t01xx | _t10xx); // 2

    // 4or7

    assign PC_R0 = (_decodedXPT[4] | _decodedXPT[7]); // 2

    // 5or8

    assign PC_R1 = (_decodedXPT[5] | _decodedXPT[8]); // 2

    // 6or9

    assign PC_R2 = (_decodedXPT[6] | _decodedXPT[9]); // 2

    assign PR_Inc_SP = PC_R2;

    // 6

    wire _nott6 = _decodedXPT[6] ~| _decodedXPT[6];

    wire _POP_t6;

    DECODER_1bit_decoder d_11xxd001_t6(
        .notEnable(_nott6),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_POP_t6),
        .out1(PR_Write_PC_low)
    );

    wire _not_POP_t6 = _POP_t6 ~| _POP_t6;

    DECODER_2bit_decoder d_11dd0001_t6( // 8
        .notEnable(_not_POP_t6),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(PR_Write_C),
        .out01(PR_Write_E),
        .out10(PR_Write_L),
        .out11(PR_Write_F)
    );

    // 9

    assign PR_Reset_XPT = _decodedXPT[9];
    assign P2_Set_CM1 = _decodedXPT[9];
    assign Pa_Ophd = _decodedXPT[9];
    assign PR_InvertIn = _decodedXPT[9];

    wire _nott9 = _decodedXPT[9] ~| _decodedXPT[9];

    wire _POP_t9;

    DECODER_1bit_decoder d_11xxd001_t9(
        .notEnable(_nott9),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_POP_t9),
        .out1(PR_Write_PC_high)
    );

    wire _not_POP_t9 = _POP_t9 ~| _POP_t9;

    DECODER_2bit_decoder d_11dd0001_t9( // 8
        .notEnable(_not_POP_t9),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(PR_Write_B),
        .out01(PR_Write_D),
        .out10(PR_Write_H),
        .out11(PR_Write_A)
    );

endmodule
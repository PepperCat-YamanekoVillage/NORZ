
// JR e / JR C/NC/Z/NZ,e / DJNZ e
// 30(49)
module DECODER_I_00111(
        input wire enable,
        input wire Flag_C,
        input wire Flag_Z,
        input wire notIsResultLow0,
        input wire OP7,
        input wire notOP7,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire [8:0] _decodedXPT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd, // >
        output wire PA_Select_PC_high, // <
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low,
        output wire PA_ADD, // >
        output wire PA_Select_OP_low,
        output wire PA_Select_0xffOP_low,
        output wire PA_Select_B_high, // <
        output wire PA_Select_0x1_low,
        output wire PA_SUB,
        output wire PR_Write_B,
        output wire PR_InvertIn // >
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;
    // wire notOP7 = ~OP7;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _00111x0x = _not_enable ~| ITABLE[1];
    wire _00111x1x = _not_enable ~| notITABLE[1];

    wire _not00111x0x = _00111x0x ~| _00111x0x;
    wire _0011110x = _not00111x0x ~| notITABLE[2];

    //
    // XPT
    //

    wire _t00xx;
    wire _t01xx;

    DECODER_2bit_decoder t_ddxx( // 5
        .notEnable(_not_enable),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out00(_t00xx),
        .out01(_t01xx),
        .out1x(_decodedXPT[8])
    );

    wire _nott00xx = _t00xx ~| _t00xx;

    DECODER_1bit_decoder t_001d(
        .notEnable(_nott00xx),
        .In(XPT[0]),
        .notIn(notXPT[0]),
        .out0(_decodedXPT[2]),
        .out1(_decodedXPT[3]),
    ); 

    wire _nott01xx = _t01xx ~| _t01xx;

    DECODER_2bit_decoder t_01dd( // 6
        .notEnable(_nott01xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out11(_decodedXPT[7])
    );

    //
    // Cancel
    //

    // JR C/NC/Z/NZ,e 2

    wire _not_decodedXPT2 = _decodedXPT[2] ~| _decodedXPT[2];
    wire _not_00111x1x = _00111x1x ~| _00111x1x;

    wire _00111x1x_2 = _not_00111x1x ~| _not_decodedXPT2;

    // DJNZ e 3

    wire _not_decodedXPT3 = _decodedXPT[3] ~| _decodedXPT[3];
    wire _not_0011110x = _0011110x ~| _0011110x;

    wire _0011110x_3 = _not_0011110x ~| _not_decodedXPT3;

    wire _c1;
    wire _cc;

    DECODER_mux c1(
        .S(ITABLE[2]),
        .notS(notITABLE[2]),
        .N(Flag_C),
        .P(Flag_Z),
        .Out(_c1)
    );

    DECODER_mux cc(
        .S(ITABLE[1]),
        .notS(notITABLE[1]),
        .N(notIsResultLow0),
        .P(_c1),
        .Out(_cc)
    );

    // xor

    wire _notcc = _cc ~| _cc;
    wire _xor_p = _cc ~| ITABLE[0];
    wire _xor_n = _notcc ~| notITABLE[0];
    wire _xor = _xor_p ~| _xor_n;

    wire _notCancel = _00111x1x_2 ~| _0011110x_3;
    wire _isCC = _notCancel ~| _xor;

    // DJNZ e 8

    wire _not_decodedXPT8 = _decodedXPT[8] ~| _decodedXPT[8];

    wire _0011110x_8 = _not_0011110x ~| _not_decodedXPT8;

    // not DJNZ e 7

    wire _not_decodedXPT7 = _decodedXPT[7] ~| _decodedXPT[7];

    wire _un0011110x_7 = _0011110x ~| _not_decodedXPT7;

    wire _fin_reset = (_0011110x_8 | _un0011110x_7); // 2

    assign PR_Reset_XPT = (_isCC | _fin_reset); // 2
    assign P2_Set_CM1 = PR_Reset_XPT;
    assign P2_Reset_ITABLE = PR_Reset_XPT;
    assign Pa_Ophd = PR_Reset_XPT;

    // 4

    assign PA_Select_PC_high = _decodedXPT[4];
    assign PR_Write_PC_high = _decodedXPT[4];
    assign PR_Write_PC_low = _decodedXPT[4];
    assign PA_ADD = _decodedXPT[4];

    wire _not_decodedXPT4 = _decodedXPT[4] ~| _decodedXPT[4];

    assign PA_Select_OP_low = _not_decodedXPT4 ~| OP7;
    assign PA_Select_0xffOP_low = _not_decodedXPT4 ~| notOP7;

    // DJNZ e 3 _0011110x_3

    assign PA_Select_B_high = _0011110x_3;
    assign PA_Select_0x1_low = _0011110x_3;
    assign PA_SUB = _0011110x_3;
    assign PR_Write_B = _0011110x_3;
    assign PR_InvertIn = _0011110x_3;

endmodule
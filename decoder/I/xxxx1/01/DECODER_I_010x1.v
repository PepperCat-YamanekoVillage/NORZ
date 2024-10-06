// JP cc,nn
// 10(39)
module DECODER_I_010x1(
        input wire enable,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        input wire Flag_Z,  // 00 0->is0 1->is1
        input wire Flag_C,  // 01
        input wire Flag_PV, // 10
        input wire Flag_S,  // 11
        output wire P2_Set_IJPccnn_0_1,
        output wire P2_Set_IJPccnn_1_1,
        output wire P2_Set_IJPccnn_2_1,
        output wire P2_Set_IJPccnn_3_1,
        output wire P2_Set_IJPccnn_4_1,
        output wire P2_Set_IJPccnn_5_1,
        output wire P2_Set_IJPccnn_6_1,
        output wire P2_Set_IJPccnn_7_1,
        output wire P2_Set_CMA,
        output wire PR_Reset_XPT,
        output wire PA_Select_OP_high, // <
        output wire PA_NOP,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low,
        output wire PR_InvertIn, // >
        output wire P2_Set_CM1, // <
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd // >
    );

    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _0;
    wire _1;

    DECODER_1bit_decoder d_010d1xxx(
        .notEnable(_not_enable),
        .In(ITABLE[4]),
        .notIn(notITABLE[4]),
        .out0(_0),
        .out1(_1),
    );

    wire _not0 = _0 ~| _0;

    wire _010010xx;
    wire _010011xx;

    DECODER_1bit_decoder d_01001dxx(
        .notEnable(_not0),
        .In(ITABLE[2]),
        .notIn(notITABLE[2]),
        .out0(_010010xx),
        .out1(_010011xx),
    );

    wire _not010010xx = _010010xx ~| _010010xx;
    wire _not010011xx = _010011xx ~| _010011xx;

    DECODER_2bit_decoder d_010010dd( // 8
        .notEnable(_not010010xx),
        .In(ITABLE[1:0]),
        .notIn(notITABLE[1:0]),
        .out00(P2_Set_IJPccnn_0_1),
        .out01(P2_Set_IJPccnn_1_1),
        .out10(P2_Set_IJPccnn_2_1),
        .out11(P2_Set_IJPccnn_3_1)
    );

    DECODER_2bit_decoder d_010011dd( // 8
        .notEnable(_not010011xx),
        .In(ITABLE[1:0]),
        .notIn(notITABLE[1:0]),
        .out00(P2_Set_IJPccnn_4_1),
        .out01(P2_Set_IJPccnn_5_1),
        .out10(P2_Set_IJPccnn_6_1),
        .out11(P2_Set_IJPccnn_7_1)
    );

    wire _c1;
    wire _c2;
    wire _cc;

    DECODER_mux c1(
        .S(ITABLE[1]),
        .notS(notITABLE[1]),
        .N(Flag_Z),
        .P(Flag_C),
        .Out(_c1)
    );

    DECODER_mux c2(
        .S(ITABLE[1]),
        .notS(notITABLE[1]),
        .N(Flag_PV),
        .P(Flag_S),
        .Out(_c2)
    );

    DECODER_mux cc(
        .S(ITABLE[2]),
        .notS(notITABLE[2]),
        .N(_c1),
        .P(_c2),
        .Out(_cc)
    );

    // xor

    wire _notcc = _cc ~| _cc;
    wire _xor_p = _cc ~| ITABLE[0];
    wire _xor_n = _notcc ~| notITABLE[0];
    wire _xor = _xor_p ~| _xor_n;

    wire _not1 = _1 ~| _1;
    wire _isCC = _not1 ~| _xor;

    //
    // _0
    //

    assign P2_Set_CMA = _0;

    // _0or_1

    assign PR_Reset_XPT = enable;

    //
    // _1
    //

    assign PA_Select_OP_high = _isCC;
    assign PA_NOP = _isCC;
    assign PR_Write_PC_high = _isCC;
    assign PR_Write_PC_low = _isCC;
    assign PR_InvertIn = _isCC;

    assign P2_Set_CM1 = _1;
    assign P2_Reset_ITABLE = _1;
    assign Pa_Ophd = _1;

endmodule
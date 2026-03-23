// RET cc
// 20(46)
module DECODER_op_X1_11xxx000(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        input wire Flag_Z,
        input wire Flag_C,
        input wire Flag_PV,
        input wire Flag_S,
        output wire [10:0] _decodedXPT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd, // >
        output wire PI_SelectAd_SP,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Inc_SP,
        output wire PR_Write_PC_low,
        output wire PR_Write_PC_high, // <
        output wire PR_InvertIn // >
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

    DECODER_2bit_decoder t_10dd( // 5
        .notEnable(_nott10xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[8]),
        .out01(_decodedXPT[9]),
        .out1x(_decodedXPT[10])
    );

    //
    // decoder
    //

    wire _Flag_ZC;

    DECODER_mux m0d(
        .S(Source[4]),
        .notS(notSource[4]),
        .N(Flag_Z),
        .P(Flag_C),
        .Out(_Flag_ZC)
    );

    wire _Flag_PVS;

    DECODER_mux m1d(
        .S(Source[4]),
        .notS(notSource[4]),
        .N(Flag_PV),
        .P(Flag_S),
        .Out(_Flag_PVS)
    );

    wire _Flag;

    DECODER_mux mdx(
        .S(Source[5]),
        .notS(notSource[5]),
        .N(_Flag_ZC),
        .P(_Flag_PVS),
        .Out(_Flag)
    );

    wire _nott4 = _decodedXPT[4] ~| _decodedXPT[4];

    wire _notFlag = _Flag ~| _Flag;

    wire _cc0_f = _notFlag ~| Source[3];
    wire _cc1_f = _Flag ~| notSource[3];
    wire _not_cc_f = _cc0_f ~| _cc1_f;

    wire _cancel = _nott4 ~| _not_cc_f;

    // cancel or 10

    assign PR_Reset_XPT = (_cancel | _decodedXPT[10]); // 2
    assign P2_Set_CM1 = PR_Reset_XPT;
    assign Pa_Ophd = PR_Reset_XPT;

    // 5~10

    wire _5_8 = _nott01xx ~| _decodedXPT[4];

    assign PI_SelectAd_SP = (_5_8 | _t10xx); // 2

    // 5or8

    assign PC_R0 = (_decodedXPT[5] | _decodedXPT[8]); // 2

    // 6or9

    assign PC_R1 = (_decodedXPT[6] | _decodedXPT[9]); // 2

    // 7or10

    assign PC_R2 = (_decodedXPT[7] | _decodedXPT[10]); // 2

    assign PR_Inc_SP = PC_R2;

    // 7

    assign PR_Write_PC_low = _decodedXPT[7];

    // 10

    assign PR_Write_PC_high = _decodedXPT[10];
    assign PR_InvertIn = _decodedXPT[10];

endmodule
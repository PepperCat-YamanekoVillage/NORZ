// CALL cc,nn
// 30(76)
module DECODER_I_100x1(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        input wire Flag_Z,
        input wire Flag_C,
        input wire Flag_PV,
        input wire Flag_S,
        output wire [9:0] _decodedXPT,
        output wire P2_Set_ICALLccnn_0_1,
        output wire P2_Set_ICALLccnn_1_1,
        output wire P2_Set_ICALLccnn_2_1,
        output wire P2_Set_ICALLccnn_3_1,
        output wire P2_Set_ICALLccnn_4_1,
        output wire P2_Set_ICALLccnn_5_1,
        output wire P2_Set_ICALLccnn_6_1,
        output wire P2_Set_ICALLccnn_7_1,
        output wire P2_Set_CMR,
        output wire PR_Dec_SP,
        output wire PI_SelectDt_PC_high,
        output wire PI_SelectAd_SP,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_PC_low,
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1, // <
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd, // >
        output wire PA_Select_OPOPold_low, // <
        output wire PA_NOP,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low // >
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _0;
    wire _1;

    DECODER_1bit_decoder d_100d1xxx(
        .notEnable(_not_enable),
        .In(ITABLE[4]),
        .notIn(notITABLE[4]),
        .out0(_0),
        .out1(_1),
    );

    wire _not0 = _0 ~| _0;

    wire _0_0;
    wire _0_1;

    DECODER_1bit_decoder d_10001dxx(
        .notEnable(_not0),
        .In(ITABLE[2]),
        .notIn(notITABLE[2]),
        .out0(_0_0),
        .out1(_0_1),
    );

    wire _not0_0 = _0_0 ~| _0_0;
    wire _not0_1 = _0_1 ~| _0_1;


    DECODER_2bit_decoder d_100010dd( // 8
        .notEnable(_not0_0),
        .In(ITABLE[1:0]),
        .notIn(notITABLE[1:0]),
        .out00(P2_Set_ICALLccnn_0_1),
        .out01(P2_Set_ICALLccnn_1_1),
        .out10(P2_Set_ICALLccnn_2_1),
        .out11(P2_Set_ICALLccnn_3_1)
    );

    DECODER_2bit_decoder d_100011dd( // 8
        .notEnable(_not0_1),
        .In(ITABLE[1:0]),
        .notIn(notITABLE[1:0]),
        .out00(P2_Set_ICALLccnn_4_1),
        .out01(P2_Set_ICALLccnn_5_1),
        .out10(P2_Set_ICALLccnn_6_1),
        .out11(P2_Set_ICALLccnn_7_1)
    );

    //
    // XPT
    //

    wire _not1 = _1 ~| _1;

    wire _t00xx;
    wire _t01xx;
    wire _t10xx;

    DECODER_2bit_decoder t_ddxx( // 5
        .notEnable(_not1),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out00(_t00xx),
        .out01(_t01xx),
        .out1x(_t10xx)
    );

    wire _nott00xx = _t00xx ~| _t00xx;
    wire _nott01xx = _t01xx ~| _t01xx;
    wire _nott10xx = _t10xx ~| _t10xx;


    DECODER_1bit_decoder t_001d(
        .notEnable(_nott00xx),
        .In(XPT[0]),
        .notIn(notXPT[0]),
        .out0(_decodedXPT[2]),
        .out1(_decodedXPT[3]),
    );

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
    wire _xor_p = _notcc ~| ITABLE[0];
    wire _xor_n = _cc ~| notITABLE[0];
    wire _xor = _xor_p ~| _xor_n;

    wire _notdecodedXPT2 = _decodedXPT[2] ~| _decodedXPT[2];
    wire _isCC = _notdecodedXPT2 ~| _xor;


    //
    // _0
    //

    assign P2_Set_CMR = _0;

    //
    // _1
    //

    // 3or6

    assign PR_Dec_SP = (_decodedXPT[3] | _decodedXPT[6]); // 2

    // 4~6

    assign PI_SelectDt_PC_high = _nott01xx ~| _decodedXPT[7];

    // 4~9

    assign PI_SelectAd_SP = _not1 ~| _t00xx;

    // 4or7

    assign PC_W0 = (_decodedXPT[4] | _decodedXPT[7]); // 2

    // 5or8

    assign PC_W1 = (_decodedXPT[5] | _decodedXPT[8]); // 2

    // 6or9

    assign PC_W2 = (_decodedXPT[6] | _decodedXPT[9]); // 2

    // 7~9

    assign PI_SelectDt_PC_low = (_decodedXPT[7] | _t10xx); // 2

    // 9

    assign PA_Select_OPOPold_low = _decodedXPT[9];
    assign PA_NOP = _decodedXPT[9];
    assign PR_Write_PC_high = _decodedXPT[9];
    assign PR_Write_PC_low = _decodedXPT[9];

    // 2_cc or 9

    assign P2_Set_CM1 = (_isCC | _decodedXPT[9]); // 2
    assign P2_Reset_ITABLE = P2_Set_CM1;
    assign Pa_Ophd = P2_Set_CM1;

    // _0 or _1{2_cc or 9}

    assign PR_Reset_XPT = (P2_Set_CM1 | _0); // 2

endmodule
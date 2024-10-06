// IN A,(n) / OUT (n),A
// 12(27)
module DECODER_I_0010100(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire [6:0] _decodedXPT,
        output wire PC_I0,
        output wire PC_I1,
        output wire PC_I2,
        output wire PC_I3,
        output wire PC_O0,
        output wire PC_O1,
        output wire PC_O2,
        output wire PC_O3,
        output wire PR_Write_A, // <
        output wire PR_InvertIn, // >
        output wire PI_SelectAd_AOP,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd, // >
        output wire PI_SelectDt_A
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _t0xx;
    wire _t1xx;

    DECODER_1bit_decoder t_dxx(
        .notEnable(_not_enable),
        .In(XPT[2]),
        .notIn(notXPT[2]),
        .out0(_t0xx),
        .out1(_t1xx),
    );

    wire _nott0xx = _t0xx ~| _t0xx;

    assign _decodedXPT[3] = _nott0xx ~| notXPT[0];

    wire _nott1xx = _t1xx ~| _t1xx;

    DECODER_2bit_decoder d_ddxx0xxx( // 5
        .notEnable(_nott1xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out1x(_decodedXPT[6])
    );

    // decoder

    wire _notdecodedXPT3 = _decodedXPT[3] ~| _decodedXPT[3];
    wire _notdecodedXPT4 = _decodedXPT[4] ~| _decodedXPT[4];
    wire _notdecodedXPT5 = _decodedXPT[5] ~| _decodedXPT[5];
    wire _notdecodedXPT6 = _decodedXPT[6] ~| _decodedXPT[6];

    DECODER_1bit_decoder d_0010100d_3(
        .notEnable(_notdecodedXPT3),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(PC_I0),
        .out1(PC_O0),
    );

    DECODER_1bit_decoder d_0010100d_4(
        .notEnable(_notdecodedXPT4),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(PC_I1),
        .out1(PC_O1),
    );

    DECODER_1bit_decoder d_0010100d_5(
        .notEnable(_notdecodedXPT5),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(PC_I2),
        .out1(PC_O2),
    );

    DECODER_1bit_decoder d_0010100d_6(
        .notEnable(_notdecodedXPT6),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(PC_I3),
        .out1(PC_O3),
    );

    // 3~6

    assign PI_SelectAd_AOP = (_decodedXPT[3] | _t1xx); // 2

    // 6

    assign PR_Reset_XPT = _decodedXPT[6];
    assign P2_Set_CM1 = _decodedXPT[6];
    assign P2_Reset_ITABLE = _decodedXPT[6];
    assign Pa_Ophd = _decodedXPT[6];

    // _0_6

    assign PR_Write_A = PC_I3;
    assign PR_InvertIn = PC_I3;

    // _1_3~6

    wire _not3_6 = PI_SelectAd_AOP ~| PI_SelectAd_AOP;
    assign PI_SelectDt_A = _not3_6 ~| notITABLE[0];



endmodule
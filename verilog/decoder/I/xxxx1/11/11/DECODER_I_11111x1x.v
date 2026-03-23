// LD (IX+d)/(IY+d),n
// 9(24)
module DECODER_I_11111x1x(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire [8:0] _decodedXPT,
        output wire P2_Set_ILDlIXtdln_1,
        output wire P2_Set_ILDlIYtdln_1,
        output wire P2_Set_CMR,
        output wire PR_Reset_XPT,
        output wire PA_Select_IX_high,
        output wire PA_Select_IY_high,
        output wire PA_Select_OPold_low, // <
        output wire PA_ADD,
        output wire PR_Write_Dt,
        output wire PR_Write_Dtex, // >
        output wire PI_SelectAd_DtexDt, // <
        output wire PI_SelectDt_OP, // >
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire P2_Set_CM1, // <
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd // >
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _0;
    wire _1;

    DECODER_1bit_decoder d_11111x1d(
        .notEnable(_not_enable),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(_0),
        .out1(_1)
    );

    //
    // XPT
    //

    wire _not1 = _1 ~| _1;

    wire _t0xx;
    wire _t1xx;

    DECODER_1bit_decoder t_dxx(
        .notEnable(_not1),
        .In(XPT[2]),
        .notIn(notXPT[2]),
        .out0(_t0xx),
        .out1(_t1xx)
    );

    wire _nott0xx = _t0xx ~| _t0xx;
    wire _nott1xx = _t1xx ~| _t1xx;

    assign _decodedXPT[3] = _nott0xx ~| notXPT[0];

    DECODER_2bit_decoder t_1dd( // 7
        .notEnable(_nott1xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7])
    );

    //
    // _0
    //

    wire _not0 = _0 ~| _0;

    DECODER_1bit_decoder d_11111d10(
        .notEnable(_not0),
        .In(ITABLE[2]),
        .notIn(notITABLE[2]),
        .out0(P2_Set_ILDlIXtdln_1),
        .out1(P2_Set_ILDlIYtdln_1)
    );

    assign P2_Set_CMR = _0;

    assign PR_Reset_XPT = (_0 | _decodedXPT[7]); // 2

    //
    // _1
    //

    // 3

    wire _notdecodedXPT3 = _decodedXPT[3] ~| _decodedXPT[3];

    DECODER_1bit_decoder d_11111d11(
        .notEnable(_notdecodedXPT3),
        .In(ITABLE[2]),
        .notIn(notITABLE[2]),
        .out0(PA_Select_IX_high),
        .out1(PA_Select_IY_high)
    );

    assign PA_Select_OPold_low = _decodedXPT[3];
    assign PA_ADD = _decodedXPT[3];
    assign PR_Write_Dt = _decodedXPT[3];
    assign PR_Write_Dtex = _decodedXPT[3];

    // 4~7

    assign PI_SelectAd_DtexDt = _t1xx;
    assign PI_SelectDt_OP = _t1xx;

    // 5

    assign PC_W0 = _decodedXPT[5];

    // 6

    assign PC_W1 = _decodedXPT[6];

    // 7

    assign PC_W2 = _decodedXPT[7];

    assign P2_Set_CM1 = _decodedXPT[7];
    assign P2_Reset_ITABLE = _decodedXPT[7];
    assign Pa_Ophd = _decodedXPT[7];

endmodule
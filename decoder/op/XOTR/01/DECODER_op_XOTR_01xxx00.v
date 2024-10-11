// IN r,(C) / OUT (C),r
// 16(62)
module DECODER_op_XOTR_01xxx00(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [7:0] _decodedXPT,
        output wire PI_SelectAd_BC,
        output wire PI_SelectDt_B,
        output wire PI_SelectDt_C,
        output wire PI_SelectDt_D,
        output wire PI_SelectDt_E,
        output wire PI_SelectDt_H,
        output wire PI_SelectDt_L,
        output wire PI_SelectDt_A,
        output wire PC_I0,
        output wire PC_I1,
        output wire PC_I2,
        output wire PC_I3,
        output wire PC_O0,
        output wire PC_O1,
        output wire PC_O2,
        output wire PC_O3,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_XOTR,
        output wire Pa_Ophd, // >
        output wire PF_Write_Z, // <
        output wire PF_Write_PV,
        output wire PF_Write_S,
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Select_Z_bit24,
        output wire PF_Select_PV_bit27,
        output wire PF_Select_S_bit7,
        output wire PF_Select_N_bit16,
        output wire PF_Select_H_bit16, // >
        output wire PR_Write_B,
        output wire PR_Write_C,
        output wire PR_Write_D,
        output wire PR_Write_E,
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PR_Write_A,
        output wire PR_InvertIn
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _t1xx = _not_enable ~| notXPT[2];

    wire _nott1xx = _t1xx ~| _t1xx;

    DECODER_2bit_decoder t_1dd( // 8
        .notEnable(_nott1xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7])
    );

    //
    // decoder
    //

    wire _isOUTt4_7 = _nott1xx ~| notSource[0];

    wire _not_isOUTt4_7 = _isOUTt4_7 ~| _isOUTt4_7;

    wire _010xx001_t4_7;
    wire _011xx001_t4_7;

    DECODER_1bit_decoder d_01dxx001(
        .notEnable(_not_isOUTt4_7),
        .In(Source[5]),
        .notIn(notSource[5]),
        .out0(_010xx001_t4_7),
        .out1(_011xx001_t4_7)
    );

    wire _not010xx001_t4_7 = _010xx001_t4_7 ~| _010xx001_t4_7;
    wire _not011xx001_t4_7 = _011xx001_t4_7 ~| _011xx001_t4_7;

    DECODER_2bit_decoder d_010dd001( // 8
        .notEnable(_not010xx001_t4_7),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out00(PI_SelectDt_B),
        .out01(PI_SelectDt_C),
        .out10(PI_SelectDt_D),
        .out11(PI_SelectDt_E)
    );

    DECODER_2bit_decoder d_011dd001( // 5
        .notEnable(_not011xx001_t4_7),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out00(PI_SelectDt_H),
        .out01(PI_SelectDt_L),
        .out1x(PI_SelectDt_A)
    );

    wire _notdecodedXPT4 = _decodedXPT[4] ~| _decodedXPT[4];
    wire _notdecodedXPT5 = _decodedXPT[5] ~| _decodedXPT[5];
    wire _notdecodedXPT6 = _decodedXPT[6] ~| _decodedXPT[6];
    wire _notdecodedXPT7 = _decodedXPT[7] ~| _decodedXPT[7];

    wire _01xxx000_t4;
    wire _01xxx001_t4;
    wire _01xxx000_t5;
    wire _01xxx001_t5;
    wire _01xxx000_t6;
    wire _01xxx001_t6;
    wire _01xxx000_t7;
    wire _01xxx001_t7;

    DECODER_1bit_decoder d_01xxx00d_t4(
        .notEnable(_notdecodedXPT4),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_01xxx000_t4),
        .out1(_01xxx001_t4)
    );

    DECODER_1bit_decoder d_01xxx00d_t5(
        .notEnable(_notdecodedXPT5),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_01xxx000_t5),
        .out1(_01xxx001_t5)
    );

    DECODER_1bit_decoder d_01xxx00d_t6(
        .notEnable(_notdecodedXPT6),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_01xxx000_t6),
        .out1(_01xxx001_t6)
    );

    DECODER_1bit_decoder d_01xxx00d_t7(
        .notEnable(_notdecodedXPT7),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_01xxx000_t7),
        .out1(_01xxx001_t7)
    );

    wire _not01xxx000_t7 = _01xxx000_t7 ~| _01xxx000_t7;

    wire _01xx0000_t7;
    wire _01xx1000_t7;

    DECODER_1bit_decoder d_01xxd000_t7(
        .notEnable(_not01xxx000_t7),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_01xx0000_t7),
        .out1(_01xx1000_t7)
    );

    wire _not01xx0000_t7 = _01xx0000_t7 ~| _01xx0000_t7;
    wire _not01xx1000_t7 = _01xx1000_t7 ~| _01xx1000_t7;

    DECODER_2bit_decoder d_01dd0000_t7( // 5
        .notEnable(_not01xx0000_t7),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(PR_Write_B),
        .out01(PR_Write_D),
        .out1x(PR_Write_H)
    );

    DECODER_2bit_decoder d_01dd1000_t7( // 8
        .notEnable(_not01xx1000_t7),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(PR_Write_C),
        .out01(PR_Write_E),
        .out10(PR_Write_L),
        .out11(PR_Write_A)
    );

    // 4~7

    assign PI_SelectAd_BC = _t1xx;

    // 4

    assign PC_I0 = _01xxx000_t4;
    assign PC_O0 = _01xxx001_t4;

    // 5

    assign PC_I1 = _01xxx000_t5;
    assign PC_O1 = _01xxx001_t5;

    // 6

    assign PC_I2 = _01xxx000_t6;
    assign PC_O2 = _01xxx001_t6;

    // 7

    assign PR_Reset_XPT = _decodedXPT[7];
    assign P2_Set_CM1 = _decodedXPT[7];
    assign P2_Reset_XOTR = _decodedXPT[7];
    assign Pa_Ophd = _decodedXPT[7];

    assign PC_I3 = _01xxx000_t7;
    assign PC_O3 = _01xxx001_t7;

    assign PF_Write_Z = _01xxx000_t7;
    assign PF_Write_PV = _01xxx000_t7;
    assign PF_Write_S = _01xxx000_t7;
    assign PF_Write_N = _01xxx000_t7;
    assign PF_Write_H = _01xxx000_t7;
    assign PF_Select_Z_bit24 = _01xxx000_t7;
    assign PF_Select_PV_bit27 = _01xxx000_t7;
    assign PF_Select_S_bit7 = _01xxx000_t7;
    assign PF_Select_N_bit16 = _01xxx000_t7;
    assign PF_Select_H_bit16 = _01xxx000_t7;

    assign PR_InvertIn = (_01xx0000_t7 | PR_Write_A); // 2

endmodule
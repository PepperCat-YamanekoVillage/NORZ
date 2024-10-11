// CPI/CPIR/CPD/CPDR
// 11(29)
module DECODER_op_XOTR_101xx001(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [11:0] _decodedXPT,
        output wire PA_ADD,
        output wire PA_SUB,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PI_SelectAd_HL,
        output wire PR_Write_Dt,
        output wire PA_Select_A_high, // <
        output wire PA_Select_Dt_low,
        output wire PF_Write_Z,
        output wire PF_Write_S,
        output wire PF_Write_H,
        output wire PF_Select_Z_bit19,
        output wire PF_Select_S_bit7,
        output wire PF_Select_H_bit22, // >
        output wire PA_Select_BC_high, //<
        output wire PR_Write_B,
        output wire PR_Write_C,
        output wire PF_Write_PV,
        output wire PF_Select_PV_bit20, // >
        output wire PA_Select_0x1_low,
        output wire PA_Select_HL_high, // <
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PF_Write_N,
        output wire PF_Select_N_bit17 // >
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _t01xx;
    wire _t10xx;

    DECODER_2bit_decoder t_ddxx( // 6 R系はT16なので1x系にしないこと
        .notEnable(_not_enable),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out01(_t01xx),
        .out10(_t10xx)
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

    wire _t100x = _nott10xx ~| XPT[1];
    wire _nott100x = _t100x ~| _t100x;

    DECODER_1bit_decoder t_100d(
        .notEnable(_nott100x),
        .In(XPT[0]),
        .notIn(notXPT[0]),
        .out0(_decodedXPT[8]),
        .out1(_decodedXPT[9])
    );

    // 4

    assign PC_R0 = _decodedXPT[4];

    // 5

    assign PC_R1 = _decodedXPT[5];

    // 6

    assign PC_R2 = _decodedXPT[6];

    assign PR_Write_Dt = _decodedXPT[6];

    // 4~6

    wire _t4_6 = _nott01xx ~| _decodedXPT[7];
    assign PI_SelectAd_HL = _t4_6;

    // 7

    assign PA_Select_A_high = _decodedXPT[7];
    assign PA_Select_Dt_low = _decodedXPT[7];
    assign PF_Write_Z = _decodedXPT[7];
    assign PF_Write_S = _decodedXPT[7];
    assign PF_Write_H = _decodedXPT[7];
    assign PF_Select_Z_bit19 = _decodedXPT[7];
    assign PF_Select_S_bit7 = _decodedXPT[7];
    assign PF_Select_H_bit22 = _decodedXPT[7];

    // sub

    wire _PA_SUB;

    wire _notdecodedXPT9 = _decodedXPT[9] ~| _decodedXPT[9];

    DECODER_1bit_decoder d_101xd001(
        .notEnable(_notdecodedXPT9),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(PA_ADD),
        .out1(_PA_SUB)
    );

    assign PA_SUB = (_PA_SUB | _decodedXPT[7] | _decodedXPT[8]); // 4

    // 8

    assign PA_Select_BC_high = _decodedXPT[8];
    assign PR_Write_B = _decodedXPT[8];
    assign PR_Write_C = _decodedXPT[8];
    assign PF_Write_PV = _decodedXPT[8];
    assign PF_Select_PV_bit20 = _decodedXPT[8];

    // 8or9

    assign PA_Select_0x1_low = _t100x;

    // 9

    assign PA_Select_HL_high = _decodedXPT[9];
    assign PR_Write_H = _decodedXPT[9];
    assign PR_Write_L = _decodedXPT[9];
    assign PF_Write_N = _decodedXPT[9];
    assign PF_Select_N_bit17 = _decodedXPT[9];

endmodule
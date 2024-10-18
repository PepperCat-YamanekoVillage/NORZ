// OUTI/OTIR/OUTD/OTDR
// 10(34)
module DECODER_op_XOTR_101xx011(
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
        output wire PI_SelectAd_BC, // <
        output wire PI_SelectDt_Dt, // >
        output wire PA_Select_0x1_low,
        output wire PA_Select_B_high,
        output wire PC_O0,
        output wire PC_O1,
        output wire PC_O2,
        output wire PC_O3,
        output wire PF_Write_Z, // <
        output wire PF_Write_N,
        output wire PF_Select_Z_bit24,
        output wire PF_Select_N_bit17, // >
        output wire PA_Select_HL_high, // <
        output wire PR_Write_H,
        output wire PR_Write_L, // >
        output wire PR_Write_B, // <
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

    wire _t8or9;

    DECODER_2bit_decoder t_10dd( // 8
        .notEnable(_nott10xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[8]),
        .out01(_decodedXPT[9]),
        .out10(_decodedXPT[10]),
        .out11(_decodedXPT[11]),
        .out0x(_t8or9)
    );

    // 5

    assign PC_R0 = _decodedXPT[5];

    // 6

    assign PC_R1 = _decodedXPT[6];

    // 7

    assign PC_R2 = _decodedXPT[7];

    assign PR_Write_Dt = _decodedXPT[7];

    // 5~7

    wire _t5_7 = _nott01xx ~| _decodedXPT[4];
    assign PI_SelectAd_HL = _t5_7;

    // 8~11

    assign PI_SelectAd_BC = _t10xx;
    assign PI_SelectDt_Dt = _t10xx;

    // 8or9or11

    assign PA_Select_0x1_low = _nott10xx ~| _decodedXPT[10];

    // 8or11

    wire _t8or11 = (_decodedXPT[8] | _decodedXPT[11]); // 2
    assign PA_Select_B_high = _t8or11;

    // 8

    assign PC_O0 = _decodedXPT[8];

    assign PF_Write_Z = _decodedXPT[8];
    assign PF_Write_N = _decodedXPT[8];
    assign PF_Select_Z_bit24 = _decodedXPT[8];
    assign PF_Select_N_bit17 = _decodedXPT[8];

    // 9

    assign PC_O1 = _decodedXPT[9];

    assign PA_Select_HL_high = _decodedXPT[9];
    assign PR_Write_H = _decodedXPT[9];
    assign PR_Write_L = _decodedXPT[9];

    wire _nott9 = _decodedXPT[9] ~| _decodedXPT[9];

    wire _PA_SUB;

    DECODER_1bit_decoder d_101xd011(
        .notEnable(_nott9),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(PA_ADD),
        .out1(_PA_SUB)
    );

    assign PA_SUB = (_PA_SUB | _t8or11); // 2

     // 10

    assign PC_O2 = _decodedXPT[10];

     // 11

    assign PC_O3 = _decodedXPT[11];

    assign PR_Write_B = _decodedXPT[11];
    assign PR_InvertIn = _decodedXPT[11];

endmodule
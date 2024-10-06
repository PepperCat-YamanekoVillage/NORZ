// LD A,(BC/DE) / LD (BC/DE),A
// 7(20)
module DECODER_op_X1_000xx010(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [6:0] _decodedXPT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd, // >
        output wire PI_SelectAd_BC,
        output wire PI_SelectAd_DE,
        output wire PI_SelectDt_A,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PR_Write_A, // <
        output wire PR_InvertIn // >
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _t1xx = _not_enable ~| notXPT[2];

    wire _nott4_6 = _t1xx ~| _t1xx;

    DECODER_2bit_decoder t_1dd( // 5
        .notEnable(_nott4_6),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out1x(_decodedXPT[6])
    );

    // 4~6

    DECODER_1bit_decoder d_000dx010(
        .notEnable(_nott4_6),
        .In(Source[4]),
        .notIn(notSource[4]),
        .out0(PI_SelectAd_BC),
        .out1(PI_SelectAd_DE)
    );

    assign PI_SelectDt_A = _nott4_6 ~| Source[3];

    // 4

    wire _nott4 = _decodedXPT[4] ~| _decodedXPT[4];

    DECODER_1bit_decoder d_000xd010_t4(
        .notEnable(_nott4),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(PC_W0),
        .out1(PC_R0)
    );

    // 5

    wire _nott5 = _decodedXPT[5] ~| _decodedXPT[5];

    DECODER_1bit_decoder d_000xd010_t5(
        .notEnable(_nott5),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(PC_W1),
        .out1(PC_R1)
    );

    // 6

    assign PR_Reset_XPT = _decodedXPT[6];
    assign P2_Set_CM1 = _decodedXPT[6];
    assign Pa_Ophd = _decodedXPT[6];

    wire _nott6 = _decodedXPT[6] ~| _decodedXPT[6];

    DECODER_1bit_decoder d_000xd010_t6(
        .notEnable(_nott6),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(PC_W2),
        .out1(PC_R2)
    );

    assign PR_Write_A = PC_R2;
    assign PR_InvertIn = PC_R2;

endmodule
// LD r,(HL)
// 8(28)
module DECODER_op_X1_01xxx110(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [6:0] _decodedXPT,
        output wire PI_SelectAd_HL,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd, // >
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

    DECODER_2bit_decoder t_1dd( // 5
        .notEnable(_nott1xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out1x(_decodedXPT[6])
    );

    // 4~6

    assign PI_SelectAd_HL = _t1xx;

    // 4

    assign PC_R0 = _decodedXPT[4];

    // 5

    assign PC_R1 = _decodedXPT[5];

    // 6

    assign PC_R2 = _decodedXPT[6];

    assign PR_Reset_XPT = _decodedXPT[6];
    assign P2_Set_CM1 = _decodedXPT[6];
    assign Pa_Ophd = _decodedXPT[6];

    //
    // decoder
    //

    wire _nott6 = _decodedXPT[6] ~| _decodedXPT[6];

    wire _01xx0110;
    wire _01xx1110;

    DECODER_1bit_decoder d_01xxd110(
        .notEnable(_nott6),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_01xx0110),
        .out1(_01xx1110)
    ); 

    wire _not01xx0110 = _01xx0110 ~| _01xx0110;
    wire _not01xx1110 = _01xx1110 ~| _01xx1110;

    DECODER_2bit_decoder d_01dd0110( // 5
        .notEnable(_not01xx0110),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(PR_Write_B),
        .out01(PR_Write_D),
        .out1x(PR_Write_H)
    );

    DECODER_2bit_decoder d_01dd1110( // 8
        .notEnable(_not01xx1110),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(PR_Write_C),
        .out01(PR_Write_E),
        .out10(PR_Write_L),
        .out11(PR_Write_A)
    );

    assign PR_InvertIn = (_01xx0110 | PR_Write_A); // 2

endmodule
// LD r,r'
// 9(39)
module DECODER_op_X1_01other(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [3:0] _decodedXPT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd,
        output wire PA_NOP, // >
        output wire PA_Select_B_low,
        output wire PA_Select_C_low,
        output wire PA_Select_D_low,
        output wire PA_Select_E_low,
        output wire PA_Select_H_low,
        output wire PA_Select_L_low,
        output wire PA_Select_A_low,
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

    assign _decodedXPT[3] = _not_enable ~| notXPT[0];

    assign PR_Reset_XPT = _decodedXPT[3];
    assign P2_Set_CM1 = _decodedXPT[3];
    assign Pa_Ophd = _decodedXPT[3];
    assign PA_NOP = _decodedXPT[3];

    //
    // decoder
    //

    wire _nott3 = _decodedXPT[3] ~| _decodedXPT[3];

    // select

    wire _01xxxxx0;
    wire _01xxxxx1;

    DECODER_1bit_decoder d_01xxxxxd(
        .notEnable(_nott3),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_01xxxxx0),
        .out1(_01xxxxx1)
    ); 

    wire _not01xxxxx0 = _01xxxxx0 ~| _01xxxxx0;
    wire _not01xxxxx1 = _01xxxxx1 ~| _01xxxxx1;

    DECODER_2bit_decoder d_01xxxdd0( // 5
        .notEnable(_not01xxxxx0),
        .In(Source[2:1]),
        .notIn(notSource[2:1]),
        .out00(PA_Select_B_low),
        .out01(PA_Select_D_low),
        .out1x(PA_Select_H_low)
    );

    DECODER_2bit_decoder d_01xxxdd1( // 8
        .notEnable(_not01xxxxx1),
        .In(Source[2:1]),
        .notIn(notSource[2:1]),
        .out00(PA_Select_C_low),
        .out01(PA_Select_E_low),
        .out10(PA_Select_L_low),
        .out11(PA_Select_A_low)
    );

    // write

    wire _01xx0xxx;
    wire _01xx1xxx;

    DECODER_1bit_decoder d_01xxdxxx(
        .notEnable(_nott3),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_01xx0xxx),
        .out1(_01xx1xxx)
    ); 

    wire _not01xx0xxx = _01xx0xxx ~| _01xx0xxx;
    wire _not01xx1xxx = _01xx1xxx ~| _01xx1xxx;

    DECODER_2bit_decoder d_01dd0xxx( // 5
        .notEnable(_not01xx0xxx),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(PR_Write_B),
        .out01(PR_Write_D),
        .out1x(PR_Write_H)
    );

    DECODER_2bit_decoder d_01dd1xxx( // 8
        .notEnable(_not01xx1xxx),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(PR_Write_C),
        .out01(PR_Write_E),
        .out10(PR_Write_L),
        .out11(PR_Write_A)
    );

    assign PR_InvertIn = (_01xx0xxx | PR_Write_A); // 2

endmodule
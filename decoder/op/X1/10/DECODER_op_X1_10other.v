// ADD/ADC/SUB/SBC/AND/OR/XOR/CP r
// 5(20)
module DECODER_op_X1_10other(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [3:0] _decodedXPT,
        output wire enable_alu,
        output wire PA_Select_B_low,
        output wire PA_Select_C_low,
        output wire PA_Select_D_low,
        output wire PA_Select_E_low,
        output wire PA_Select_H_low,
        output wire PA_Select_L_low,
        output wire PA_Select_A_low
    );

    wire [4:0] notXPT = ~XPT;
    wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    assign _decodedXPT[3] = _not_enable ~| notXPT[0];

    assign enable_alu = _decodedXPT[3];

    wire _nott3 = _decodedXPT[3] ~| _decodedXPT[3];

    //
    // decoder
    //

    wire _10xxxxx0;
    wire _10xxxxx1;

    DECODER_1bit_decoder d_10xxxxxd(
        .notEnable(_nott3),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_10xxxxx0),
        .out1(_10xxxxx1)
    ); 

    wire _not10xxxxx0 = _10xxxxx0 ~| _10xxxxx0;
    wire _not10xxxxx1 = _10xxxxx1 ~| _10xxxxx1;

    DECODER_2bit_decoder d_10xxxdd0( // 5
        .notEnable(_not10xxxxx0),
        .In(Source[2:1]),
        .notIn(notSource[2:1]),
        .out00(PA_Select_B_low),
        .out01(PA_Select_D_low),
        .out1x(PA_Select_H_low)
    );

    DECODER_2bit_decoder d_10xxxdd1( // 8
        .notEnable(_not10xxxxx1),
        .In(Source[2:1]),
        .notIn(notSource[2:1]),
        .out00(PA_Select_C_low),
        .out01(PA_Select_E_low),
        .out10(PA_Select_L_low),
        .out11(PA_Select_A_low)
    );

endmodule
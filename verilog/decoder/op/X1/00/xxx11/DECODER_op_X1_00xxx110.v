// LD r/(HL),n
// 3(21)
module DECODER_op_X1_00xxx110(
        input wire enable,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire P2_Set_CMR,
        output wire P2_Set_ILDrn_B,
        output wire P2_Set_ILDrn_C,
        output wire P2_Set_ILDrn_D,
        output wire P2_Set_ILDrn_E,
        output wire P2_Set_ILDrn_H,
        output wire P2_Set_ILDrn_L,
        output wire P2_Set_ILDrn_A,
        output wire P2_Set_ILDlHLln
    );

    // wire [7:0] notSource = ~Source;

    assign P2_Set_CMR = enable;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _000xx110;
    wire _001xx110;

    DECODER_1bit_decoder d_00dxx110(
        .notEnable(_not_enable),
        .In(Source[5]),
        .notIn(notSource[5]),
        .out0(_000xx110),
        .out1(_001xx110)
    ); 

    wire _not000xx110 = _000xx110 ~| _000xx110;
    wire _not001xx110 = _001xx110 ~| _001xx110;

    DECODER_2bit_decoder d_000dd110( // 8
        .notEnable(_not000xx110),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out00(P2_Set_ILDrn_B),
        .out01(P2_Set_ILDrn_C),
        .out10(P2_Set_ILDrn_D),
        .out11(P2_Set_ILDrn_E)
    );

    DECODER_2bit_decoder d_001dd110( // 8
        .notEnable(_not001xx110),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out00(P2_Set_ILDrn_H),
        .out01(P2_Set_ILDrn_L),
        .out10(P2_Set_ILDlHLln),
        .out11(P2_Set_ILDrn_A)
    );

endmodule
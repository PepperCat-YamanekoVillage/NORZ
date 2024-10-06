// EX DE,HL / DI / EI
// 1(6)
module DECODER_op_X1_111ee011(
        input wire enable,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire P2_Set_CM1, // <
        output wire Pa_Ophd, // >
        output wire PR_Ex_DE_HL,
        output wire P2_Reset_IFF1, // <
        output wire P2_Reset_IFF2, // >
        output wire P2_Set_IFF1, // <
        output wire P2_Set_IFF2 // >
    );

    // wire [7:0] notSource = ~Source;

    assign P2_Set_CM1 = enable;
    assign Pa_Ophd = enable;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    DECODER_2bit_decoder d_111dd011( // 5
        .notEnable(_not_enable),
        .In(Source[4:3]),
        .notIn(notSource[4:3]),
        .out0x(PR_Ex_DE_HL),
        .out10(P2_Reset_IFF1),
        .out11(P2_Set_IFF1)
    );

    assign P2_Reset_IFF2 = P2_Reset_IFF1;
    assign P2_Set_IFF2 = P2_Set_IFF1;

endmodule
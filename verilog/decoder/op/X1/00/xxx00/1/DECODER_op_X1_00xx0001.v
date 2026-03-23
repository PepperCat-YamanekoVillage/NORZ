// LD dd,nn
// 3(11)
module DECODER_op_X1_00xx0001(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [3:0] _decodedXPT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CMR, // >
        output wire P2_Set_ILDddnn_BC_0,
        output wire P2_Set_ILDddnn_DE_0,
        output wire P2_Set_ILDddnn_HL_0,
        output wire P2_Set_ILDddnn_SP_0
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    assign _decodedXPT[3] = _not_enable ~| notXPT[0];

    assign PR_Reset_XPT = _decodedXPT[3];
    assign P2_Set_CMR = _decodedXPT[3];

    //
    // decoder
    //

    wire _nott3 = _decodedXPT[3] ~| _decodedXPT[3];

    DECODER_2bit_decoder d_00dd0001( // 8
        .notEnable(_nott3),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(P2_Set_ILDddnn_BC_0),
        .out01(P2_Set_ILDddnn_DE_0),
        .out10(P2_Set_ILDddnn_HL_0),
        .out11(P2_Set_ILDddnn_SP_0)
    );

endmodule
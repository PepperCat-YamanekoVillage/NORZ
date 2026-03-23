// 7(24)
module DECODER_op_X1_00xxx000(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [3:0] _decodedXPT,
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1, // <
        output wire Pa_Ophd, // >
        output wire PR_Ex_AF_AF,
        output wire P2_Set_CMR,
        output wire P2_Set_IDJNZe,
        output wire P2_Set_IJRNZe,
        output wire P2_Set_IJRNCe,
        output wire P2_Set_IJRe,
        output wire P2_Set_IJRZe,
        output wire P2_Set_IJRCe
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    assign _decodedXPT[3] = _not_enable ~| notXPT[0];

    assign PR_Reset_XPT = _decodedXPT[3];

    //
    // decoder
    //

    wire _nott3 = _decodedXPT[3] ~| _decodedXPT[3];

    wire _0000x000 = ~(_nott3 | Source[5] | Source[4]); // 3
    wire _00eex000 = _nott3 ~| _0000x000;

    DECODER_op_X1_0000x000 d0000x000(
        .enable(_0000x000),
        .Source(Source),
        .notSource(notSource),
        .P2_Set_CM1(P2_Set_CM1), // <
        .Pa_Ophd(Pa_Ophd), // >
        .PR_Ex_AF_AF(PR_Ex_AF_AF)
    );

    DECODER_op_X1_00eex000 d00eex000(
        .enable(_00eex000),
        .Source(Source),
        .notSource(notSource),
        .P2_Set_CMR(P2_Set_CMR),
        .P2_Set_IDJNZe(P2_Set_IDJNZe),
        .P2_Set_IJRNZe(P2_Set_IJRNZe),
        .P2_Set_IJRNCe(P2_Set_IJRNCe),
        .P2_Set_IJRe(P2_Set_IJRe),
        .P2_Set_IJRZe(P2_Set_IJRZe),
        .P2_Set_IJRCe(P2_Set_IJRCe)
    );

endmodule
// 8
module DECODER_CBUSRQ(
        input wire not_decodingIn,
        input wire notCBUSRQ,
        input wire BUSRQ,
        input wire XPT,
        input wire notXPT,
        output wire [1:0] _decodedXPT,
        output wire P2_Set_CBUSRQ, // < 0
        output wire PI_Nullify_MREQ,
        output wire PI_Nullify_RD,
        output wire PI_Nullify_WR,
        output wire PI_Nullify_IORQ,
        output wire PI_Flag_BUSACK,
        output wire PhI_Flag_BUSACK, // >
        output wire PR_Halt_XPT,
        output wire PR_Reset_XPT, // < 1
        output wire P2_Set_CM1,
        output wire P2_Reset_CBUSRQ,
        output wire Pa_Ophd, // >
        output wire not_decodingOut
    );

    wire _is_cbusrq = not_decodingIn ~| notCBUSRQ;

    wire _decodingOut = _is_cbusrq ~| not_decodingIn;
    assign not_decodingOut = _decodingOut ~| _decodingOut;

    //
    // decoder
    //

    wire _not_is_cbusrq = _is_cbusrq ~| _is_cbusrq;

    assign _decodedXPT[0] = _not_is_cbusrq ~| XPT;
    assign _decodedXPT[1] = _not_is_cbusrq ~| notXPT;

    // 0

    assign P2_Set_CBUSRQ = _decodedXPT[0];
    assign PI_Nullify_MREQ = _decodedXPT[0];
    assign PI_Nullify_RD = _decodedXPT[0];
    assign PI_Nullify_WR = _decodedXPT[0];
    assign PI_Nullify_IORQ = _decodedXPT[0];
    assign PI_Flag_BUSACK = _decodedXPT[0];
    assign PhI_Flag_BUSACK = _decodedXPT[0];

    wire _not_decodedXPT0 = _decodedXPT[0] ~| _decodedXPT[0];
    assign PR_Halt_XPT = _not_decodedXPT0 ~| BUSRQ;

    // 1

    assign PR_Reset_XPT = _decodedXPT[1];
    assign P2_Set_CM1 = _decodedXPT[1];
    assign P2_Reset_CBUSRQ = _decodedXPT[1];
    assign Pa_Ophd = _decodedXPT[1];

endmodule
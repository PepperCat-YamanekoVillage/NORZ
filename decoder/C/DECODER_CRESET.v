// 3
module DECODER_CRESET(
        input wire not_decodingIn,
        input wire notCRESET,
        output wire PR_Reset_XPT, // <
        output wire PA_NOP,
        output wire PR_Write_PC_low,
        output wire PR_Write_PC_high,
        output wire PR_Write_I,
        output wire PR_Write_R,
        output wire P2_Reset_CRESET,
        output wire P2_Set_CM1,
        output wire P2_IM0,
        output wire P2_Reset_IFF1,
        output wire P2_Reset_IFF2,
        output wire Pa_Ophd, // >
        output wire not_decodingOut
    );

    wire _is_creset = not_decodingIn ~| notCRESET;

    wire _decodingOut = _is_creset ~| not_decodingIn;
    assign not_decodingOut = _decodingOut ~| _decodingOut;

    assign PR_Reset_XPT = _is_creset;
    assign PA_NOP = _is_creset;
    assign PR_Write_PC_low = _is_creset;
    assign PR_Write_PC_high = _is_creset;
    assign PR_Write_I = _is_creset;
    assign PR_Write_R = _is_creset;
    assign P2_Reset_CRESET = _is_creset;
    assign P2_Set_CM1 = _is_creset;
    assign P2_IM0 = _is_creset;
    assign P2_Reset_IFF1 = _is_creset;
    assign P2_Reset_IFF2 = _is_creset;
    assign Pa_Ophd = _is_creset;

endmodule
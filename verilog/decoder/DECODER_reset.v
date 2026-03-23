// 2
module DECODER_reset(
        input wire RESET,
        input wire TRESET,
        output wire P2_Set_CRESET,
        output wire P2_Reset_ALL_except_CRESET,
        output wire decoding
    );

    assign decoding = TRESET;

    wire _notRESET = RESET ~| RESET;

    assign P2_Set_CRESET = TRESET ~| _notRESET;
    assign P2_Reset_ALL_except_CRESET = P2_Set_CRESET;

endmodule
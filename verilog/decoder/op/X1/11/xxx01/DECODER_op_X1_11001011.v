// XBIT
// 0
module DECODER_op_X1_11001011(
        input wire enable,
        output wire P2_Set_CM1, //<
        output wire P2_Set_XBIT // >
    );

    assign P2_Set_CM1 = enable;
    assign P2_Set_XBIT = enable;

endmodule
// DAA_2用
// 4
module ALU_flag_DAACY(
        input wire [7:0] notHigh,
        input wire notCY4,
        input wire CY8,
        output wire notDAACY8
    );

    // (1xx1 & CY)or CY8

    wire _1xx1_CY4 = ~(notHigh[7] | notHigh[4] | notCY4); // 3

    assign notDAACY8 = _1xx1_CY4 ~| CY8;

endmodule
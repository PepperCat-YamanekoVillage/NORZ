// 0
module DECODER_basic_R(
        input wire PC_R0,
        input wire PC_R1,
        input wire PC_R2,
        output wire PC_RA0,
        output wire PC_RA1,
        output wire PC_RA2,
        output wire PA_NOP
    );

    // 0

    assign PC_RA0 = PC_R0;

    // 1

    assign PC_RA1 = PC_R1;

    // 2

    assign PC_RA2 = PC_R2;
    assign PA_NOP =PC_R2;

endmodule
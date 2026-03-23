// decoder合成基板でwired or式にすると思う
// 42
module ALU_input_mux_direct(
        input wire PA_Select_0x1_high, // 未使用
        input wire PA_Select_0xffOP_low, // 1111 1111 0000 0000
        input wire PA_Select_0x1_low,  // 0000 0001
        input wire PA_Select_0x8_low,  // 0000 1000
        input wire PA_Select_0x10_low, // 0001 0000
        input wire PA_Select_0x18_low, // 0001 1000
        input wire PA_Select_0x20_low, // 0010 0000
        input wire PA_Select_0x28_low, // 0010 1000
        input wire PA_Select_0x30_low, // 0011 0000
        input wire PA_Select_0x38_low, // 0011 1000
        input wire PA_Select_0x66_low, // 0110 0110
        input wire PA_Select_0xaa_low, // 1010 1010
        input wire PA_Select_0x06_low, // 0000 0110
        input wire PA_Select_0x60_low, // 0110 0000
        input wire PA_Select_0x2_low,  // 0000 0010
        input wire PA_Select_0x4_low,  // 0000 0100
        input wire PA_Select_0x40_low, // 0100 0000
        input wire PA_Select_0x80_low, // 1000 0000
        output wire High,
        output wire [15:0] Low
    );

    assign High = PA_Select_0x1_high;

    assign Low[0] = PA_Select_0x1_low;

    assign Low[1] = (PA_Select_0x66_low | PA_Select_0xaa_low | PA_Select_0x06_low | PA_Select_0x2_low); // 6

    assign Low[2] = (PA_Select_0x66_low | PA_Select_0x06_low | PA_Select_0x4_low); // 4

    assign Low[3] = (PA_Select_0x8_low | PA_Select_0x18_low | PA_Select_0x28_low | PA_Select_0x38_low | PA_Select_0xaa_low); // 8

    assign Low[4] = (PA_Select_0x10_low | PA_Select_0x18_low | PA_Select_0x30_low | PA_Select_0x38_low); // 6

    assign Low[5] = (PA_Select_0x20_low | PA_Select_0x28_low | PA_Select_0x30_low | PA_Select_0x38_low | PA_Select_0x66_low | PA_Select_0xaa_low | PA_Select_0x60_low); // 12

    assign Low[6] = (PA_Select_0x66_low | PA_Select_0x60_low | PA_Select_0x40_low); // 4

    assign Low[7] = (PA_Select_0xaa_low | PA_Select_0x80_low); // 2
    
    assign Low[8] = PA_Select_0xffOP_low;
    assign Low[9] = PA_Select_0xffOP_low;
    assign Low[10] = PA_Select_0xffOP_low;
    assign Low[11] = PA_Select_0xffOP_low;
    assign Low[12] = PA_Select_0xffOP_low;
    assign Low[13] = PA_Select_0xffOP_low;
    assign Low[14] = PA_Select_0xffOP_low;
    assign Low[15] = PA_Select_0xffOP_low;

endmodule
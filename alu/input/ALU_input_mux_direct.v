// 34
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
        input wire PA_Select_0x99_low, // 1001 1001
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

    wire _notLow0 = PA_Select_0x1_low ~| PA_Select_0x99_low;
    assign Low[0] = _notLow0 ~| _notLow0;

    wire _notLow1_0 = PA_Select_0x66_low ~| PA_Select_0x06_low;
    wire _Low1_0 = _notLow1_0 ~| _notLow1_0;
    wire _notLow1 = PA_Select_0x2_low ~| _Low1_0;
    assign Low[1] = _notLow1 ~| _notLow1;

    wire _notLow2 = PA_Select_0x4_low ~| _Low1_0;
    assign Low[2] = _notLow2 ~| _notLow2;
    
    wire _notLow3_0 = PA_Select_0x18_low ~| PA_Select_0x99_low;
    wire _Low3_0 = _notLow3_0 ~| _notLow3_0;
    wire _notLow3_1 = PA_Select_0x8_low ~| PA_Select_0x28_low;
    wire _Low3_1 = _notLow3_1 ~| _notLow3_1;
    wire _notLow3_2 = PA_Select_0x38_low ~| _Low3_0;
    wire _Low3_2 = _notLow3_2 ~| _notLow3_2;
    wire _notLow3 = _Low3_1 ~| _Low3_2;
    assign Low[3] = _notLow3 ~| _notLow3;

    wire _notLow4_0 = PA_Select_0x30_low ~| PA_Select_0x38_low;
    wire _Low4_0 = _notLow4_0 ~| _notLow4_0;
    wire _notLow4_1 = PA_Select_0x10_low ~| _Low4_0;
    wire _Low4_1 = _notLow4_1 ~| _notLow4_1;
    wire _notLow4 = _Low3_0 ~| _Low4_1;
    assign Low[4] = _notLow4 ~| _notLow4;

    wire _notLow5_0 = PA_Select_0x66_low ~| PA_Select_0x60_low;
    wire _Low5_0 = _notLow5_0 ~| _notLow5_0;
    wire _notLow5_1 = PA_Select_0x20_low ~| PA_Select_0x28_low;
    wire _Low5_1 = _notLow5_1 ~| _notLow5_1;
    wire _notLow5_2 = _Low4_0 ~| _Low5_0;
    wire _Low5_2 = _notLow5_2 ~| _notLow5_2;
    wire _notLow5 = _Low5_1 ~| _Low5_2;
    assign Low[5] = _notLow5 ~| _notLow5;

    wire _notLow6 = _Low5_0 ~| PA_Select_0x40_low;
    assign Low[6] = _notLow6 ~| _notLow6;

    wire _notLow7 = PA_Select_0x99_low ~| PA_Select_0x80_low;
    assign Low[7] = _notLow7 ~| _notLow7;

    assign Low[8] = PA_Select_0xffOP_low;
    assign Low[9] = PA_Select_0xffOP_low;
    assign Low[10] = PA_Select_0xffOP_low;
    assign Low[11] = PA_Select_0xffOP_low;
    assign Low[12] = PA_Select_0xffOP_low;
    assign Low[13] = PA_Select_0xffOP_low;
    assign Low[14] = PA_Select_0xffOP_low;
    assign Low[15] = PA_Select_0xffOP_low;

endmodule
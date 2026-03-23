// 73
module ALU_operation(
        input wire [15:0] Low,
        input wire [15:0] notLow,
        input wire PA_NOP,
        input wire PA_ADD,
        input wire PA_ADC,
        input wire PA_SUB,
        input wire PA_SBC,
        input wire PA_NOT,
        input wire PA_AND,
        input wire PA_NLAND,
        input wire PA_RLC,
        input wire PA_RL,
        input wire PA_SLA,
        input wire PA_RRC,
        input wire PA_RR,
        input wire PA_SRA,
        input wire PA_SRL,
        output wire [15:0] ProcessedLow,
        output wire notRl7,
        output wire notRl0,
        output wire notRfC,
        output wire notPAs_ADD,
        output wire notPAs_AND,
        output wire notPAs_RL,
        output wire notPAs_RR
    );

    //
    // ProcessedLow
    //

    // or

    wire _notIsLowNot0 = PA_SUB ~| PA_SBC;
    wire _isLowNot0 = _notIsLowNot0 ~| _notIsLowNot0;
    wire _notIsLowNot1 = PA_NOT ~| PA_NLAND;
    wire _isLowNot1 = _notIsLowNot1 ~| _notIsLowNot1;
    wire _notIsLowNot = _isLowNot0 ~| _isLowNot1;
    wire _isLowNot = _notIsLowNot ~| _notIsLowNot;

    // xor

    wire _low0_xor_p = _isLowNot ~| Low[0];
    wire _low0_xor_n = _notIsLowNot ~| notLow[0];
    assign ProcessedLow[0] = _low0_xor_p ~| _low0_xor_n;

    wire _low1_xor_p = _isLowNot ~| Low[1];
    wire _low1_xor_n = _notIsLowNot ~| notLow[1];
    assign ProcessedLow[1] = _low1_xor_p ~| _low1_xor_n;

    wire _low2_xor_p = _isLowNot ~| Low[2];
    wire _low2_xor_n = _notIsLowNot ~| notLow[2];
    assign ProcessedLow[2] = _low2_xor_p ~| _low2_xor_n;

    wire _low3_xor_p = _isLowNot ~| Low[3];
    wire _low3_xor_n = _notIsLowNot ~| notLow[3];
    assign ProcessedLow[3] = _low3_xor_p ~| _low3_xor_n;

    wire _low4_xor_p = _isLowNot ~| Low[4];
    wire _low4_xor_n = _notIsLowNot ~| notLow[4];
    assign ProcessedLow[4] = _low4_xor_p ~| _low4_xor_n;

    wire _low5_xor_p = _isLowNot ~| Low[5];
    wire _low5_xor_n = _notIsLowNot ~| notLow[5];
    assign ProcessedLow[5] = _low5_xor_p ~| _low5_xor_n;

    wire _low6_xor_p = _isLowNot ~| Low[6];
    wire _low6_xor_n = _notIsLowNot ~| notLow[6];
    assign ProcessedLow[6] = _low6_xor_p ~| _low6_xor_n;

    wire _low7_xor_p = _isLowNot ~| Low[7];
    wire _low7_xor_n = _notIsLowNot ~| notLow[7];
    assign ProcessedLow[7] = _low7_xor_p ~| _low7_xor_n;

    wire _low8_xor_p = _isLowNot ~| Low[8];
    wire _low8_xor_n = _notIsLowNot ~| notLow[8];
    assign ProcessedLow[8] = _low8_xor_p ~| _low8_xor_n;

    wire _low9_xor_p = _isLowNot ~| Low[9];
    wire _low9_xor_n = _notIsLowNot ~| notLow[9];
    assign ProcessedLow[9] = _low9_xor_p ~| _low9_xor_n;

    wire _low10_xor_p = _isLowNot ~| Low[10];
    wire _low10_xor_n = _notIsLowNot ~| notLow[10];
    assign ProcessedLow[10] = _low10_xor_p ~| _low10_xor_n;

    wire _low11_xor_p = _isLowNot ~| Low[11];
    wire _low11_xor_n = _notIsLowNot ~| notLow[11];
    assign ProcessedLow[11] = _low11_xor_p ~| _low11_xor_n;

    wire _low12_xor_p = _isLowNot ~| Low[12];
    wire _low12_xor_n = _notIsLowNot ~| notLow[12];
    assign ProcessedLow[12] = _low12_xor_p ~| _low12_xor_n;

    wire _low13_xor_p = _isLowNot ~| Low[13];
    wire _low13_xor_n = _notIsLowNot ~| notLow[13];
    assign ProcessedLow[13] = _low13_xor_p ~| _low13_xor_n;

    wire _low14_xor_p = _isLowNot ~| Low[14];
    wire _low14_xor_n = _notIsLowNot ~| notLow[14];
    assign ProcessedLow[14] = _low14_xor_p ~| _low14_xor_n;

    wire _low15_xor_p = _isLowNot ~| Low[15];
    wire _low15_xor_n = _notIsLowNot ~| notLow[15];
    assign ProcessedLow[15] = _low15_xor_p ~| _low15_xor_n;

    //
    // Rl
    //

    assign notRl7 = PA_RLC ~| PA_SRA;

    assign notRl0 = PA_RRC ~| PA_RRC;

    assign notRfC = PA_RL ~| PA_RR;

    //
    // PAs
    //

    wire _notPAs_ADD0 = PA_NOP ~| PA_ADD;
    wire _PAs_ADD0 = _notPAs_ADD0 ~| _notPAs_ADD0;
    wire _notPAs_ADD1 = PA_ADC ~| PA_NOT;
    wire _PAs_ADD1 = _notPAs_ADD1 ~| _notPAs_ADD1;
    wire _notPAs_ADD2 = _PAs_ADD0 ~| _PAs_ADD1;
    wire _PAs_ADD2 = _notPAs_ADD2 ~| _notPAs_ADD2;
    assign notPAs_ADD = _isLowNot0 ~| _PAs_ADD2;

    assign notPAs_AND = PA_AND ~| PA_NLAND;

    wire _notPAs_RL0 = PA_RLC ~| PA_RL;
    wire _PAs_RL0 = _notPAs_RL0 ~| _notPAs_RL0;
    assign notPAs_RL = PA_SLA ~| _PAs_RL0;

    wire _notPAs_RR0 = PA_RRC ~| PA_RR;
    wire _PAs_RR0 = _notPAs_RR0 ~| _notPAs_RR0;
    wire _notPAs_RR1 = PA_SRA ~| PA_SRL;
    wire _PAs_RR1 = _notPAs_RR1 ~| _notPAs_RR1;
    assign notPAs_RR = _PAs_RR0 ~| _PAs_RR1;
    
endmodule
// 1(161)
module ALU_calc(
        input wire [15:0] High,
        input wire [7:0] notHigh,
        input wire [15:0] ProcessedLow,
        input wire [7:0] notProcessedLow,
        input wire Flag_C,
        input wire PA_ADC,
        input wire PA_SUB,
        input wire PA_SBC,
        input wire notRl7,
        input wire notRl0,
        input wire notRfC,
        output wire [15:0] SUM,
        output wire [7:0] AND,
        output wire [7:0] notOR,
        output wire [7:0] notXOR,
        output wire [7:0] notRL,
        output wire [7:0] notRR,
        output wire [15:0] notRLD,
        output wire [15:0] notRRD,
        output wire notCY4,
        output wire notCY8,
        output wire CY12,
        output wire CY16
    );

    wire _notFlag_C = Flag_C ~| Flag_C;

    wire _Cfa;
    wire _notCfa;

    ALU_calc_c c(
        .C(Flag_C),
        .notC(_notFlag_C),
        .PA_ADC(PA_ADC),
        .PA_SUB(PA_SUB),
        .PA_SBC(PA_SBC),
        .Cfa(_Cfa),
        .notCfa(_notCfa)
    );

    ALU_hex_full_adder fa(
        .High(High),
        .notHigh(notHigh),
        .Low(ProcessedLow),
        .notLow(notProcessedLow),
        .C(_Cfa),
        .notC(_notCfa),
        .SUM(SUM),
        .AND(AND),
        .notOR(notOR),
        .notXOR(notXOR),
        .notCY4(notCY4),
        .notCY8(notCY8),
        .CY12(CY12),
        .CY16(CY16)
    );

    ALU_calc_r r(
        .notHigh(notHigh),
        .notLow(notProcessedLow),
        .notFlag_C(_notFlag_C),
        .notRl7(notRl7),
        .notRl0(notRl0),
        .notRfC(notRfC),
        .notRL(notRL),
        .notRR(notRR),
        .notRLD(notRLD),
        .notRRD(notRRD)
    );

endmodule
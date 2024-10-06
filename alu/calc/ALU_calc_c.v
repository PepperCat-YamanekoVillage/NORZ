// 10
module ALU_calc_c(
        input wire C,
        input wire notC,
        input wire PA_ADC,
        input wire PA_SUB,
        input wire PA_SBC,
        output wire Cfa,
        output wire notCfa
    );

    wire _notPA_ADC = PA_ADC ~| PA_ADC;
    wire _adc = notC ~| _notPA_ADC;
    wire _notPA_SBC = PA_SBC ~| PA_SBC;
    wire _sbc = C ~| _notPA_SBC;
    wire _0 = 0 ~| PA_SUB;
    wire _1 = _0 ~| _0;
    wire _2 = _1 ~| _adc;
    wire _3 = _2 ~| _2;
    assign notCfa = _3 ~| _sbc;
    assign Cfa = notCfa ~| notCfa;

endmodule
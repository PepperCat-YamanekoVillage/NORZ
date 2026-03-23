// 6
module ALU_calc_r(
        input wire [7:0] notHigh,
        input wire [7:0] notLow,
        input wire notFlag_C,
        input wire notRl7,
        input wire notRl0,
        input wire notRfC,
        output wire [7:0] notRL,
        output wire [7:0] notRR,
        output wire [15:0] notRLD,
        output wire [15:0] notRRD
    );

    wire _Low0 = notLow[0] ~| notRl0;
    wire _Low7 = notLow[7] ~| notRl7;
    wire _Flag_C = notFlag_C ~| notRfC;
    wire _0 = _Low0 ~| _Low7;
    wire _1 = _0 ~| _0;
    assign notRL[0] =  _1 ~| _Flag_C;
    assign notRR[7] =  notRL[0];
    assign notRL[7:1] = notLow[6:0];
    assign notRR[6:0] = notLow[7:1];

    assign notRLD[7:4] = notLow[7:4];
    assign notRLD[11:8] = notLow[3:0];
    assign notRLD[15:12] = notHigh[3:0];
    assign notRLD[3:0] = notHigh[7:4];

    assign notRRD[7:4] = notLow[7:4];
    assign notRRD[15:12] = notLow[3:0];
    assign notRRD[11:8] = notHigh[7:4];
    assign notRRD[3:0] = notHigh[3:0];

endmodule
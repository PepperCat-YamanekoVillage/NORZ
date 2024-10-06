// バラしてレジスタにくっつける
// 8bit or/nor は省略
// (432)

`define en8(bit) {bit, bit, bit, bit, bit, bit, bit, bit}

module INTERFACE_Ad_mux(
        input wire [7:0] notA,
        input wire [7:0] notB,
        input wire [7:0] notC,
        input wire [7:0] notD,
        input wire [7:0] notE,
        input wire [7:0] notH,
        input wire [7:0] notL,
        input wire [7:0] notDt,
        input wire [7:0] notDtex,
        input wire [7:0] notR,
        input wire [7:0] notI,
        input wire [7:0] notOP,
        input wire [7:0] notOPold,
        input wire [15:0] notPC,
        input wire [15:0] notSP,
        input wire [15:0] notALU,
        input wire notPI_SelectAd_PC,
        input wire notPI_SelectAd_SP,
        input wire notPI_SelectAd_BC,
        input wire notPI_SelectAd_DE,
        input wire notPI_SelectAd_HL,
        input wire notPI_SelectAd_IR,
        input wire notPI_SelectAd_DtexDt,
        input wire notPI_SelectAd_OPOPold,
        input wire notPI_SelectAd_ALU,
        input wire notPI_SelectAd_AOP,
        output wire [15:0] notSelectedAd
    );

    // and(8)
    wire [7:0] _high_PC = notPC[15:8] ~| `en8(notPI_SelectAd_PC);
    wire [7:0] _high_SP = notSP[15:8] ~| `en8(notPI_SelectAd_SP);
    wire [7:0] _high_B = notB ~| `en8(notPI_SelectAd_BC);
    wire [7:0] _high_D = notD ~| `en8(notPI_SelectAd_DE);
    wire [7:0] _high_H = notH ~| `en8(notPI_SelectAd_HL);
    wire [7:0] _high_I = notI ~| `en8(notPI_SelectAd_IR);
    wire [7:0] _high_Dtex = notDtex ~| `en8(notPI_SelectAd_DtexDt);
    wire [7:0] _high_OP = notOP ~| `en8(notPI_SelectAd_OPOPold);
    wire [7:0] _high_ALU = notALU[15:8] ~| `en8(notPI_SelectAd_ALU);
    wire [7:0] _high_A = notA ~| `en8(notPI_SelectAd_AOP);

    wire [7:0] _low_PC = notPC[7:0] ~| `en8(notPI_SelectAd_PC);
    wire [7:0] _low_SP = notSP[7:0] ~| `en8(notPI_SelectAd_SP);
    wire [7:0] _low_C = notC ~| `en8(notPI_SelectAd_BC);
    wire [7:0] _low_E = notE ~| `en8(notPI_SelectAd_DE);
    wire [7:0] _low_L = notL ~| `en8(notPI_SelectAd_HL);
    wire [7:0] _low_R = notR ~| `en8(notPI_SelectAd_IR);
    wire [7:0] _low_Dt = notDt ~| `en8(notPI_SelectAd_DtexDt);
    wire [7:0] _low_OPold = notOPold ~| `en8(notPI_SelectAd_OPOPold);
    wire [7:0] _low_ALU = notALU[7:0] ~| `en8(notPI_SelectAd_ALU);
    wire [7:0] _low_OP = notOP ~| `en8(notPI_SelectAd_AOP);

    // or(16)
    assign notSelectedAd[15:8] = ~(_high_PC|_high_SP|_high_B|_high_D|_high_H|_high_I|_high_Dtex|_high_OP|_high_ALU|_high_A);
    assign notSelectedAd[7:0] = ~(_low_PC|_low_SP|_low_C|_low_E|_low_L|_low_R|_low_Dt|_low_OPold|_low_ALU|_low_OP);

endmodule
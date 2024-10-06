// バラしてレジスタにくっつける
// 8bit or/nor は省略
// (440)

`define en8(bit) {bit, bit, bit, bit, bit, bit, bit, bit}

module INTERFACE_Dt_mux(
        input wire [7:0] notA,
        input wire [7:0] notF,
        input wire [7:0] notB,
        input wire [7:0] notC,
        input wire [7:0] notD,
        input wire [7:0] notE,
        input wire [7:0] notH,
        input wire [7:0] notL,
        input wire [7:0] notDt,
        input wire [7:0] notDtex,
        input wire [7:0] notOP,
        input wire [15:0] notPC,
        input wire [15:0] notIX,
        input wire [15:0] notIY,
        input wire [15:0] notSP,
        input wire notPI_SelectDt_PC_high,
        input wire notPI_SelectDt_PC_low,
        input wire notPI_SelectDt_IX_high,
        input wire notPI_SelectDt_IX_low,
        input wire notPI_SelectDt_IY_high,
        input wire notPI_SelectDt_IY_low,
        input wire notPI_SelectDt_A,
        input wire notPI_SelectDt_F,
        input wire notPI_SelectDt_B,
        input wire notPI_SelectDt_C,
        input wire notPI_SelectDt_D,
        input wire notPI_SelectDt_E,
        input wire notPI_SelectDt_H,
        input wire notPI_SelectDt_L,
        input wire notPI_SelectDt_OP,
        input wire notPI_SelectDt_Dt,
        input wire notPI_SelectDt_Dtex,
        input wire notPI_SelectDt_SP_low,
        input wire notPI_SelectDt_SP_high,
        output wire [7:0] selectedDt
    );

    // and(8)
    wire [7:0] _PC_high = notPC[15:8] ~| `en8(notPI_SelectDt_PC_high);
    wire [7:0] _PC_low = notPC[7:0] ~| `en8(notPI_SelectDt_PC_low);
    wire [7:0] _IX_high = notIX[15:8] ~| `en8(notPI_SelectDt_IX_high);
    wire [7:0] _IX_low = notIX[7:0] ~| `en8(notPI_SelectDt_IX_low);
    wire [7:0] _IY_high = notIY[15:8] ~| `en8(notPI_SelectDt_IY_high);
    wire [7:0] _IY_low = notIY[7:0] ~| `en8(notPI_SelectDt_IY_low);
    wire [7:0] _A = notA ~| `en8(notPI_SelectDt_A);
    wire [7:0] _F = notF ~| `en8(notPI_SelectDt_F);
    wire [7:0] _B = notB ~| `en8(notPI_SelectDt_B);
    wire [7:0] _C = notC ~| `en8(notPI_SelectDt_C);
    wire [7:0] _D = notD ~| `en8(notPI_SelectDt_D);
    wire [7:0] _E = notE ~| `en8(notPI_SelectDt_E);
    wire [7:0] _H = notH ~| `en8(notPI_SelectDt_H);
    wire [7:0] _L = notL ~| `en8(notPI_SelectDt_L);
    wire [7:0] _OP = notOP ~| `en8(notPI_SelectDt_OP);
    wire [7:0] _Dt = notDt ~| `en8(notPI_SelectDt_Dt);
    wire [7:0] _Dtex = notDtex ~| `en8(notPI_SelectDt_Dtex);
    wire [7:0] _SP_low = notSP[7:0] ~| `en8(notPI_SelectDt_SP_low);
    wire [7:0] _SP_high = notSP[15:8] ~| `en8(notPI_SelectDt_SP_high);

    // or(16)
    assign selectedDt = (_PC_high|_PC_low|_IX_high|_IX_low|_IY_high|_IY_low|_A|_F|_B|_C|_D|_E|_H|_L|_OP|_Dt|_Dtex|_SP_low|_SP_high);

endmodule
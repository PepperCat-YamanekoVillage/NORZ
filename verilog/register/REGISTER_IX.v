// IYも同じ
// 2(194)
module REGISTER_IX(
        // input wire clk,
        input wire Clk,
        input wire notClk,
        input wire [15:0] notALUResult,
        input wire PR_Write_IX_high,
        input wire PR_Write_IX_low,
        output wire [15:0] IX,
        output wire [15:0] notIX
    );

    // wire Clk = clk;
    // wire notClk = ~clk;

    wire _notPR_Write_IX_high = PR_Write_IX_high ~| PR_Write_IX_high;
    wire _notPR_Write_IX_low = PR_Write_IX_low ~| PR_Write_IX_low;

    wire _new_notIX0;
    wire _new_notIX1;
    wire _new_notIX2;
    wire _new_notIX3;
    wire _new_notIX4;
    wire _new_notIX5;
    wire _new_notIX6;
    wire _new_notIX7;
    wire _new_notIX8;
    wire _new_notIX9;
    wire _new_notIX10;
    wire _new_notIX11;
    wire _new_notIX12;
    wire _new_notIX13;
    wire _new_notIX14;
    wire _new_notIX15;

    REGISTER_mux m0(
        .S(PR_Write_IX_low),
        .notS(_notPR_Write_IX_low),
        .N(notIX[0]),
        .P(notALUResult[0]),
        .Out(_new_notIX0)
    );

    REGISTER_mux m1(
        .S(PR_Write_IX_low),
        .notS(_notPR_Write_IX_low),
        .N(notIX[1]),
        .P(notALUResult[1]),
        .Out(_new_notIX1)
    );

    REGISTER_mux m2(
        .S(PR_Write_IX_low),
        .notS(_notPR_Write_IX_low),
        .N(notIX[2]),
        .P(notALUResult[2]),
        .Out(_new_notIX2)
    );

    REGISTER_mux m3(
        .S(PR_Write_IX_low),
        .notS(_notPR_Write_IX_low),
        .N(notIX[3]),
        .P(notALUResult[3]),
        .Out(_new_notIX3)
    );

    REGISTER_mux m4(
        .S(PR_Write_IX_low),
        .notS(_notPR_Write_IX_low),
        .N(notIX[4]),
        .P(notALUResult[4]),
        .Out(_new_notIX4)
    );

    REGISTER_mux m5(
        .S(PR_Write_IX_low),
        .notS(_notPR_Write_IX_low),
        .N(notIX[5]),
        .P(notALUResult[5]),
        .Out(_new_notIX5)
    );

    REGISTER_mux m6(
        .S(PR_Write_IX_low),
        .notS(_notPR_Write_IX_low),
        .N(notIX[6]),
        .P(notALUResult[6]),
        .Out(_new_notIX6)
    );

    REGISTER_mux m7(
        .S(PR_Write_IX_low),
        .notS(_notPR_Write_IX_low),
        .N(notIX[7]),
        .P(notALUResult[7]),
        .Out(_new_notIX7)
    );

    REGISTER_mux m8(
        .S(PR_Write_IX_high),
        .notS(_notPR_Write_IX_high),
        .N(notIX[8]),
        .P(notALUResult[8]),
        .Out(_new_notIX8)
    );

    REGISTER_mux m9(
        .S(PR_Write_IX_high),
        .notS(_notPR_Write_IX_high),
        .N(notIX[9]),
        .P(notALUResult[9]),
        .Out(_new_notIX9)
    );

    REGISTER_mux m10(
        .S(PR_Write_IX_high),
        .notS(_notPR_Write_IX_high),
        .N(notIX[10]),
        .P(notALUResult[10]),
        .Out(_new_notIX10)
    );

    REGISTER_mux m11(
        .S(PR_Write_IX_high),
        .notS(_notPR_Write_IX_high),
        .N(notIX[11]),
        .P(notALUResult[11]),
        .Out(_new_notIX11)
    );

    REGISTER_mux m12(
        .S(PR_Write_IX_high),
        .notS(_notPR_Write_IX_high),
        .N(notIX[12]),
        .P(notALUResult[12]),
        .Out(_new_notIX12)
    );

    REGISTER_mux m13(
        .S(PR_Write_IX_high),
        .notS(_notPR_Write_IX_high),
        .N(notIX[13]),
        .P(notALUResult[13]),
        .Out(_new_notIX13)
    );

    REGISTER_mux m14(
        .S(PR_Write_IX_high),
        .notS(_notPR_Write_IX_high),
        .N(notIX[14]),
        .P(notALUResult[14]),
        .Out(_new_notIX14)
    );

    REGISTER_mux m15(
        .S(PR_Write_IX_high),
        .notS(_notPR_Write_IX_high),
        .N(notIX[15]),
        .P(notALUResult[15]),
        .Out(_new_notIX15)
    );

    REGISTER_dff IX0(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notIX0),
        .Q(IX[0]),
        .notQ(notIX[0])
    );

    REGISTER_dff IX1(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notIX1),
        .Q(IX[1]),
        .notQ(notIX[1])
    );

    REGISTER_dff IX2(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notIX2),
        .Q(IX[2]),
        .notQ(notIX[2])
    );

    REGISTER_dff IX3(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notIX3),
        .Q(IX[3]),
        .notQ(notIX[3])
    );

    REGISTER_dff IX4(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notIX4),
        .Q(IX[4]),
        .notQ(notIX[4])
    );

    REGISTER_dff IX5(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notIX5),
        .Q(IX[5]),
        .notQ(notIX[5])
    );

    REGISTER_dff IX6(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notIX6),
        .Q(IX[6]),
        .notQ(notIX[6])
    );

    REGISTER_dff IX7(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notIX7),
        .Q(IX[7]),
        .notQ(notIX[7])
    );

    REGISTER_dff IX8(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notIX8),
        .Q(IX[8]),
        .notQ(notIX[8])
    );

    REGISTER_dff IX9(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notIX9),
        .Q(IX[9]),
        .notQ(notIX[9])
    );

    REGISTER_dff IX10(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notIX10),
        .Q(IX[10]),
        .notQ(notIX[10])
    );

    REGISTER_dff IX11(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notIX11),
        .Q(IX[11]),
        .notQ(notIX[11])
    );

    REGISTER_dff IX12(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notIX12),
        .Q(IX[12]),
        .notQ(notIX[12])
    );

    REGISTER_dff IX13(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notIX13),
        .Q(IX[13]),
        .notQ(notIX[13])
    );

    REGISTER_dff IX14(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notIX14),
        .Q(IX[14]),
        .notQ(notIX[14])
    );

    REGISTER_dff IX15(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notIX15),
        .Q(IX[15]),
        .notQ(notIX[15])
    );

endmodule
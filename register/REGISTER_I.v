// Dt,Dtex,Dtcs,OP,OPoldも同じ
// ただし、OPは常にALUlowを、DtcsはDinを、OPoldはOPを入力にとる
// また、DtcsはClk/notClkが逆になって入力される
// DtcsはPI_ReadDtcsを、OPoldはPR_SlideOPをPR_Write_Iにいれること
// 1(97)
module REGISTER_I(
        // input wire clk,
        input wire Clk,
        input wire notClk,
        input wire [7:0] notALUResult,
        input wire PR_Write_I,
        output wire [7:0] I,
        output wire [7:0] notI
    );

    // wire Clk = clk;
    // wire notClk = ~clk;

    wire _notPR_Write_I = PR_Write_I ~| PR_Write_I;

    wire _newI0;
    wire _newI1;
    wire _newI2;
    wire _newI3;
    wire _newI4;
    wire _newI5;
    wire _newI6;
    wire _newI7;

    REGISTER_mux m0(
        .S(PR_Write_I),
        .notS(_notPR_Write_I),
        .N(notI[0]),
        .P(notALUResult[0]),
        .Out(_newI0)
    );

    REGISTER_mux m1(
        .S(PR_Write_I),
        .notS(_notPR_Write_I),
        .N(notI[1]),
        .P(notALUResult[1]),
        .Out(_newI1)
    );

    REGISTER_mux m2(
        .S(PR_Write_I),
        .notS(_notPR_Write_I),
        .N(notI[2]),
        .P(notALUResult[2]),
        .Out(_newI2)
    );

    REGISTER_mux m3(
        .S(PR_Write_I),
        .notS(_notPR_Write_I),
        .N(notI[3]),
        .P(notALUResult[3]),
        .Out(_newI3)
    );

    REGISTER_mux m4(
        .S(PR_Write_I),
        .notS(_notPR_Write_I),
        .N(notI[4]),
        .P(notALUResult[4]),
        .Out(_newI4)
    );

    REGISTER_mux m5(
        .S(PR_Write_I),
        .notS(_notPR_Write_I),
        .N(notI[5]),
        .P(notALUResult[5]),
        .Out(_newI5)
    );

    REGISTER_mux m6(
        .S(PR_Write_I),
        .notS(_notPR_Write_I),
        .N(notI[6]),
        .P(notALUResult[6]),
        .Out(_newI6)
    );

    REGISTER_mux m7(
        .S(PR_Write_I),
        .notS(_notPR_Write_I),
        .N(notI[7]),
        .P(notALUResult[7]),
        .Out(_newI7)
    );

    REGISTER_dff I0(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_newI0),
        .Q(I[0]),
        .notQ(notI[0])
    );

    REGISTER_dff I1(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_newI1),
        .Q(I[1]),
        .notQ(notI[1])
    );

    REGISTER_dff I2(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_newI2),
        .Q(I[2]),
        .notQ(notI[2])
    );

    REGISTER_dff I3(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_newI3),
        .Q(I[3]),
        .notQ(notI[3])
    );

    REGISTER_dff I4(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_newI4),
        .Q(I[4]),
        .notQ(notI[4])
    );

    REGISTER_dff I5(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_newI5),
        .Q(I[5]),
        .notQ(notI[5])
    );

    REGISTER_dff I6(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_newI6),
        .Q(I[6]),
        .notQ(notI[6])
    );

    REGISTER_dff I7(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_newI7),
        .Q(I[7]),
        .notQ(notI[7])
    );

endmodule
// 19(383)
module REGISTER_SP(
        // input wire clk,
        input wire Clk,
        input wire notClk,
        input wire [15:0] notALUResult,
        input wire PR_Write_SP_high,
        input wire PR_Write_SP_low,
        input wire PR_Inc_SP,
        input wire PR_Dec_SP,
        output wire [15:0] SP,
        output wire [15:0] notSP
    );

    // wire Clk = clk;
    // wire notClk = ~clk;

    wire _notPR_Write_high = PR_Write_SP_high ~| PR_Write_SP_high;
    wire _notPR_Write_low = PR_Write_SP_low ~| PR_Write_SP_low;
    wire _notPR_Dec_SP = PR_Dec_SP ~| PR_Dec_SP;

    //
    // inc
    //

    wire [15:0] _Inc;

    REGISTER_16bit_inc Inc(
        .In(SP),
        .notIn(notSP),
        .CY(PR_Inc_SP),
        .Out(_Inc)
    );

    //
    // dec
    //

    wire [15:0] _notDec;

    REGISTER_16bit_dec Dec(
        .In(SP),
        .notIn(notSP),
        .notOut(_notDec)
    );

    wire _notInc0 = _Inc[0] ~| _Inc[0];
    wire _notInc1 = _Inc[1] ~| _Inc[1];
    wire _notInc2 = _Inc[2] ~| _Inc[2];
    wire _notInc3 = _Inc[3] ~| _Inc[3];
    wire _notInc4 = _Inc[4] ~| _Inc[4];
    wire _notInc5 = _Inc[5] ~| _Inc[5];
    wire _notInc6 = _Inc[6] ~| _Inc[6];
    wire _notInc7 = _Inc[7] ~| _Inc[7];
    wire _notInc8 = _Inc[8] ~| _Inc[8];
    wire _notInc9 = _Inc[9] ~| _Inc[9];
    wire _notInc10 = _Inc[10] ~| _Inc[10];
    wire _notInc11 = _Inc[11] ~| _Inc[11];
    wire _notInc12 = _Inc[12] ~| _Inc[12];
    wire _notInc13 = _Inc[13] ~| _Inc[13];
    wire _notInc14 = _Inc[14] ~| _Inc[14];
    wire _notInc15 = _Inc[15] ~| _Inc[15];

    wire _not_m0;
    wire _not_m1;
    wire _not_m2;
    wire _not_m3;
    wire _not_m4;
    wire _not_m5;
    wire _not_m6;
    wire _not_m7;
    wire _not_m8;
    wire _not_m9;
    wire _not_m10;
    wire _not_m11;
    wire _not_m12;
    wire _not_m13;
    wire _not_m14;
    wire _not_m15;
    wire _not_newSP0;
    wire _not_newSP1;
    wire _not_newSP2;
    wire _not_newSP3;
    wire _not_newSP4;
    wire _not_newSP5;
    wire _not_newSP6;
    wire _not_newSP7;
    wire _not_newSP8;
    wire _not_newSP9;
    wire _not_newSP10;
    wire _not_newSP11;
    wire _not_newSP12;
    wire _not_newSP13;
    wire _not_newSP14;
    wire _not_newSP15;

    REGISTER_mux m0_1(
        .S(PR_Dec_SP),
        .notS(_notPR_Dec_SP),
        .N(_notInc0),
        .P(_notDec[0]),
        .Out(_not_m0)
    );

    REGISTER_mux m0_2(
        .S(PR_Write_SP_low),
        .notS(_notPR_Write_low),
        .N(_not_m0),
        .P(notALUResult[0]),
        .Out(_not_newSP0)
    );

    REGISTER_mux m1_1(
        .S(PR_Dec_SP),
        .notS(_notPR_Dec_SP),
        .N(_notInc1),
        .P(_notDec[1]),
        .Out(_not_m1)
    );

    REGISTER_mux m1_2(
        .S(PR_Write_SP_low),
        .notS(_notPR_Write_low),
        .N(_not_m1),
        .P(notALUResult[1]),
        .Out(_not_newSP1)
    );

    REGISTER_mux m2_1(
        .S(PR_Dec_SP),
        .notS(_notPR_Dec_SP),
        .N(_notInc2),
        .P(_notDec[2]),
        .Out(_not_m2)
    );

    REGISTER_mux m2_2(
        .S(PR_Write_SP_low),
        .notS(_notPR_Write_low),
        .N(_not_m2),
        .P(notALUResult[2]),
        .Out(_not_newSP2)
    );

    REGISTER_mux m3_1(
        .S(PR_Dec_SP),
        .notS(_notPR_Dec_SP),
        .N(_notInc3),
        .P(_notDec[3]),
        .Out(_not_m3)
    );

    REGISTER_mux m3_2(
        .S(PR_Write_SP_low),
        .notS(_notPR_Write_low),
        .N(_not_m3),
        .P(notALUResult[3]),
        .Out(_not_newSP3)
    );

    REGISTER_mux m4_1(
        .S(PR_Dec_SP),
        .notS(_notPR_Dec_SP),
        .N(_notInc4),
        .P(_notDec[4]),
        .Out(_not_m4)
    );

    REGISTER_mux m4_2(
        .S(PR_Write_SP_low),
        .notS(_notPR_Write_low),
        .N(_not_m4),
        .P(notALUResult[4]),
        .Out(_not_newSP4)
    );

    REGISTER_mux m5_1(
        .S(PR_Dec_SP),
        .notS(_notPR_Dec_SP),
        .N(_notInc5),
        .P(_notDec[5]),
        .Out(_not_m5)
    );

    REGISTER_mux m5_2(
        .S(PR_Write_SP_low),
        .notS(_notPR_Write_low),
        .N(_not_m5),
        .P(notALUResult[5]),
        .Out(_not_newSP5)
    );

    REGISTER_mux m6_1(
        .S(PR_Dec_SP),
        .notS(_notPR_Dec_SP),
        .N(_notInc6),
        .P(_notDec[6]),
        .Out(_not_m6)
    );

    REGISTER_mux m6_2(
        .S(PR_Write_SP_low),
        .notS(_notPR_Write_low),
        .N(_not_m6),
        .P(notALUResult[6]),
        .Out(_not_newSP6)
    );

    REGISTER_mux m7_1(
        .S(PR_Dec_SP),
        .notS(_notPR_Dec_SP),
        .N(_notInc7),
        .P(_notDec[7]),
        .Out(_not_m7)
    );

    REGISTER_mux m7_2(
        .S(PR_Write_SP_low),
        .notS(_notPR_Write_low),
        .N(_not_m7),
        .P(notALUResult[7]),
        .Out(_not_newSP7)
    );

    REGISTER_mux m8_1(
        .S(PR_Dec_SP),
        .notS(_notPR_Dec_SP),
        .N(_notInc8),
        .P(_notDec[8]),
        .Out(_not_m8)
    );

    REGISTER_mux m8_2(
        .S(PR_Write_SP_high),
        .notS(_notPR_Write_high),
        .N(_not_m8),
        .P(notALUResult[8]),
        .Out(_not_newSP8)
    );

    REGISTER_mux m9_1(
        .S(PR_Dec_SP),
        .notS(_notPR_Dec_SP),
        .N(_notInc9),
        .P(_notDec[9]),
        .Out(_not_m9)
    );

    REGISTER_mux m9_2(
        .S(PR_Write_SP_high),
        .notS(_notPR_Write_high),
        .N(_not_m9),
        .P(notALUResult[9]),
        .Out(_not_newSP9)
    );

    REGISTER_mux m10_1(
        .S(PR_Dec_SP),
        .notS(_notPR_Dec_SP),
        .N(_notInc10),
        .P(_notDec[10]),
        .Out(_not_m10)
    );

    REGISTER_mux m10_2(
        .S(PR_Write_SP_high),
        .notS(_notPR_Write_high),
        .N(_not_m10),
        .P(notALUResult[10]),
        .Out(_not_newSP10)
    );

    REGISTER_mux m11_1(
        .S(PR_Dec_SP),
        .notS(_notPR_Dec_SP),
        .N(_notInc11),
        .P(_notDec[11]),
        .Out(_not_m11)
    );

    REGISTER_mux m11_2(
        .S(PR_Write_SP_high),
        .notS(_notPR_Write_high),
        .N(_not_m11),
        .P(notALUResult[11]),
        .Out(_not_newSP11)
    );

    REGISTER_mux m12_1(
        .S(PR_Dec_SP),
        .notS(_notPR_Dec_SP),
        .N(_notInc12),
        .P(_notDec[12]),
        .Out(_not_m12)
    );

    REGISTER_mux m12_2(
        .S(PR_Write_SP_high),
        .notS(_notPR_Write_high),
        .N(_not_m12),
        .P(notALUResult[12]),
        .Out(_not_newSP12)
    );

    REGISTER_mux m13_1(
        .S(PR_Dec_SP),
        .notS(_notPR_Dec_SP),
        .N(_notInc13),
        .P(_notDec[13]),
        .Out(_not_m13)
    );

    REGISTER_mux m13_2(
        .S(PR_Write_SP_high),
        .notS(_notPR_Write_high),
        .N(_not_m13),
        .P(notALUResult[13]),
        .Out(_not_newSP13)
    );

    REGISTER_mux m14_1(
        .S(PR_Dec_SP),
        .notS(_notPR_Dec_SP),
        .N(_notInc14),
        .P(_notDec[14]),
        .Out(_not_m14)
    );

    REGISTER_mux m14_2(
        .S(PR_Write_SP_high),
        .notS(_notPR_Write_high),
        .N(_not_m14),
        .P(notALUResult[14]),
        .Out(_not_newSP14)
    );

    REGISTER_mux m15_1(
        .S(PR_Dec_SP),
        .notS(_notPR_Dec_SP),
        .N(_notInc15),
        .P(_notDec[15]),
        .Out(_not_m15)
    );

    REGISTER_mux m15_2(
        .S(PR_Write_SP_high),
        .notS(_notPR_Write_high),
        .N(_not_m15),
        .P(notALUResult[15]),
        .Out(_not_newSP15)
    );

    REGISTER_dff SP0(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_not_newSP0),
        .Q(SP[0]),
        .notQ(notSP[0])
    );

    REGISTER_dff SP1(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_not_newSP1),
        .Q(SP[1]),
        .notQ(notSP[1])
    );

    REGISTER_dff SP2(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_not_newSP2),
        .Q(SP[2]),
        .notQ(notSP[2])
    );

    REGISTER_dff SP3(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_not_newSP3),
        .Q(SP[3]),
        .notQ(notSP[3])
    );

    REGISTER_dff SP4(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_not_newSP4),
        .Q(SP[4]),
        .notQ(notSP[4])
    );

    REGISTER_dff SP5(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_not_newSP5),
        .Q(SP[5]),
        .notQ(notSP[5])
    );

    REGISTER_dff SP6(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_not_newSP6),
        .Q(SP[6]),
        .notQ(notSP[6])
    );

    REGISTER_dff SP7(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_not_newSP7),
        .Q(SP[7]),
        .notQ(notSP[7])
    );

    REGISTER_dff SP8(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_not_newSP8),
        .Q(SP[8]),
        .notQ(notSP[8])
    );

    REGISTER_dff SP9(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_not_newSP9),
        .Q(SP[9]),
        .notQ(notSP[9])
    );

    REGISTER_dff SP10(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_not_newSP10),
        .Q(SP[10]),
        .notQ(notSP[10])
    );

    REGISTER_dff SP11(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_not_newSP11),
        .Q(SP[11]),
        .notQ(notSP[11])
    );

    REGISTER_dff SP12(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_not_newSP12),
        .Q(SP[12]),
        .notQ(notSP[12])
    );

    REGISTER_dff SP13(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_not_newSP13),
        .Q(SP[13]),
        .notQ(notSP[13])
    );

    REGISTER_dff SP14(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_not_newSP14),
        .Q(SP[14]),
        .notQ(notSP[14])
    );

    REGISTER_dff SP15(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_not_newSP15),
        .Q(SP[15]),
        .notQ(notSP[15])
    );

endmodule
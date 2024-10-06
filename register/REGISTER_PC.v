// 18(275)
module REGISTER_PC(
        // input wire clk,
        input wire Clk,
        input wire notClk,
        input wire [15:0] notALUResult,
        input wire PR_Write_PC_high,
        input wire PR_Write_PC_low,
        input wire PR_Inc_PC,
        output wire [15:0] PC,
        output wire [15:0] notPC
    );

    // wire Clk = clk;
    // wire notClk = ~clk;

    wire _notPR_Write_high = PR_Write_PC_high ~| PR_Write_PC_high;
    wire _notPR_Write_low = PR_Write_PC_low ~| PR_Write_PC_low;

    //
    // inc
    //

    wire [15:0] _Inc;

    REGISTER_16bit_inc Inc(
        .In(PC),
        .notIn(notPC),
        .CY(PR_Inc_PC),
        .Out(_Inc)
    );

    wire _new_notPC0;
    wire _new_notPC1;
    wire _new_notPC2;
    wire _new_notPC3;
    wire _new_notPC4;
    wire _new_notPC5;
    wire _new_notPC6;
    wire _new_notPC7;
    wire _new_notPC8;
    wire _new_notPC9;
    wire _new_notPC10;
    wire _new_notPC11;
    wire _new_notPC12;
    wire _new_notPC13;
    wire _new_notPC14;
    wire _new_notPC15;

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

    REGISTER_mux m0(
        .S(PR_Write_PC_low),
        .notS(_notPR_Write_low),
        .N(_notInc0),
        .P(notALUResult[0]),
        .Out(_new_notPC0)
    );

    REGISTER_mux m1(
        .S(PR_Write_PC_low),
        .notS(_notPR_Write_low),
        .N(_notInc1),
        .P(notALUResult[1]),
        .Out(_new_notPC1)
    );

    REGISTER_mux m2(
        .S(PR_Write_PC_low),
        .notS(_notPR_Write_low),
        .N(_notInc2),
        .P(notALUResult[2]),
        .Out(_new_notPC2)
    );

    REGISTER_mux m3(
        .S(PR_Write_PC_low),
        .notS(_notPR_Write_low),
        .N(_notInc3),
        .P(notALUResult[3]),
        .Out(_new_notPC3)
    );

    REGISTER_mux m4(
        .S(PR_Write_PC_low),
        .notS(_notPR_Write_low),
        .N(_notInc4),
        .P(notALUResult[4]),
        .Out(_new_notPC4)
    );

    REGISTER_mux m5(
        .S(PR_Write_PC_low),
        .notS(_notPR_Write_low),
        .N(_notInc5),
        .P(notALUResult[5]),
        .Out(_new_notPC5)
    );

    REGISTER_mux m6(
        .S(PR_Write_PC_low),
        .notS(_notPR_Write_low),
        .N(_notInc6),
        .P(notALUResult[6]),
        .Out(_new_notPC6)
    );

    REGISTER_mux m7(
        .S(PR_Write_PC_low),
        .notS(_notPR_Write_low),
        .N(_notInc7),
        .P(notALUResult[7]),
        .Out(_new_notPC7)
    );

    REGISTER_mux m8(
        .S(PR_Write_PC_high),
        .notS(_notPR_Write_high),
        .N(_notInc8),
        .P(notALUResult[8]),
        .Out(_new_notPC8)
    );

    REGISTER_mux m9(
        .S(PR_Write_PC_high),
        .notS(_notPR_Write_high),
        .N(_notInc9),
        .P(notALUResult[9]),
        .Out(_new_notPC9)
    );

    REGISTER_mux m10(
        .S(PR_Write_PC_high),
        .notS(_notPR_Write_high),
        .N(_notInc10),
        .P(notALUResult[10]),
        .Out(_new_notPC10)
    );

    REGISTER_mux m11(
        .S(PR_Write_PC_high),
        .notS(_notPR_Write_high),
        .N(_notInc11),
        .P(notALUResult[11]),
        .Out(_new_notPC11)
    );

    REGISTER_mux m12(
        .S(PR_Write_PC_high),
        .notS(_notPR_Write_high),
        .N(_notInc12),
        .P(notALUResult[12]),
        .Out(_new_notPC12)
    );

    REGISTER_mux m13(
        .S(PR_Write_PC_high),
        .notS(_notPR_Write_high),
        .N(_notInc13),
        .P(notALUResult[13]),
        .Out(_new_notPC13)
    );

    REGISTER_mux m14(
        .S(PR_Write_PC_high),
        .notS(_notPR_Write_high),
        .N(_notInc14),
        .P(notALUResult[14]),
        .Out(_new_notPC14)
    );

    REGISTER_mux m15(
        .S(PR_Write_PC_high),
        .notS(_notPR_Write_high),
        .N(_notInc15),
        .P(notALUResult[15]),
        .Out(_new_notPC15)
    );

    REGISTER_dff PC0(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notPC0),
        .Q(PC[0]),
        .notQ(notPC[0])
    );

    REGISTER_dff PC1(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notPC1),
        .Q(PC[1]),
        .notQ(notPC[1])
    );

    REGISTER_dff PC2(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notPC2),
        .Q(PC[2]),
        .notQ(notPC[2])
    );

    REGISTER_dff PC3(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notPC3),
        .Q(PC[3]),
        .notQ(notPC[3])
    );

    REGISTER_dff PC4(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notPC4),
        .Q(PC[4]),
        .notQ(notPC[4])
    );

    REGISTER_dff PC5(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notPC5),
        .Q(PC[5]),
        .notQ(notPC[5])
    );

    REGISTER_dff PC6(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notPC6),
        .Q(PC[6]),
        .notQ(notPC[6])
    );

    REGISTER_dff PC7(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notPC7),
        .Q(PC[7]),
        .notQ(notPC[7])
    );

    REGISTER_dff PC8(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notPC8),
        .Q(PC[8]),
        .notQ(notPC[8])
    );

    REGISTER_dff PC9(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notPC9),
        .Q(PC[9]),
        .notQ(notPC[9])
    );

    REGISTER_dff PC10(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notPC10),
        .Q(PC[10]),
        .notQ(notPC[10])
    );

    REGISTER_dff PC11(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notPC11),
        .Q(PC[11]),
        .notQ(notPC[11])
    );

    REGISTER_dff PC12(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notPC12),
        .Q(PC[12]),
        .notQ(notPC[12])
    );

    REGISTER_dff PC13(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notPC13),
        .Q(PC[13]),
        .notQ(notPC[13])
    );

    REGISTER_dff PC14(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notPC14),
        .Q(PC[14]),
        .notQ(notPC[14])
    );

    REGISTER_dff PC15(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_notPC15),
        .Q(PC[15]),
        .notQ(notPC[15])
    );

endmodule
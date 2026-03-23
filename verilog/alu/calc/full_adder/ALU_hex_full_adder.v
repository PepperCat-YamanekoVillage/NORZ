// (144)
module ALU_hex_full_adder(
        input wire [15:0] High,
        input wire [7:0] notHigh,
        input wire [15:0] Low,
        input wire [7:0] notLow,
        input wire C,
        input wire notC,
        output wire [15:0] SUM,
        output wire [7:0] AND,
        output wire [7:0] notOR,
        output wire [7:0] notXOR,
        output wire notCY4,
        output wire notCY8,
        output wire CY12,
        output wire CY16
    );

    // wire [7:0] notHigh = ~High[7:0];
    // wire [7:0] notLow = ~Low[7:0];
    // wire notC = ~C;

    wire _CY1;
    wire _notCY1;
    wire _CY2;
    wire _notCY2;
    wire _CY3;
    wire _notCY3;
    wire _CY4;
    wire _CY5;
    wire _notCY5;
    wire _CY6;
    wire _notCY6;
    wire _CY7;
    wire _notCY7;
    wire _CY8;
    wire _CY9;
    wire _CY10;
    wire _CY11;
    wire _CY13;
    wire _CY14;
    wire _CY15;

    ALU_bit_full_adder fa1(
        .High(High[0]),
        .notHigh(notHigh[0]),
        .Low(Low[0]),
        .notLow(notLow[0]),
        .Cin(C),
        .notCin(notC),
        .S(SUM[0]),
        .Cout(_CY1),
        .notCout(_notCY1),
        .AND(AND[0]),
        .notOR(notOR[0]),
        .notXOR(notXOR[0])
    );

    ALU_bit_full_adder fa2(
        .High(High[1]),
        .notHigh(notHigh[1]),
        .Low(Low[1]),
        .notLow(notLow[1]),
        .Cin(_CY1),
        .notCin(_notCY1),
        .S(SUM[1]),
        .Cout(_CY2),
        .notCout(_notCY2),
        .AND(AND[1]),
        .notOR(notOR[1]),
        .notXOR(notXOR[1])
    );

    ALU_bit_full_adder fa3(
        .High(High[2]),
        .notHigh(notHigh[2]),
        .Low(Low[2]),
        .notLow(notLow[2]),
        .Cin(_CY2),
        .notCin(_notCY2),
        .S(SUM[2]),
        .Cout(_CY3),
        .notCout(_notCY3),
        .AND(AND[2]),
        .notOR(notOR[2]),
        .notXOR(notXOR[2])
    );

    ALU_bit_full_adder fa4(
        .High(High[3]),
        .notHigh(notHigh[3]),
        .Low(Low[3]),
        .notLow(notLow[3]),
        .Cin(_CY3),
        .notCin(_notCY3),
        .S(SUM[3]),
        .Cout(_CY4),
        .notCout(notCY4),
        .AND(AND[3]),
        .notOR(notOR[3]),
        .notXOR(notXOR[3])
    );

    ALU_bit_full_adder fa5(
        .High(High[4]),
        .notHigh(notHigh[4]),
        .Low(Low[4]),
        .notLow(notLow[4]),
        .Cin(_CY4),
        .notCin(notCY4),
        .S(SUM[4]),
        .Cout(_CY5),
        .notCout(_notCY5),
        .AND(AND[4]),
        .notOR(notOR[4]),
        .notXOR(notXOR[4])
    );

    ALU_bit_full_adder fa6(
        .High(High[5]),
        .notHigh(notHigh[5]),
        .Low(Low[5]),
        .notLow(notLow[5]),
        .Cin(_CY5),
        .notCin(_notCY5),
        .S(SUM[5]),
        .Cout(_CY6),
        .notCout(_notCY6),
        .AND(AND[5]),
        .notOR(notOR[5]),
        .notXOR(notXOR[5])
    );

    ALU_bit_full_adder fa7(
        .High(High[6]),
        .notHigh(notHigh[6]),
        .Low(Low[6]),
        .notLow(notLow[6]),
        .Cin(_CY6),
        .notCin(_notCY6),
        .S(SUM[6]),
        .Cout(_CY7),
        .notCout(_notCY7),
        .AND(AND[6]),
        .notOR(notOR[6]),
        .notXOR(notXOR[6])
    );

    ALU_bit_full_adder fa8(
        .High(High[7]),
        .notHigh(notHigh[7]),
        .Low(Low[7]),
        .notLow(notLow[7]),
        .Cin(_CY7),
        .notCin(_notCY7),
        .S(SUM[7]),
        .Cout(_CY8),
        .notCout(notCY8),
        .AND(AND[7]),
        .notOR(notOR[7]),
        .notXOR(notXOR[7])
    );

    ALU_full_adder fa9(
        .High(High[8]),
        .Low(Low[8]),
        .Cin(_CY8),
        .S(SUM[8]),
        .Cout(_CY9)
    );

    ALU_full_adder fa10(
        .High(High[9]),
        .Low(Low[9]),
        .Cin(_CY9),
        .S(SUM[9]),
        .Cout(_CY10)
    );

    ALU_full_adder fa11(
        .High(High[10]),
        .Low(Low[10]),
        .Cin(_CY10),
        .S(SUM[10]),
        .Cout(_CY11)
    );

    ALU_full_adder fa12(
        .High(High[11]),
        .Low(Low[11]),
        .Cin(_CY11),
        .S(SUM[11]),
        .Cout(CY12)
    );

    ALU_full_adder fa13(
        .High(High[12]),
        .Low(Low[12]),
        .Cin(CY12),
        .S(SUM[12]),
        .Cout(_CY13)
    );

    ALU_full_adder fa14(
        .High(High[13]),
        .Low(Low[13]),
        .Cin(_CY13),
        .S(SUM[13]),
        .Cout(_CY14)
    );

    ALU_full_adder fa15(
        .High(High[14]),
        .Low(Low[14]),
        .Cin(_CY14),
        .S(SUM[14]),
        .Cout(_CY15)
    );

    ALU_full_adder fa16(
        .High(High[15]),
        .Low(Low[15]),
        .Cin(_CY15),
        .S(SUM[15]),
        .Cout(CY16)
    );

endmodule
// (80)
module INTERFACE_16bit_inc(
        input wire [15:0] notIn,
        input wire Cin,
        output wire [15:0] S
    );

    wire _CY0;
    wire _CY1;
    wire _CY2;
    wire _CY3;
    wire _CY4;
    wire _CY5;
    wire _CY6;
    wire _CY7;
    wire _CY8;
    wire _CY9;
    wire _CY10;
    wire _CY11;
    wire _CY12;
    wire _CY13;
    wire _CY14;

    INTERFACE_half_adder ha0(
        .notIn(notIn[0]),
        .Cin(Cin),
        .S(S[0]),
        .Cout(_CY0)
    );

    INTERFACE_half_adder ha1(
        .notIn(notIn[1]),
        .Cin(_CY0),
        .S(S[1]),
        .Cout(_CY1)
    );

    INTERFACE_half_adder ha2(
        .notIn(notIn[2]),
        .Cin(_CY1),
        .S(S[2]),
        .Cout(_CY2)
    );

    INTERFACE_half_adder ha3(
        .notIn(notIn[3]),
        .Cin(_CY2),
        .S(S[3]),
        .Cout(_CY3)
    );

    INTERFACE_half_adder ha4(
        .notIn(notIn[4]),
        .Cin(_CY3),
        .S(S[4]),
        .Cout(_CY4)
    );

    INTERFACE_half_adder ha5(
        .notIn(notIn[5]),
        .Cin(_CY4),
        .S(S[5]),
        .Cout(_CY5)
    );

    INTERFACE_half_adder ha6(
        .notIn(notIn[6]),
        .Cin(_CY5),
        .S(S[6]),
        .Cout(_CY6)
    );

    INTERFACE_half_adder ha7(
        .notIn(notIn[7]),
        .Cin(_CY6),
        .S(S[7]),
        .Cout(_CY7)
    );

    INTERFACE_half_adder ha8(
        .notIn(notIn[8]),
        .Cin(_CY7),
        .S(S[8]),
        .Cout(_CY8)
    );

    INTERFACE_half_adder ha9(
        .notIn(notIn[9]),
        .Cin(_CY8),
        .S(S[9]),
        .Cout(_CY9)
    );

    INTERFACE_half_adder ha10(
        .notIn(notIn[10]),
        .Cin(_CY9),
        .S(S[10]),
        .Cout(_CY10)
    );

    INTERFACE_half_adder ha11(
        .notIn(notIn[11]),
        .Cin(_CY10),
        .S(S[11]),
        .Cout(_CY11)
    );

    INTERFACE_half_adder ha12(
        .notIn(notIn[12]),
        .Cin(_CY11),
        .S(S[12]),
        .Cout(_CY12)
    );

    INTERFACE_half_adder ha13(
        .notIn(notIn[13]),
        .Cin(_CY12),
        .S(S[13]),
        .Cout(_CY13)
    );

    INTERFACE_half_adder ha14(
        .notIn(notIn[14]),
        .Cin(_CY13),
        .S(S[14]),
        .Cout(_CY14)
    );

    INTERFACE_half_adder ha15(
        .notIn(notIn[15]),
        .Cin(_CY14),
        .S(S[15])
    );

endmodule
// (64)
module REGISTER_16bit_inc(
        input wire [15:0] In,
        input wire [15:0] notIn,
        input wire CY,
        output wire [15:0] Out
    );

    // wire [15:0] notIn = ~In;

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

    REGISTER_half_adder_inc ha0(
        .In(In[0]),
        .notIn(notIn[0]),
        .Cin(CY),
        .S(Out[0]),
        .Cout(_CY0)
    );

    REGISTER_half_adder_inc ha1(
        .In(In[1]),
        .notIn(notIn[1]),
        .Cin(_CY0),
        .S(Out[1]),
        .Cout(_CY1)
    );

    REGISTER_half_adder_inc ha2(
        .In(In[2]),
        .notIn(notIn[2]),
        .Cin(_CY1),
        .S(Out[2]),
        .Cout(_CY2)
    );

    REGISTER_half_adder_inc ha3(
        .In(In[3]),
        .notIn(notIn[3]),
        .Cin(_CY2),
        .S(Out[3]),
        .Cout(_CY3)
    );

    REGISTER_half_adder_inc ha4(
        .In(In[4]),
        .notIn(notIn[4]),
        .Cin(_CY3),
        .S(Out[4]),
        .Cout(_CY4)
    );

    REGISTER_half_adder_inc ha5(
        .In(In[5]),
        .notIn(notIn[5]),
        .Cin(_CY4),
        .S(Out[5]),
        .Cout(_CY5)
    );

    REGISTER_half_adder_inc ha6(
        .In(In[6]),
        .notIn(notIn[6]),
        .Cin(_CY5),
        .S(Out[6]),
        .Cout(_CY6)
    );

    REGISTER_half_adder_inc ha7(
        .In(In[7]),
        .notIn(notIn[7]),
        .Cin(_CY6),
        .S(Out[7]),
        .Cout(_CY7)
    );

    REGISTER_half_adder_inc ha8(
        .In(In[8]),
        .notIn(notIn[8]),
        .Cin(_CY7),
        .S(Out[8]),
        .Cout(_CY8)
    );

    REGISTER_half_adder_inc ha9(
        .In(In[9]),
        .notIn(notIn[9]),
        .Cin(_CY8),
        .S(Out[9]),
        .Cout(_CY9)
    );

    REGISTER_half_adder_inc ha10(
        .In(In[10]),
        .notIn(notIn[10]),
        .Cin(_CY9),
        .S(Out[10]),
        .Cout(_CY10)
    );

    REGISTER_half_adder_inc ha11(
        .In(In[11]),
        .notIn(notIn[11]),
        .Cin(_CY10),
        .S(Out[11]),
        .Cout(_CY11)
    );

    REGISTER_half_adder_inc ha12(
        .In(In[12]),
        .notIn(notIn[12]),
        .Cin(_CY11),
        .S(Out[12]),
        .Cout(_CY12)
    );

    REGISTER_half_adder_inc ha13(
        .In(In[13]),
        .notIn(notIn[13]),
        .Cin(_CY12),
        .S(Out[13]),
        .Cout(_CY13)
    );

    REGISTER_half_adder_inc ha14(
        .In(In[14]),
        .notIn(notIn[14]),
        .Cin(_CY13),
        .S(Out[14]),
        .Cout(_CY14)
    );

    REGISTER_half_adder_inc ha15(
        .In(In[15]),
        .notIn(notIn[15]),
        .Cin(_CY14),
        .S(Out[15])
    );
    
endmodule
// (20)
module REGISTER_5bit_inc(
        input wire [4:0] In,
        input wire [4:0] notIn,
        input wire CY,
        output wire [4:0] Out
    );

    // wire [7:0] notIn = ~In;

    wire _CY0;
    wire _CY1;
    wire _CY2;
    wire _CY3;

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
        .S(Out[4])
    );

endmodule
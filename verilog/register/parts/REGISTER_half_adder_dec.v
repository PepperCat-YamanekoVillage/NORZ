// 4
module REGISTER_half_adder_dec(
        input wire In,
        input wire notIn,
        input wire notCin,
        output wire notS,
        output wire notCout
    );

    // wire notIn = ~In;

    // xor

    wire _Cin = notCin ~| notCin;

    wire _xor_p = In ~| _Cin;
    wire _xor_n = notIn ~| notCin;

    wire _xor = _xor_p ~| _xor_n;

    assign notCout = _xor_p;
    assign notS = _xor;

endmodule
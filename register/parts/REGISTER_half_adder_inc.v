// 4
module REGISTER_half_adder_inc(
        input wire In,
        input wire notIn,
        input wire Cin,
        output wire S,
        output wire Cout
    );

    // wire notIn = ~In;

    // xor

    wire _notCin = Cin ~| Cin;

    wire _xor_p = In ~| Cin;
    wire _xor_n = notIn ~| _notCin;

    wire _xor = _xor_p ~| _xor_n;

    assign S = _xor;
    assign Cout = _xor_n;

endmodule
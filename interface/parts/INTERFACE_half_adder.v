// 5
module INTERFACE_half_adder(
        input wire notIn,
        input wire Cin,
        output wire S,
        output wire Cout,
    );

    wire _In = notIn ~| notIn;
    wire _notCin = Cin ~| Cin;
    wire _xor_n = notIn ~| _notCin;
    wire _xor_p = _In ~| Cin;
    wire _xor = _xor_n ~| _xor_p;

    assign Cout = _xor_n;
    assign S = _xor;

endmodule
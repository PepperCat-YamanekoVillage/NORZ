// 9
module ALU_flag_isOverflow(
        input wire High,
        input wire notHigh,
        input wire ProcessedLow,
        input wire notProcessedLow,
        input wire Result,
        input wire notResult,
        output wire isOverflow
    );

    wire _Hxor0 = notHigh ~| notResult;
    wire _Hxor1 = High ~| Result;
    wire _Hxor = _Hxor0 ~| _Hxor1;
    wire _Lxor0 = notProcessedLow ~| notResult;
    wire _Lxor1 = ProcessedLow ~| Result;
    wire _Lxor = _Lxor0 ~| _Lxor1;

    wire _notHxor = _Hxor ~| _Hxor;
    wire _notLxor = _Lxor ~| _Lxor;

    assign isOverflow = _notHxor ~| _notLxor;

endmodule
module INTERFACE_D(
        input wire notPI_Activate_Dt,
        // 本当はinterfaceDt_inとinterfaceDt_outはinoutで同一だけどdigitalJSがエラーおこすので分けている
        input wire [7:0] interfaceDt_in,
        output wire [7:0] interfaceDt_out,
        input wire [7:0] selectedDt,
        output wire [7:0] Din
    );

    INTERFACE_74HC245 out(
        .nullify(notPI_Activate_Dt),
        .in(selectedDt),
        .out(interfaceDt_out)
    );

    // pullup接続
    assign Din = interfaceDt_in;

endmodule
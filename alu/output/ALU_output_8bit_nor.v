// 8
module ALU_output_8bit_nor(
        input wire [7:0] In,
        input wire P,
        output wire [7:0] Out
    );

    assign Out[0] = In[0] ~| P;
    assign Out[1] = In[1] ~| P;
    assign Out[2] = In[2] ~| P;
    assign Out[3] = In[3] ~| P;
    assign Out[4] = In[4] ~| P;
    assign Out[5] = In[5] ~| P;
    assign Out[6] = In[6] ~| P;
    assign Out[7] = In[7] ~| P;

endmodule
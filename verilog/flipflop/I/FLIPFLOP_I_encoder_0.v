// ばらしてデコーダーの近くに置くことになるかも
// nor省略!!
// 158
module FLIPFLOP_I_encoder_0(
        input wire P2_Set_ILDrn_C,        // 0001 0001
        input wire P2_Set_ILDrn_E,        // 0001 0011
        input wire P2_Set_ILDrn_L,        // 0001 0101
        input wire P2_Set_ILDrn_A,        // 0001 0111
        input wire P2_Set_ILDrlIXtdl_C,   // 0010 0001
        input wire P2_Set_ILDrlIXtdl_E,   // 0010 0011
        input wire P2_Set_ILDrlIXtdl_L,   // 0010 0101
        input wire P2_Set_ILDrlIXtdl_A,   // 0010 0111
        input wire P2_Set_ILDrlIYtdl_C,   // 0011 0001
        input wire P2_Set_ILDrlIYtdl_E,   // 0011 0011
        input wire P2_Set_ILDrlIYtdl_L,   // 0011 0101
        input wire P2_Set_ILDrlIYtdl_A,   // 0011 0111
        input wire P2_Set_ILDlIXtdlr_C,   // 0100 0001
        input wire P2_Set_ILDlIXtdlr_E,   // 0100 0011
        input wire P2_Set_ILDlIXtdlr_L,   // 0100 0101
        input wire P2_Set_ILDlIXtdlr_A,   // 0100 0111
        input wire P2_Set_ILDlIYtdlr_C,   // 0101 0001
        input wire P2_Set_ILDlIYtdlr_E,   // 0101 0011
        input wire P2_Set_ILDlIYtdlr_L,   // 0101 0101
        input wire P2_Set_ILDlIYtdlr_A,   // 0101 0111
        input wire P2_Set_ILDlHLln,       // 0000 0001
        input wire P2_Set_ILDlIXtdln_1,   // 1111 1011
        input wire P2_Set_ILDlIYtdln_1,   // 1111 1111
        input wire P2_Set_ILDAlnnl_1,     // 0000 0101
        input wire P2_Set_ILDlnnlA_1,     // 0000 1001
        input wire P2_Set_ILDddnn_DE_0,   // 0110 0001
        input wire P2_Set_ILDddnn_SP_0,   // 0110 0011
        input wire P2_Set_ILDddnn_DE_1,   // 0110 0101
        input wire P2_Set_ILDddnn_SP_1,   // 0110 0111
        input wire P2_Set_ILDIXnn_1,      // 0000 1011
        input wire P2_Set_ILDIYnn_1,      // 0000 1111
        input wire P2_Set_ILDHLlnnl_1,    // 0000 1101
        input wire P2_Set_ILDddlnnl_DE_0, // 0111 0001
        input wire P2_Set_ILDddlnnl_SP_0, // 0111 0011
        input wire P2_Set_ILDddlnnl_DE_1, // 0111 0101
        input wire P2_Set_ILDddlnnl_SP_1, // 0111 0111
        input wire P2_Set_ILDIXlnnl_1,    // 0001 1011
        input wire P2_Set_ILDIYlnnl_1,    // 0001 1111
        input wire P2_Set_ILDlnnlHL_1,    // 0000 0011
        input wire P2_Set_ILDlnnldd_DE_0, // 1000 0001
        input wire P2_Set_ILDlnnldd_SP_0, // 1000 0011
        input wire P2_Set_ILDlnnldd_DE_1, // 1000 0101
        input wire P2_Set_ILDlnnldd_SP_1, // 1000 0111
        input wire P2_Set_ILDlnnlIX_1,    // 0010 1011
        input wire P2_Set_ILDlnnlIY_1,    // 0010 1111
        input wire P2_Set_ISUBAn,         // 1111 0001
        input wire P2_Set_ISUBAlIXtdl,    // 1100 1001
        input wire P2_Set_ISUBAlIYtdl,    // 1101 1001
        input wire P2_Set_ISBCAn,         // 1111 0101
        input wire P2_Set_ISBCAlIXtdl,    // 1100 1101
        input wire P2_Set_ISBCAlIYtdl,    // 1101 1101
        input wire P2_Set_IORn,           // 1111 0011
        input wire P2_Set_IORlIXtdl,      // 1100 1011
        input wire P2_Set_IORlIYtdl,      // 1101 1011
        input wire P2_Set_ICPn,           // 1111 0111
        input wire P2_Set_ICPlIXtdl,      // 1100 1111
        input wire P2_Set_ICPlIYtdl,      // 1101 1111
        input wire P2_Set_IINClIYtdl,     // 1111 1001
        input wire P2_Set_IDEClIYtdl,     // 1111 1101
        input wire P2_Set_IJPnn_1,        // 0000 0111
        input wire P2_Set_IJPccnn_1_0,    // 0100 1001
        input wire P2_Set_IJPccnn_3_0,    // 0100 1011
        input wire P2_Set_IJPccnn_5_0,    // 0100 1101
        input wire P2_Set_IJPccnn_7_0,    // 0100 1111
        input wire P2_Set_IJPccnn_1_1,    // 0101 1001
        input wire P2_Set_IJPccnn_3_1,    // 0101 1011
        input wire P2_Set_IJPccnn_5_1,    // 0101 1101
        input wire P2_Set_IJPccnn_7_1,    // 0101 1111
        input wire P2_Set_IJRNCe,         // 0011 1011
        input wire P2_Set_IJRNZe,         // 0011 1111
        input wire P2_Set_ICALLnn_1,      // 0001 1101
        input wire P2_Set_IOUTlnlA,       // 0010 1001
        input wire P2_Set_ICALLnn_1_0,    // 1000 1001
        input wire P2_Set_ICALLnn_3_0,    // 1000 1011
        input wire P2_Set_ICALLnn_5_0,    // 1000 1101
        input wire P2_Set_ICALLnn_7_0,    // 1000 1111
        input wire P2_Set_ICALLnn_1_1,    // 1001 1001
        input wire P2_Set_ICALLnn_3_1,    // 1001 1011
        input wire P2_Set_ICALLnn_5_1,    // 1001 1101
        input wire P2_Set_ICALLnn_7_1,    // 1001 1111
        output wire encoded0
    );

    // or

    assign encoded0 = (P2_Set_ILDrn_C | P2_Set_ILDrn_E | P2_Set_ILDrn_L | P2_Set_ILDrn_A | P2_Set_ILDrlIXtdl_C | P2_Set_ILDrlIXtdl_E | P2_Set_ILDrlIXtdl_L | P2_Set_ILDrlIXtdl_A | P2_Set_ILDrlIYtdl_C | P2_Set_ILDrlIYtdl_E | P2_Set_ILDrlIYtdl_L | P2_Set_ILDrlIYtdl_A | P2_Set_ILDlIXtdlr_C | P2_Set_ILDlIXtdlr_E | P2_Set_ILDlIXtdlr_L | P2_Set_ILDlIXtdlr_A | P2_Set_ILDlIYtdlr_C | P2_Set_ILDlIYtdlr_E | P2_Set_ILDlIYtdlr_L | P2_Set_ILDlIYtdlr_A | P2_Set_ILDlHLln | P2_Set_ILDlIXtdln_1 | P2_Set_ILDlIYtdln_1 | P2_Set_ILDAlnnl_1 | P2_Set_ILDlnnlA_1 | P2_Set_ILDddnn_DE_0 | P2_Set_ILDddnn_SP_0 | P2_Set_ILDddnn_DE_1 | P2_Set_ILDddnn_SP_1 | P2_Set_ILDIXnn_1 | P2_Set_ILDIYnn_1 | P2_Set_ILDHLlnnl_1 | P2_Set_ILDddlnnl_DE_0 | P2_Set_ILDddlnnl_SP_0 | P2_Set_ILDddlnnl_DE_1 | P2_Set_ILDddlnnl_SP_1 | P2_Set_ILDIXlnnl_1 | P2_Set_ILDIYlnnl_1 | P2_Set_ILDlnnlHL_1 | P2_Set_ILDlnnldd_DE_0 | P2_Set_ILDlnnldd_SP_0 | P2_Set_ILDlnnldd_DE_1 | P2_Set_ILDlnnldd_SP_1 | P2_Set_ILDlnnlIX_1 | P2_Set_ILDlnnlIY_1 | P2_Set_ISUBAn | P2_Set_ISUBAlIXtdl | P2_Set_ISUBAlIYtdl | P2_Set_ISBCAn | P2_Set_ISBCAlIXtdl | P2_Set_ISBCAlIYtdl | P2_Set_IORn | P2_Set_IORlIXtdl | P2_Set_IORlIYtdl | P2_Set_ICPn | P2_Set_ICPlIXtdl | P2_Set_ICPlIYtdl | P2_Set_IINClIYtdl | P2_Set_IDEClIYtdl | P2_Set_IJPnn_1 | P2_Set_IJPccnn_1_0 | P2_Set_IJPccnn_3_0 | P2_Set_IJPccnn_5_0 | P2_Set_IJPccnn_7_0 | P2_Set_IJPccnn_1_1 | P2_Set_IJPccnn_3_1 | P2_Set_IJPccnn_5_1 | P2_Set_IJPccnn_7_1 | P2_Set_IJRNCe | P2_Set_IJRNZe | P2_Set_ICALLnn_1 | P2_Set_IOUTlnlA | P2_Set_ICALLnn_1_0 | P2_Set_ICALLnn_3_0 | P2_Set_ICALLnn_5_0 | P2_Set_ICALLnn_7_0 | P2_Set_ICALLnn_1_1 | P2_Set_ICALLnn_3_1 | P2_Set_ICALLnn_5_1 | P2_Set_ICALLnn_7_1); 

endmodule
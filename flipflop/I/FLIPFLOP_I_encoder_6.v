// ばらしてデコーダーの近くに置くことになるかも
// nor省略!!
// 154
module FLIPFLOP_I_encoder_6(
        input wire P2_Set_ILDlIXtdlr_B,   // 0100 0000
        input wire P2_Set_ILDlIXtdlr_C,   // 0100 0001
        input wire P2_Set_ILDlIXtdlr_D,   // 0100 0010
        input wire P2_Set_ILDlIXtdlr_E,   // 0100 0011
        input wire P2_Set_ILDlIXtdlr_H,   // 0100 0100
        input wire P2_Set_ILDlIXtdlr_L,   // 0100 0101
        input wire P2_Set_ILDlIXtdlr_A,   // 0100 0111
        input wire P2_Set_ILDlIYtdlr_B,   // 0101 0000
        input wire P2_Set_ILDlIYtdlr_C,   // 0101 0001
        input wire P2_Set_ILDlIYtdlr_D,   // 0101 0010
        input wire P2_Set_ILDlIYtdlr_E,   // 0101 0011
        input wire P2_Set_ILDlIYtdlr_H,   // 0101 0100
        input wire P2_Set_ILDlIYtdlr_L,   // 0101 0101
        input wire P2_Set_ILDlIYtdlr_A,   // 0101 0111
        input wire P2_Set_ILDlIXtdln_0,   // 1111 1010
        input wire P2_Set_ILDlIXtdln_1,   // 1111 1011
        input wire P2_Set_ILDlIYtdln_0,   // 1111 1110
        input wire P2_Set_ILDlIYtdln_1,   // 1111 1111
        input wire P2_Set_ILDddnn_BC_0,   // 0110 0000
        input wire P2_Set_ILDddnn_DE_0,   // 0110 0001
        input wire P2_Set_ILDddnn_HL_0,   // 0110 0010
        input wire P2_Set_ILDddnn_SP_0,   // 0110 0011
        input wire P2_Set_ILDddnn_BC_1,   // 0110 0100
        input wire P2_Set_ILDddnn_DE_1,   // 0110 0101
        input wire P2_Set_ILDddnn_HL_1,   // 0110 0110
        input wire P2_Set_ILDddnn_SP_1,   // 0110 0111
        input wire P2_Set_ILDddlnnl_BC_0, // 0111 0000
        input wire P2_Set_ILDddlnnl_DE_0, // 0111 0001
        input wire P2_Set_ILDddlnnl_HL_0, // 0111 0010
        input wire P2_Set_ILDddlnnl_SP_0, // 0111 0011
        input wire P2_Set_ILDddlnnl_BC_1, // 0111 0100
        input wire P2_Set_ILDddlnnl_DE_1, // 0111 0101
        input wire P2_Set_ILDddlnnl_HL_1, // 0111 0110
        input wire P2_Set_ILDddlnnl_SP_1, // 0111 0111
        input wire P2_Set_IADDAn,         // 1111 0000
        input wire P2_Set_IADDAlIXtdl,    // 1100 1000
        input wire P2_Set_IADDAlIYtdl,    // 1101 1000
        input wire P2_Set_IADCAn,         // 1111 0100
        input wire P2_Set_IADCAlIXtdl,    // 1100 1100
        input wire P2_Set_IADCAlIYtdl,    // 1101 1100
        input wire P2_Set_ISUBAn,         // 1111 0001
        input wire P2_Set_ISUBAlIXtdl,    // 1100 1001
        input wire P2_Set_ISUBAlIYtdl,    // 1101 1001
        input wire P2_Set_ISBCAn,         // 1111 0101
        input wire P2_Set_ISBCAlIXtdl,    // 1100 1101
        input wire P2_Set_ISBCAlIYtdl,    // 1101 1101
        input wire P2_Set_IANDn,          // 1111 0010
        input wire P2_Set_IANDlIXtdl,     // 1100 1010
        input wire P2_Set_IANDlIYtdl,     // 1101 1010
        input wire P2_Set_IORn,           // 1111 0011
        input wire P2_Set_IORlIXtdl,      // 1100 1011
        input wire P2_Set_IORlIYtdl,      // 1101 1011
        input wire P2_Set_IXORn,          // 1111 0110
        input wire P2_Set_IXORlIXtdl,     // 1100 1110
        input wire P2_Set_IXORlIYtdl,     // 1101 1110
        input wire P2_Set_ICPn,           // 1111 0111
        input wire P2_Set_ICPlIXtdl,      // 1100 1111
        input wire P2_Set_ICPlIYtdl,      // 1101 1111
        input wire P2_Set_IINClIXtdl,     // 1111 1000
        input wire P2_Set_IINClIYtdl,     // 1111 1001
        input wire P2_Set_IDEClIXtdl,     // 1111 1100
        input wire P2_Set_IDEClIYtdl,     // 1111 1101
        input wire P2_Set_IJPccnn_0_0,    // 0100 1000
        input wire P2_Set_IJPccnn_1_0,    // 0100 1001
        input wire P2_Set_IJPccnn_2_0,    // 0100 1010
        input wire P2_Set_IJPccnn_3_0,    // 0100 1011
        input wire P2_Set_IJPccnn_4_0,    // 0100 1100
        input wire P2_Set_IJPccnn_5_0,    // 0100 1101
        input wire P2_Set_IJPccnn_6_0,    // 0100 1110
        input wire P2_Set_IJPccnn_7_0,    // 0100 1111
        input wire P2_Set_IJPccnn_0_1,    // 0101 1000
        input wire P2_Set_IJPccnn_1_1,    // 0101 1001
        input wire P2_Set_IJPccnn_2_1,    // 0101 1010
        input wire P2_Set_IJPccnn_3_1,    // 0101 1011
        input wire P2_Set_IJPccnn_4_1,    // 0101 1100
        input wire P2_Set_IJPccnn_5_1,    // 0101 1101
        input wire P2_Set_IJPccnn_6_1,    // 0101 1110
        input wire P2_Set_IJPccnn_7_1,    // 0101 1111
        output wire encoded6
    );

    // or

    assign encoded6 = (P2_Set_ILDlIXtdlr_B | P2_Set_ILDlIXtdlr_C | P2_Set_ILDlIXtdlr_D | P2_Set_ILDlIXtdlr_E | P2_Set_ILDlIXtdlr_H | P2_Set_ILDlIXtdlr_L | P2_Set_ILDlIXtdlr_A | P2_Set_ILDlIYtdlr_B | P2_Set_ILDlIYtdlr_C | P2_Set_ILDlIYtdlr_D | P2_Set_ILDlIYtdlr_E | P2_Set_ILDlIYtdlr_H | P2_Set_ILDlIYtdlr_L | P2_Set_ILDlIYtdlr_A | P2_Set_ILDlIXtdln_0 | P2_Set_ILDlIXtdln_1 | P2_Set_ILDlIYtdln_0 | P2_Set_ILDlIYtdln_1 | P2_Set_ILDddnn_BC_0 | P2_Set_ILDddnn_DE_0 | P2_Set_ILDddnn_HL_0 | P2_Set_ILDddnn_SP_0 | P2_Set_ILDddnn_BC_1 | P2_Set_ILDddnn_DE_1 | P2_Set_ILDddnn_HL_1 | P2_Set_ILDddnn_SP_1 | P2_Set_ILDddlnnl_BC_0 | P2_Set_ILDddlnnl_DE_0 | P2_Set_ILDddlnnl_HL_0 | P2_Set_ILDddlnnl_SP_0 | P2_Set_ILDddlnnl_BC_1 | P2_Set_ILDddlnnl_DE_1 | P2_Set_ILDddlnnl_HL_1 | P2_Set_ILDddlnnl_SP_1 | P2_Set_IADDAn | P2_Set_IADDAlIXtdl | P2_Set_IADDAlIYtdl | P2_Set_IADCAn | P2_Set_IADCAlIXtdl | P2_Set_IADCAlIYtdl | P2_Set_ISUBAn | P2_Set_ISUBAlIXtdl | P2_Set_ISUBAlIYtdl | P2_Set_ISBCAn | P2_Set_ISBCAlIXtdl | P2_Set_ISBCAlIYtdl | P2_Set_IANDn | P2_Set_IANDlIXtdl | P2_Set_IANDlIYtdl | P2_Set_IORn | P2_Set_IORlIXtdl | P2_Set_IORlIYtdl | P2_Set_IXORn | P2_Set_IXORlIXtdl | P2_Set_IXORlIYtdl | P2_Set_ICPn | P2_Set_ICPlIXtdl | P2_Set_ICPlIYtdl | P2_Set_IINClIXtdl | P2_Set_IINClIYtdl | P2_Set_IDEClIXtdl | P2_Set_IDEClIYtdl | P2_Set_IJPccnn_0_0 | P2_Set_IJPccnn_1_0 | P2_Set_IJPccnn_2_0 | P2_Set_IJPccnn_3_0 | P2_Set_IJPccnn_4_0 | P2_Set_IJPccnn_5_0 | P2_Set_IJPccnn_6_0 | P2_Set_IJPccnn_7_0 | P2_Set_IJPccnn_0_1 | P2_Set_IJPccnn_1_1 | P2_Set_IJPccnn_2_1 | P2_Set_IJPccnn_3_1 | P2_Set_IJPccnn_4_1 | P2_Set_IJPccnn_5_1 | P2_Set_IJPccnn_6_1 | P2_Set_IJPccnn_7_1);

endmodule
// Created by ihdl
`timescale 1ns/10ps

`celldefine

module PVDD3A (AVDD,TAVDD,VSS);
   inout VSS;
    inout   AVDD,TAVDD;
    tran (AVDD,TAVDD);
endmodule

`endcelldefine

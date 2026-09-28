// Created by ihdl
`timescale 1ns/10ps

`celldefine

module PVDD3AC (AVDD,TACVDD,VSS);
   inout VSS;
    inout   AVDD,TACVDD;
    tran (AVDD,TACVDD);
endmodule

`endcelldefine

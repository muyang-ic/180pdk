// Created by ihdl
`timescale 1ns/10ps

`celldefine

module PVSS3A (TAVDD,AVSS,VSS);
   inout TAVDD,VSS;
    inout   AVSS;
    tran (AVSS,AVSS);
endmodule

`endcelldefine

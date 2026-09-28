// Created by ihdl
`timescale 1ns/10ps

`celldefine

module PVSS3AC (TACVDD,AVSS,VSS);
   inout TACVDD,VSS;
    inout   AVSS;
    tran (AVSS,AVSS);
endmodule

`endcelldefine

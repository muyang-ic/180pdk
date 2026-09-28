// Created by ihdl
`timescale 1ns/10ps

`celldefine

module PDB1AC (TACVDD,VSS,AIO);
   inout TACVDD,VSS;
   inout AIO;
   tran (AIO,AIO);
endmodule

`endcelldefine

// Created by ihdl
`timescale 1ns/10ps

`celldefine

module PDB3A (TAVDD,VSS,AIO);
   inout TAVDD,VSS;
   inout AIO;
   tran (AIO,AIO);
endmodule

`endcelldefine

// Created by ihdl
`timescale 1ns/1ps

`celldefine

module TIELBWP7T (ZN, VDD, VSS);
  output  ZN;
   inout VDD, VSS;
  buf (ZN, 1'b0);

endmodule

`endcelldefine

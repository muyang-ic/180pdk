// Created by ihdl
`timescale 1ns/1ps

`celldefine

module TIEHBWP7T (Z, VDD, VSS);
  output  Z;
   inout VDD, VSS;
  buf (Z, 1'b1);

endmodule

`endcelldefine

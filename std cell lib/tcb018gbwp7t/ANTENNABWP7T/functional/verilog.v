// Created by ihdl
`timescale 1ns/1ps

`celldefine

module ANTENNABWP7T (I, VDD, VSS);
  input I;
   inout VDD, VSS;
  buf (I_buf, I);

endmodule

`endcelldefine

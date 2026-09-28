// Created by ihdl
`timescale 1ns/10ps

`celldefine

module ANTENNA (I, VDD, VSS);
  input I;
   inout VDD, VSS;
  buf (I_buf, I);

endmodule

`endcelldefine

// Created by ihdl
`timescale 1ns/10ps

`celldefine

module TIEH (Z, VDD, VSS);
  output  Z;
   inout VDD, VSS;
  buf (Z, 1'b1);

endmodule

`endcelldefine

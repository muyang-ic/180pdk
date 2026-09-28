// Created by ihdl
`timescale 1ns/10ps

`celldefine

module TIEL (ZN, VDD, VSS);
  output  ZN;
   inout VDD, VSS;
  buf (ZN, 1'b0);

endmodule

`endcelldefine

// Created by ihdl
`timescale 1ns/1ps

`celldefine

module BUFFD3BWP7T (I, Z, VDD, VSS);
    input I;
    output Z;
   inout VDD, VSS;
    buf		(Z, I);

  specify
    (I => Z) = (0, 0);
  endspecify
endmodule

`endcelldefine

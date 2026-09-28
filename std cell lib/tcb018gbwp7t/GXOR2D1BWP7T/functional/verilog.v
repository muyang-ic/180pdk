// Created by ihdl
`timescale 1ns/1ps

`celldefine

module GXOR2D1BWP7T (A1, A2, Z, VDD, VSS);
  input 	A1, A2;
  output 	Z;
   inout VDD, VSS;
  xor		(Z, A1, A2);

  specify
    if (A2 == 1'b0)
    (A1 => Z) = (0, 0);
    if (A2 == 1'b1)
    (A1 => Z) = (0, 0);
    ifnone (A1 => Z) = (0, 0);
    if (A1 == 1'b0)
    (A2 => Z) = (0, 0);
    if (A1 == 1'b1)
    (A2 => Z) = (0, 0);
    ifnone (A2 => Z) = (0, 0);
  endspecify
endmodule

`endcelldefine

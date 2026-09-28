// Created by ihdl
`timescale 1ns/1ps

`celldefine

module HA1D0BWP7T (A, B, S, CO, VDD, VSS);
  input	 	A, B;
  output	S, CO;
   inout VDD, VSS;
  xor		(S, A, B);
  and		(CO, A, B);

  specify
    (A => CO) = (0, 0);
    (B => CO) = (0, 0);
    if (B == 1'b0)
    (A => S) = (0, 0);
    if (B == 1'b1)
    (A => S) = (0, 0);
    ifnone (A => S) = (0, 0);
    if (A == 1'b0)
    (B => S) = (0, 0);
    if (A == 1'b1)
    (B => S) = (0, 0);
    ifnone (B => S) = (0, 0);
  endspecify
endmodule

`endcelldefine

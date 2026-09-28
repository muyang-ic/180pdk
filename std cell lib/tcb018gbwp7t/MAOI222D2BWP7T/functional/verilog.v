// Created by ihdl
`timescale 1ns/1ps

`celldefine

module MAOI222D2BWP7T (A, B, C, ZN, VDD, VSS);
    input A, B, C;
    output ZN;
   inout VDD, VSS;
    and		(AB, A, B);
    and		(AC, A, C);
    and		(BC, B, C);
    nor		(ZN, AB, AC, BC);

  specify
    if (B == 1'b1 && C == 1'b0)
    (A => ZN) = (0, 0);
    if (B == 1'b0 && C == 1'b1)
    (A => ZN) = (0, 0);
    ifnone (A => ZN) = (0, 0);
    if (A == 1'b1 && C == 1'b0)
    (B => ZN) = (0, 0);
    if (A == 1'b0 && C == 1'b1)
    (B => ZN) = (0, 0);
    ifnone (B => ZN) = (0, 0);
    if (A == 1'b1 && B == 1'b0)
    (C => ZN) = (0, 0);
    if (A == 1'b0 && B == 1'b1)
    (C => ZN) = (0, 0);
    ifnone (C => ZN) = (0, 0);
  endspecify
endmodule

`endcelldefine

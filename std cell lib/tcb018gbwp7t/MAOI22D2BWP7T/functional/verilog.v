// Created by ihdl
`timescale 1ns/1ps

`celldefine

module MAOI22D2BWP7T (A1, A2, B1, B2, ZN, VDD, VSS);
    input A1, A2, B1, B2;
    output ZN;
   inout VDD, VSS;
    and		(A, A1, A2);
    nor		(B, B1, B2);
    nor		(ZN, A, B);

  specify
    if (A2 == 1'b1 && B1 == 1'b1 && B2 == 1'b1)
    (A1 => ZN) = (0, 0);
    if (A2 == 1'b1 && B1 == 1'b1 && B2 == 1'b0)
    (A1 => ZN) = (0, 0);
    if (A2 == 1'b1 && B1 == 1'b0 && B2 == 1'b1)
    (A1 => ZN) = (0, 0);
    ifnone (A1 => ZN) = (0, 0);
    if (A1 == 1'b1 && B1 == 1'b1 && B2 == 1'b1)
    (A2 => ZN) = (0, 0);
    if (A1 == 1'b1 && B1 == 1'b1 && B2 == 1'b0)
    (A2 => ZN) = (0, 0);
    if (A1 == 1'b1 && B1 == 1'b0 && B2 == 1'b1)
    (A2 => ZN) = (0, 0);
    ifnone (A2 => ZN) = (0, 0);
    if (A1 == 1'b1 && A2 == 1'b0 && B2 == 1'b0)
    (B1 => ZN) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b1 && B2 == 1'b0)
    (B1 => ZN) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b0 && B2 == 1'b0)
    (B1 => ZN) = (0, 0);
    ifnone (B1 => ZN) = (0, 0);
    if (A1 == 1'b1 && A2 == 1'b0 && B1 == 1'b0)
    (B2 => ZN) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b1 && B1 == 1'b0)
    (B2 => ZN) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b0 && B1 == 1'b0)
    (B2 => ZN) = (0, 0);
    ifnone (B2 => ZN) = (0, 0);
  endspecify
endmodule

`endcelldefine

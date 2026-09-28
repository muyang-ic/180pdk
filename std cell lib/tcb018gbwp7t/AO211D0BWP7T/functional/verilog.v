// Created by ihdl
`timescale 1ns/1ps

`celldefine

module AO211D0BWP7T (A1, A2, B, C, Z, VDD, VSS);
    input A1, A2, B, C;
    output Z;
   inout VDD, VSS;
    and		(A, A1, A2);
    or		(Z, A, B, C);

  specify
    (A1 => Z) = (0, 0);
    (A2 => Z) = (0, 0);
    if (A1 == 1'b1 && A2 == 1'b0 && C == 1'b0)
    (B => Z) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b1 && C == 1'b0)
    (B => Z) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b0 && C == 1'b0)
    (B => Z) = (0, 0);
    ifnone (B => Z) = (0, 0);
    if (A1 == 1'b1 && A2 == 1'b0 && B == 1'b0)
    (C => Z) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b1 && B == 1'b0)
    (C => Z) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b0 && B == 1'b0)
    (C => Z) = (0, 0);
    ifnone (C => Z) = (0, 0);
  endspecify
endmodule

`endcelldefine

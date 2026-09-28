// Created by ihdl
`timescale 1ns/10ps

`celldefine

module AO22D2 (A1, A2, B1, B2, Z, VDD, VSS);
    input A1, A2, B1, B2;
    output Z;
   inout VDD, VSS;
    and		(A, A1, A2);
    and     (B, B1, B2);
    or		(Z, A, B);

  specify
    if (A2 == 1'b1 && B1 == 1'b1 && B2 == 1'b0)
    (A1 => Z) = (0, 0);
    if (A2 == 1'b1 && B1 == 1'b0 && B2 == 1'b1)
    (A1 => Z) = (0, 0);
    if (A2 == 1'b1 && B1 == 1'b0 && B2 == 1'b0)
    (A1 => Z) = (0, 0);
    ifnone (A1 => Z) = (0, 0);
    if (A1 == 1'b1 && B1 == 1'b1 && B2 == 1'b0)
    (A2 => Z) = (0, 0);
    if (A1 == 1'b1 && B1 == 1'b0 && B2 == 1'b1)
    (A2 => Z) = (0, 0);
    if (A1 == 1'b1 && B1 == 1'b0 && B2 == 1'b0)
    (A2 => Z) = (0, 0);
    ifnone (A2 => Z) = (0, 0);
    if (A1 == 1'b1 && A2 == 1'b0 && B2 == 1'b1)
    (B1 => Z) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b1 && B2 == 1'b1)
    (B1 => Z) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b0 && B2 == 1'b1)
    (B1 => Z) = (0, 0);
    ifnone (B1 => Z) = (0, 0);
    if (A1 == 1'b1 && A2 == 1'b0 && B1 == 1'b1)
    (B2 => Z) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b1 && B1 == 1'b1)
    (B2 => Z) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b0 && B1 == 1'b1)
    (B2 => Z) = (0, 0);
    ifnone (B2 => Z) = (0, 0);
  endspecify
endmodule

`endcelldefine

// Created by ihdl
`timescale 1ns/1ps

`celldefine

module OA21D1BWP7T (A1, A2, B, Z, VDD, VSS);
    input A1, A2, B;
    output Z;
   inout VDD, VSS;
    or		(A, A1, A2);
    and		(Z, A, B);

  specify
    (A1 => Z) = (0, 0);
    (A2 => Z) = (0, 0);
    if (A1 == 1'b1 && A2 == 1'b1)
    (B => Z) = (0, 0);
    if (A1 == 1'b1 && A2 == 1'b0)
    (B => Z) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b1)
    (B => Z) = (0, 0);
    ifnone (B => Z) = (0, 0);
  endspecify
endmodule

`endcelldefine

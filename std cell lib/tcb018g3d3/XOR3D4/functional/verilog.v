// Created by ihdl
`timescale 1ns/10ps

`celldefine

module XOR3D4 (A1, A2, A3, Z, VDD, VSS);
  input A1, A2, A3;
  output Z;
   inout VDD, VSS;
  xor		(Z, A1, A2, A3);

  specify
    if (A2 == 1'b1 && A3 == 1'b1)
    (A1 => Z) = (0, 0);
    if (A2 == 1'b0 && A3 == 1'b0)
    (A1 => Z) = (0, 0);
    if (A2 == 1'b1 && A3 == 1'b0)
    (A1 => Z) = (0, 0);
    if (A2 == 1'b0 && A3 == 1'b1)
    (A1 => Z) = (0, 0);
    ifnone (A1 => Z) = (0, 0);
    if (A1 == 1'b1 && A3 == 1'b1)
    (A2 => Z) = (0, 0);
    if (A1 == 1'b0 && A3 == 1'b0)
    (A2 => Z) = (0, 0);
    if (A1 == 1'b1 && A3 == 1'b0)
    (A2 => Z) = (0, 0);
    if (A1 == 1'b0 && A3 == 1'b1)
    (A2 => Z) = (0, 0);
    ifnone (A2 => Z) = (0, 0);
    if (A1 == 1'b1 && A2 == 1'b1)
    (A3 => Z) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b0)
    (A3 => Z) = (0, 0);
    if (A1 == 1'b1 && A2 == 1'b0)
    (A3 => Z) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b1)
    (A3 => Z) = (0, 0);
    ifnone (A3 => Z) = (0, 0);
  endspecify
endmodule

`endcelldefine

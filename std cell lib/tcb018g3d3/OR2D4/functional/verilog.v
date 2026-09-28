// Created by ihdl
`timescale 1ns/10ps

`celldefine

module OR2D4 (A1, A2, Z, VDD, VSS);
    input A1, A2;
    output Z;
   inout VDD, VSS;
    or		(Z, A1, A2);

  specify
    (A1 => Z) = (0, 0);
    (A2 => Z) = (0, 0);
  endspecify
endmodule

`endcelldefine

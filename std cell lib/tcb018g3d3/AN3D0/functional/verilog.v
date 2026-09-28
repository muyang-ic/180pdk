// Created by ihdl
`timescale 1ns/10ps

`celldefine

module AN3D0 (A1, A2, A3, Z, VDD, VSS);
    input A1, A2, A3;
    output Z;
   inout VDD, VSS;
    and		(Z, A1, A2, A3);

  specify
    (A1 => Z) = (0, 0);
    (A2 => Z) = (0, 0);
    (A3 => Z) = (0, 0);
  endspecify
endmodule

`endcelldefine

// Created by ihdl
`timescale 1ns/10ps

`celldefine

module NR2D2 (A1, A2, ZN, VDD, VSS);
    input A1, A2;
    output ZN;
   inout VDD, VSS;
    nor		(ZN, A1, A2);

  specify
    (A1 => ZN) = (0, 0);
    (A2 => ZN) = (0, 0);
  endspecify
endmodule

`endcelldefine

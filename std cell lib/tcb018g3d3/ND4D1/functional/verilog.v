// Created by ihdl
`timescale 1ns/10ps

`celldefine

module ND4D1 (A1, A2, A3, A4, ZN, VDD, VSS);
    input A1, A2, A3, A4;
    output ZN;
   inout VDD, VSS;
    nand		(ZN, A1, A2, A3, A4);

  specify
    (A1 => ZN) = (0, 0);
    (A2 => ZN) = (0, 0);
    (A3 => ZN) = (0, 0);
    (A4 => ZN) = (0, 0);
  endspecify
endmodule

`endcelldefine

// Created by ihdl
`timescale 1ns/10ps

`celldefine

module IND4D0 (A1, B1, B2, B3, ZN, VDD, VSS);
    input A1, B1, B2, B3;
    output ZN;
   inout VDD, VSS;
    not		    (A1N, A1);
    nand		(ZN, A1N, B1, B2, B3);

  specify
    (A1 => ZN) = (0, 0);
    (B1 => ZN) = (0, 0);
    (B2 => ZN) = (0, 0);
    (B3 => ZN) = (0, 0);
  endspecify
endmodule

`endcelldefine

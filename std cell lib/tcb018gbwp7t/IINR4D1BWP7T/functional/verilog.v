// Created by ihdl
`timescale 1ns/1ps

`celldefine

module IINR4D1BWP7T (A1, A2, B1, B2, ZN, VDD, VSS);
    input A1, A2, B1, B2;
    output ZN;
   inout VDD, VSS;
    not		(A1N, A1);
    not     (A2N, A2);
    nor		(ZN, A1N, A2N, B1, B2);

  specify
    (A1 => ZN) = (0, 0);
    (A2 => ZN) = (0, 0);
    (B1 => ZN) = (0, 0);
    (B2 => ZN) = (0, 0);
  endspecify
endmodule

`endcelldefine

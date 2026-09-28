// Created by ihdl
`timescale 1ns/1ps

`celldefine

module NR4D1BWP7T (A1, A2, A3, A4, ZN, VDD, VSS);
    input A1, A2, A3, A4;
    output ZN;
   inout VDD, VSS;
    nor		(ZN, A1, A2, A3, A4);

  specify
    (A1 => ZN) = (0, 0);
    (A2 => ZN) = (0, 0);
    (A3 => ZN) = (0, 0);
    (A4 => ZN) = (0, 0);
  endspecify
endmodule

`endcelldefine

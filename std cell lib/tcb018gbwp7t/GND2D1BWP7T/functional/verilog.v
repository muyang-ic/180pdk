// Created by ihdl
`timescale 1ns/1ps

`celldefine

module GND2D1BWP7T (A1, A2, ZN, VDD, VSS);
    input A1, A2;
    output ZN;
   inout VDD, VSS;
    nand		(ZN, A1, A2);

  specify
    (A1 => ZN) = (0, 0);
    (A2 => ZN) = (0, 0);
  endspecify
endmodule

`endcelldefine

// Created by ihdl
`timescale 1ns/1ps

`celldefine

module INR3D1BWP7T (A1, B1, B2, ZN, VDD, VSS);
    input A1, B1, B2;
    output ZN;
   inout VDD, VSS;
    not		(A1N, A1);
    nor		(ZN, A1N, B1, B2);

  specify
    (A1 => ZN) = (0, 0);
    (B1 => ZN) = (0, 0);
    (B2 => ZN) = (0, 0);
  endspecify
endmodule

`endcelldefine

// Created by ihdl
`timescale 1ns/1ps

`celldefine

module CKMUX2D2BWP7T (I0, I1, S, Z, VDD, VSS);
   input I0, I1, S;
   output Z;
   inout VDD, VSS;
   tsmc_mux (Z, I0, I1, S);

  specify
    if (I1 == 1'b1 && S == 1'b0)
    (I0 => Z) = (0, 0);
    if (I1 == 1'b0 && S == 1'b0)
    (I0 => Z) = (0, 0);
    ifnone (I0 => Z) = (0, 0);
    if (I0 == 1'b1 && S == 1'b1)
    (I1 => Z) = (0, 0);
    if (I0 == 1'b0 && S == 1'b1)
    (I1 => Z) = (0, 0);
    ifnone (I1 => Z) = (0, 0);
    if (I0 == 1'b0 && I1 == 1'b1)
    (S => Z) = (0, 0);
    if (I0 == 1'b1 && I1 == 1'b0)
    (S => Z) = (0, 0);
    ifnone (S => Z) = (0, 0);
  endspecify
endmodule

`endcelldefine

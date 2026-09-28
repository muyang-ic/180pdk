// Created by ihdl
`timescale 1ns/1ps

`celldefine

module GMUX2ND2BWP7T (I0, I1, S, ZN, VDD, VSS);
   input I0, I1, S;
   output ZN;
   inout VDD, VSS;
   tsmc_mux (I0_out, I0, I1, S);
   not (ZN, I0_out);

  specify
    if (I1 == 1'b1 && S == 1'b0)
    (I0 => ZN) = (0, 0);
    if (I1 == 1'b0 && S == 1'b0)
    (I0 => ZN) = (0, 0);
    ifnone (I0 => ZN) = (0, 0);
    if (I0 == 1'b1 && S == 1'b1)
    (I1 => ZN) = (0, 0);
    if (I0 == 1'b0 && S == 1'b1)
    (I1 => ZN) = (0, 0);
    ifnone (I1 => ZN) = (0, 0);
    if (I0 == 1'b1 && I1 == 1'b0)
    (S => ZN) = (0, 0);
    if (I0 == 1'b0 && I1 == 1'b1)
    (S => ZN) = (0, 0);
    ifnone (S => ZN) = (0, 0);
  endspecify
endmodule

`endcelldefine

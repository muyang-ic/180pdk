// Created by ihdl
`timescale 1ns/1ps

`celldefine

module AOI211D1BWP7T (A1, A2, B, C, ZN, VDD, VSS);
    input A1, A2, B, C;
    output ZN;
   inout VDD, VSS;
    and		(A, A1, A2);
    nor		(ZN, A, B, C);

  specify
    (A1 => ZN) = (0, 0);
    (A2 => ZN) = (0, 0);
    if (A1 == 1'b1 && A2 == 1'b0 && C == 1'b0)
    (B => ZN) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b1 && C == 1'b0)
    (B => ZN) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b0 && C == 1'b0)
    (B => ZN) = (0, 0);
    ifnone (B => ZN) = (0, 0);
    if (A1 == 1'b1 && A2 == 1'b0 && B == 1'b0)
    (C => ZN) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b1 && B == 1'b0)
    (C => ZN) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b0 && B == 1'b0)
    (C => ZN) = (0, 0);
    ifnone (C => ZN) = (0, 0);
  endspecify
endmodule

`endcelldefine

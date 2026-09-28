// Created by ihdl
`timescale 1ns/10ps

`celldefine

module AOI31D0 (A1, A2, A3, B, ZN, VDD, VSS);
    input A1, A2, A3, B;
    output ZN;
   inout VDD, VSS;
    and		(A, A1, A2, A3);
    nor		(ZN, A, B);

  specify
    (A1 => ZN) = (0, 0);
    (A2 => ZN) = (0, 0);
    (A3 => ZN) = (0, 0);
    if (A1 == 1'b1 && A2 == 1'b1 && A3 == 1'b0)
    (B => ZN) = (0, 0);
    if (A1 == 1'b1 && A2 == 1'b0 && A3 == 1'b1)
    (B => ZN) = (0, 0);
    if (A1 == 1'b1 && A2 == 1'b0 && A3 == 1'b0)
    (B => ZN) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b1 && A3 == 1'b1)
    (B => ZN) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b1 && A3 == 1'b0)
    (B => ZN) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b0 && A3 == 1'b1)
    (B => ZN) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b0 && A3 == 1'b0)
    (B => ZN) = (0, 0);
    ifnone (B => ZN) = (0, 0);
  endspecify
endmodule

`endcelldefine

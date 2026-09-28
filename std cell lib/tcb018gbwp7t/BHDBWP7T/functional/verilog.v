// Created by ihdl
`timescale 1ns/1ps

`celldefine

module BHDBWP7T (Z, VDD, VSS);
   inout Z;
   inout VDD, VSS;
   not(weak0,weak1) (Z, Z_buf);
   not              (Z_buf, Z);

endmodule

`endcelldefine

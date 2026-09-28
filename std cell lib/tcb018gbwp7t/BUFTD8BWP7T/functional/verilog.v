// Created by ihdl
`timescale 1ns/1ps

`celldefine

module BUFTD8BWP7T (I, OE, Z, VDD, VSS);
    input I, OE;
    output Z;
   inout VDD, VSS;
    bufif1	(Z, I, OE);
    always @(Z)
       begin
         if (!$test$plusargs("bus_conflict_off"))
            if ($countdrivers(Z) && (Z === 1'bx))
                $display("%t ++BUS CONFLICT++ : %m", $realtime);
       end

  specify
    (I => Z) = (0, 0);
    (posedge OE => (Z:I)) = (0, 0);
  endspecify
endmodule

`endcelldefine

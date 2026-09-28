// Created by ihdl
`timescale 1ns/10ps

`celldefine

module LNCSND1 (D, EN, CDN, SDN, Q, QN, VDD, VSS);
   input D, EN, CDN, SDN;
   output Q, QN;
   inout VDD, VSS;
   reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    `ifdef RECREM 	// Reserve for RECREM.
      wire  CDN_d , SDN_d ;
     buf      (CDN_i, CDN_d);
     buf      (SDN_i, SDN_d);
    `else         	// Reserve for non RECREM. 
     buf      (CDN_i, CDN);
     buf      (SDN_i, SDN);
    `endif
    wire D_d, EN_d ;
   not		(E, EN_d);
   tsmc_dla	(Q_buf, D_d, E, CDN_i, SDN_i, notifier);
   buf      (Q, Q_buf);
   not		(QN_buf, Q_buf);
   and		(QN, QN_buf, SDN_i);
  `else 	// Reserve for non NTC.
   buf      (CDN_i, CDN);
   buf      (SDN_i, SDN);
   not		(E, EN);
   tsmc_dla	(Q_buf, D, E, CDN_i, SDN_i, notifier);
   buf      (Q, Q_buf);
   not		(QN_buf, Q_buf);
   and		(QN, QN_buf, SDN_i);
  `endif
    reg flag;
    always @(CDN_i or SDN_i) begin
      if (!$test$plusargs("cdn_sdn_check_off")) begin
      if (flag == 1) begin 
         if (CDN_i!==1'b0) begin
         $display("%m > CDN is released at time %.2fns.", $realtime);
         end
         if (SDN_i!==1'b0) begin
         $display("%m > SDN is released at time %.2fns.", $realtime);
         end
      end
      flag = ((CDN_i===1'b0)&&(SDN_i ===1'b0));
      if (flag == 1) begin
         $display("%m > Both CDN and SDN are enabled at time %.2fns.", $realtime);
      end
    end 
    end



  // Timing logics defined for default constraint check
  and  (D_check, SDN_i, CDN_i);
  buf  (EN_check, SDN_i);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
    tsmc_xbuf (EN_DEFCHK, EN_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    if (D == 1'b1 && EN == 1'b1 && SDN == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (D == 1'b0 && EN == 1'b1 && SDN == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (D == 1'b1 && EN == 1'b0 && SDN == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    ifnone (CDN => Q) = (0, 0);
    (D => Q) = (0, 0);
    (negedge EN => (Q+:D)) = (0, 0);
    if (CDN == 1'b1 && D == 1'b1 && EN == 1'b1)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    if (CDN == 1'b1 && D == 1'b0 && EN == 1'b1)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    if (CDN == 1'b1 && D == 1'b0 && EN == 1'b0)
    (SDN => Q) = (0, 0);
    ifnone (SDN => Q) = (0, 0);
    if (D == 1'b1 && EN == 1'b1 && SDN == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (D == 1'b0 && EN == 1'b1 && SDN == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (D == 1'b1 && EN == 1'b0 && SDN == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    ifnone (CDN => QN) = (0, 0);
    (D => QN) = (0, 0);
    (negedge EN => (QN-:D)) = (0, 0);
    if (CDN == 1'b1 && D == 1'b1 && EN == 1'b1)
    (negedge SDN => (QN-:1'b1)) = (0, 0);
    if (CDN == 1'b1 && D == 1'b0 && EN == 1'b1)
    (negedge SDN => (QN-:1'b1)) = (0, 0);
    if (CDN == 1'b1 && D == 1'b0 && EN == 1'b0)
    (SDN => QN) = (0, 0);
    ifnone (SDN => QN) = (0, 0);
    $width (negedge CDN, 0, 0, notifier);
    $width (negedge EN, 0, 0, notifier);
    $width (negedge SDN, 0, 0, notifier);
  `ifdef NTC
    `ifdef RECREM
      $setuphold (posedge SDN, posedge CDN, 0, 0, notifier,,, SDN_d, CDN_d);
      $setuphold (posedge EN &&& D_DEFCHK, posedge D, 0, 0, notifier,,, EN_d, D_d);
      $setuphold (posedge EN &&& D_DEFCHK, negedge D, 0, 0, notifier,,, EN_d, D_d);
      $setuphold (posedge CDN, posedge SDN, 0, 0, notifier,,, CDN_d, SDN_d);
      $recrem (posedge CDN, posedge EN &&& EN_DEFCHK, 0,0, notifier, , , CDN_d, EN_d);
      $recrem (posedge SDN, posedge EN, 0,0, notifier, , , SDN_d, EN_d);
    `else
      $setuphold (posedge SDN, posedge CDN, 0, 0, notifier,,, SDN_d, CDN_d);
      $setuphold (posedge EN &&& D_DEFCHK, posedge D, 0, 0, notifier,,, EN_d, D_d);
      $setuphold (posedge EN &&& D_DEFCHK, negedge D, 0, 0, notifier,,, EN_d, D_d);
      $setuphold (posedge CDN, posedge SDN, 0, 0, notifier,,, CDN_d, SDN_d);
      $recovery (posedge CDN, posedge EN &&& EN_DEFCHK, 0, notifier);
      $hold (posedge EN &&& EN_DEFCHK, posedge CDN, 0, notifier);
      $recovery (posedge SDN, posedge EN, 0, notifier);
      $hold (posedge EN, posedge SDN, 0, notifier);
    `endif
  `else
    $setuphold (posedge SDN, posedge CDN, 0, 0, notifier);
    $setuphold (posedge EN &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (posedge EN &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $setuphold (posedge CDN, posedge SDN, 0, 0, notifier);
    $recovery (posedge CDN, posedge EN &&& EN_DEFCHK, 0, notifier);
    $hold (posedge EN &&& EN_DEFCHK, posedge CDN, 0, notifier);
    $recovery (posedge SDN, posedge EN, 0, notifier);
    $hold (posedge EN, posedge SDN, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine

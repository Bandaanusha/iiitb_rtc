`timescale 1s/1ms
module iiitb_rtc_tb;
 reg clk,rst;
 wire [3:0]hrm,hrl,minm,minl,secm,secl;

 iiitb_rtc r1(.clk_1hz(clk),.rst(rst),.hrm(hrm),.hrl(hrl),.minm(minm),.minl(minl),.secm(secm),.secl(secl)); 
 
 always #0.5 clk=~clk;

 initial begin

  $dumpfile("iiitb_rtc_out.vcd");
  $dumpvars(0,iiitb_rtc_tb);
  clk=0;rst=0;
  #2 rst=1;
  #99980 rst=0;
  
  #100 $finish;
 end
endmodule

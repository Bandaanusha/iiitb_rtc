`timescale 1ns/10ps
module iiitb_rtc_tb;
reg clk,rst;
wire [3:0]hrm,hrl,minm,minl,secm,secl;
  iiitb_rtc r1(.clkin(clk),.rst(rst),.hrm(hrm),.hrl(hrl),.minm(minm),.minl(minl),.secm(secm),.secl(secl)); 
initial begin
clk=0;rst=0;
$dumpfile("iiitb_rtc_out.vcd");
$dumpvars(0,iiitb_rtc_tb);
forever
#10 clk=~clk;
end
initial begin
#40 rst=1;
#99980 rst=1;
end
endmodule

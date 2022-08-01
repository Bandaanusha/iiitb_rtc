`timescale 1ns/10ps
module iiitb_rtc_tb;
reg clk,rst;
wire [3:0]hrm,hrl,minm,minl,secm,secl;
iiitb_rtc r1(.clk(clk),.rst(rst),.hrm(hrm),.hrl(hrl),.minm(minm),.minl(minl),.secm(secm),.secl(secl)); 
initial begin
$dumpfile("iiitb_rtc_out.vcd");
$dumpvars(0,iiitb_rtc_tb);
clk=0;rst=0;
#2 rst=0;
#99980 rst=1;
#2.0e9 $finish;
end
always #10 clk=~clk;
endmodule

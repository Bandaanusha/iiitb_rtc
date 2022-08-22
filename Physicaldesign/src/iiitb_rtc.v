module iiitb_rtc (
input clkin,rst,
output [3:0]hrm,hrl,minm,minl,secm,secl);
wire [3:0]hrms,hrls,minms,minls,secms,secls;
wire hrclr;
assign hrclr = ((secl==4'd9) && (secm==4'd5) && (minl==4'd9) && (minm==4'd5) && (hrl==4'd3) && (hrm==4'd2));
//clock_div cd(clk,rst,clk);
  counter #(9) c1(.clk(clkin),.rst(rst),.clr(1'b0),.en(1'b1),.count(secl));
  counter #(5) c2(.clk(clkin),.rst(rst),.clr(1'b0),.en(secl==4'd9),.count(secm));
  counter #(9) c3(.clk(clkin),.rst(rst),.clr(1'b0),.en((secl==4'd9) && (secm==4'd5)),.count(minl));
  counter #(5) c4(.clk(clkin),.rst(rst),.clr(1'b0),.en((secl==4'd9) && (secm==4'd5) && (minl==4'd9)),.count(minm));
  counter #(9) c5(.clk(clkin),.rst(rst),.clr(hrclr),.en((secl==4'd9) && (secm==4'd5) && (minl==4'd9) && (minm==4'd5)),.count(hrl));
  counter #(2) c6(.clk(clkin),.rst(rst),.clr(hrclr),.en((secl==4'd9) && (secm==4'd5) && (minl==4'd9) && (minm==4'd5) && (hrl==4'd9)),.count(hrm));
endmodule

module counter #(parameter max_value=15) (
input clk,rst,clr,en,
output reg [3:0] count);
initial
count=4'b0;
always @(posedge clk)
begin
if(rst==0) count <=4'd0;
else if(clr==1) count<=4'd0;
else
begin
if(en==1)
if(count==max_value) count<=4'd0;
else count<=count+1;
else count<=count;
end
end
endmodule

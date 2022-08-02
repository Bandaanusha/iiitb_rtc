module test (
input clk,rst,
output [3:0]hrm,hrl,minm,minl,secm,secl);

wire [3:0]hrms,hrls,minms,minls,secms,secls;
wire hrclr;
reg second_clk;
reg [5:0] sec_count = 6'b000000;
wire hundred_clk;
assign hrclr = ((secl==4'd9) && (secm==4'd5) && (minl==4'd9) && (minm==4'd5) && (hrl==4'd3) && (hrm==4'd2));
clock_div cd(clk,rst,hundred_clk);
always @(posedge hundred_clk or posedge rst) begin
if (rst ==0) begin
sec_count <= 6'b000000;
second_clk=0;
end else begin
if (rst & sec_count == 6'b110001) begin
sec_count <= 6'b000000;
second_clk <= ~second_clk;
end
else
sec_count <= sec_count + 1;
end
end

counter #(9) c1(.second_clk(second_clk),.rst(rst),.clr(1'b0),.en(1'b1),.count(secl));
counter #(5) c2(.second_clk(second_clk),.rst(rst),.clr(1'b0),.en(secl==4'd9),.count(secm));
counter #(9) c3(.second_clk(second_clk),.rst(rst),.clr(1'b0),.en((secl==4'd9) && (secm==4'd5)),.count(minl));
counter #(5) c4(.second_clk(second_clk),.rst(rst),.clr(1'b0),.en((secl==4'd9) && (secm==4'd5) && (minl==4'd9)),.count(minm));
counter #(9) c5(.second_clk(second_clk),.rst(rst),.clr(hrclr),.en((secl==4'd9) && (secm==4'd5) && (minl==4'd9) && (minm==4'd5)),.count(hrl));
counter #(2) c6(.second_clk(second_clk),.rst(rst),.clr(hrclr),.en((secl==4'd9) && (secm==4'd5) && (minl==4'd9) && (minm==4'd5) && (hrl==4'd9)),.count(hrm));
endmodule

module counter #(parameter max_value=15) (
input second_clk,rst,clr,en,
output reg [3:0] count);
initial

count=4'b0;
always @(posedge second_clk)
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

module clock_div(ClkIn,rst,Clk100);
input ClkIn; // 50 MHz input
input rst; // Clear all registers
output reg Clk100; // Clock frequency

reg [3:0] clk_div=4'b0; // Set up a divider for the clock
reg [13:0] clk_div100=7'b0;// Set up the 100 Hz buffer counter
initial
begin
Clk100=0;
end
always @(posedge ClkIn) // Pre-Scaler
begin
clk_div = clk_div + 4'b1;
end
always @(posedge clk_div[3]) // Generate 100 Hz clock
begin
if (rst == 1'b1 | clk_div100 == 7'b1100100)
begin
clk_div100 = 14'b0;
Clk100 = ~Clk100;
end
else
clk_div100 = clk_div100 + 12'b1;
end
endmodule




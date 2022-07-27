module test;
reg clk,rst;
wire [6:0] HR_M,HR_L,MIN_M,MIN_L,SEC_M,SEC_L;
RTDC dut(rst, clk, SEC_M,SEC_L,MIN_M,MIN_L,HR_M,HR_L);
initial begin
clk=0;
rst=1;
#10 rst=0;
#500 Sfinish();
end
always #10 clk=~clk;
initial begin
Sdumpfile("dump.vcd");
Sdumpvars;
end

endmodule

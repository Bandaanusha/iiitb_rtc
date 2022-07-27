module RTDC(
    input rst,clk,output reg [6:0] HR_M,HR_L,.MIN_M,MIN_LSEC_M,SEC_L
    );
reg[3:0] count1,count2,count3,count4,count5,count6;
//count1=SEC_M
//count2=SEC_L
//count3=MIN_M
//count4=MIN_L
//countS=HR_M
//count6=HR_L
always@(negedge clk)
begin
     if(rst==1)
begin
   count1<=0;
   count2<=0;
   count3<=0;
   count4<=0;
   count5<=0;
    count6<=0;
end
else
begin
    count2<=count2+1;
if(count2==9)

begin

count2<=0;
count1<=count1+1;

     if({count1,count2}==60)

begin
   {count1,count2}<=0;
count4<=count4+1;
if(count4==9)
begin
count4<=0;
count3<=count3+1;

     if({count3,count4}==60)

 begin

  {count3, count4}<=0;
 count6=count6+1;
   
   if(count6==9)
 begin

 count6é<=0;
count5=count5+1;
if({countS, count6}==24)
begin
{countS,count6}<=0;
        end
    end
  end
 end
 end
 end
     end
        end
always @(count1 or count2 or count3 or count4 or countS or count6)
begin
case(count1)
0: SEC_M = 7'b0000001;
1: 5EC_M = 7'b1001111;

2: SEC_M = 7'b0010010;
 

3: SEC_M = 7'b0000110;
4: SEC_M = 7'b1001100;
5: SEC_M = 7'b0100100;
6: SEC_M = 7'b0100000;
7: SEC_M = 7'b0001111;
8: SEC_M = 7'b0000000;
9: SEC_M = 7'b0000100;
default : SEC_M = 7'b1111111;

endcase

case(count2)

O: SEC_L = 760000001;
1: SE€C_L = 7'61001111;
2: SEC_L = 7'b0010010;
3: SEC_L = 7'60000110;
4:SEC_L = 7'b1001100;
5: SEC_L = 7'b0100100;
6: SEC_L = 7'b0100000;
7: SEC_L=7'b0001111;
8: SEC_L = 7'b0000000;
9: SEC_L = 7'b0000100;
default : SEC_L = 7'b1111111;

endcase

case(count3)

0: MIN_M = 7'b0000001;
1: MIN_M = 7'b1001111;
2: MIN_M = 7'b0010010;
3: MIN_M = 7'b0000110;
4: MIN_M = 7'b1001100;
5: MIN_M = 7'b0100100;
6: MIN_M = 7'b0100000;
7: MIN_M = 7'b0001111;
8: MIN_M = 7'b0000000;
9: MIN_M = 7'b0000100;
default : MIN_M = 7'b1111111;
endcase
case(count4)

0: MIN_L = 7'b0000001;
1: MIN_L = 7'b1001111;
2: MIN_L = 7'b0010010; 
3: MIN_L = 7'b0000110;
4: MIN_L = 7'b1001100;
5: MIN_L = 7'b0100100;
6: MIN_L = 7'b0100000;
7: MIN_L = 7'b00011111;
&: MIN_L = 7'b0000000;
9: MIN_L = 7'b0000100;
default : MIN_L = 7'b1111111;

endcase

case(countS)

0: HR_M = 7'b0000001;
1:HR_M = 7'b1001111;
2: HR_M = 7'b0010010;
3: HR_M = 7'b0000110;
4:HR_M = ?'b1001100;
5: HR_M = 7'b0100100;
6: HR_M = 7'b0100000;
7: HR_M = 7'b0001111;
8: HR_M = 7'b000000;
9: HR_M = 7'b0000100;
default : HR_M = 7'b1111111;
endcase

case(count6)

0: HR_L = 7'b0000001;
1: HR_L = 7'b1001111;
2: HR_L = 7'b0010010;
3: HR_L = 7'b0000110;
4; HR_L= 7'b1001100;
5: HR_L = 7'60100100;
6: HR_L = 7'b0100000;
7: HR_L = #'60001111;
8: HR_L = 7'b00000000;
9: HR_L = 760000100;
default : HR_L = 7'b1111111;

endcase

end

endmodule

`define r 4'b0000
`define r_prime 4'b0001
`define f 4'b0010
`define f_prime 4'b0011
`define u 4'b0100
`define u_prime 4'b0101 
`define l 4'b0110 
`define l_prime 4'b0111
`define x 4'b1000
`define x_prime 4'b1001
`define y 4'b1010
`define y_prime 4'b1011
`define z 4'b1100
`define z_prime 4'b1101
module cube_cntrl(
input wire clk,
input wire rst,
input wire [3:0]command,
input wire [11:0] colors1,
input wire [11:0] colors2,
input wire [11:0] colors3,
input wire [11:0] colors4,
input wire [11:0] colors5,
input wire [11:0] colors6,
input wire [11:0] colors7,
input wire [11:0] colors8,
input wire [11:0] colors9,
input wire [11:0] colors10,
input wire [11:0] colors11,
input wire [11:0] colors12,
input wire [11:0] colors13,
input wire [11:0] colors14,
input wire [11:0] colors15,
input wire [11:0] colors16,
input wire [11:0] colors17,
input wire [11:0] colors18,
input wire [11:0] colors19,
input wire [11:0] colors20,
input wire [11:0] colors21,
input wire [11:0] colors22,
input wire [11:0] colors23,
input wire [11:0] colors24,
output reg [11:0] b1,
output reg [11:0] b2,
output reg [11:0] b3,
output reg [11:0] b4,
output reg [11:0] b5,
output reg [11:0] b6,
output reg [11:0] b7,
output reg [11:0] b8,
output reg [11:0] b9,
output reg [11:0] b10,
output reg [11:0] b11,
output reg [11:0] b12,
input wire choosing,
input wire [2:0]entercnt,
input wire ischanged
);
reg [11:0] b13;
reg [11:0] b14;
reg [11:0] b15;
reg [11:0] b16;
reg [11:0] b17;
reg [11:0] b18;
reg [11:0] b19;
reg [11:0] b20;
reg [11:0] b21;
reg [11:0] b22;
reg [11:0] b23;
reg [11:0] b24;
reg state,nextstate;
reg [11:0] nextb1,nextb2,nextb3,nextb4,nextb5,nextb6,nextb7,nextb8,nextb9,nextb10,nextb11,nextb12,
            nextb13,nextb14,nextb15,nextb16,nextb17,nextb18,nextb19,nextb20,nextb21,nextb22,nextb23,nextb24;
always@(posedge clk or posedge rst)begin
    if(rst)begin
        state<=0;
        b1<=0;
        b2<=0;
        b3<=0;
        b4<=0;
        b5<=0;
        b6<=0;
        b7<=0;
        b8<=0;
        b9<=0;
        b10<=0;
        b11<=0;
        b12<=0;
        b13<=0;
        b14<=0;
        b15<=0;
        b16<=0;
        b17<=0;
        b18<=0;
        b19<=0;
        b20<=0;
        b21<=0;
        b22<=0;
        b23<=0;
        b24<=0;
    end
    else begin
        state<=nextstate;
        b1<=nextb1;
        b2<=nextb2;
        b3<=nextb3;
        b4<=nextb4;
        b5<=nextb5;
        b6<=nextb6;
        b7<=nextb7;
        b8<=nextb8;
        b9<=nextb9;
        b10<=nextb10;
        b11<=nextb11;
        b12<=nextb12;
        b13<=nextb13;
        b14<=nextb14;
        b15<=nextb15;
        b16<=nextb16;
        b17<=nextb17;
        b18<=nextb18;
        b19<=nextb19;
        b20<=nextb20;
        b21<=nextb21;
        b22<=nextb22;
        b23<=nextb23;
        b24<=nextb24;
    end

end

always@(*)begin
    nextstate=state;
    nextb1=b1; nextb2=b2; nextb3=b3; nextb4=b4; nextb5=b5; nextb6=b6; nextb7=b7; nextb8=b8; nextb9=b9; nextb10=b10; nextb11=b11; nextb12=b12;
    nextb13=b13; nextb14=b14; nextb15=b15; nextb16=b16; nextb17=b17; nextb18=b18; nextb19=b19; nextb20=b20; nextb21=b21; nextb22=b22; nextb23=b23; nextb24=b24;
    case(state)
        1'b0:begin
            nextb1=colors1;
            nextb2=colors2;
            nextb3=colors3;
            nextb4=colors4;
            nextb5=colors5;
            nextb6=colors6;
            nextb7=colors7;
            nextb8=colors8;
            nextb9=colors9;
            nextb10=colors10;
            nextb11=colors11;
            nextb12=colors12;
            nextb13=colors13;
            nextb14=colors14;
            nextb15=colors15;
            nextb16=colors16;
            nextb17=colors17;
            nextb18=colors18;
            nextb19=colors19;
            nextb20=colors20;
            nextb21=colors21;
            nextb22=colors22;
            nextb23=colors23;
            nextb24=colors24;
            nextstate=(choosing==0 && entercnt>=2)? 1:0;
        end
        1'b1:begin
            if(command==`r&&ischanged)begin
                nextb11=b4;
                nextb10=b3;
                nextb4=b24;
                nextb3=b23;
                nextb24=b20;
                nextb23=b19;
                nextb20=b11;
                nextb19=b10;
                nextb6=b5;
                nextb5=b7;
                nextb7=b8;
                nextb8=b6;
            end
            else if(command==`r_prime&&ischanged)begin
                nextb3=b10;
                nextb4=b11;
                nextb10=b19;
                nextb11=b20;
                nextb19=b23;
                nextb20=b24;
                nextb23=b3;
                nextb24=b4;
                nextb7=b5;
                nextb8=b7;
                nextb6=b8;
                nextb5=b6;
            end
            else if(command==`u&&ischanged)begin
                nextb2=b6;
                nextb4=b8;
                nextb6=b19;
                nextb8=b17;
                nextb19=b15;
                nextb17=b13;
                nextb15=b2;
                nextb13=b4;
                nextb10=b11;
                nextb11=b12;
                nextb12=b9;
                nextb9=b10;
            end
            else if(command==`u_prime&&ischanged)begin
                nextb6=b2;
                nextb8=b4;
                nextb2=b15;
                nextb4=b13;
                nextb15=b19;
                nextb13=b17;
                nextb19=b6;
                nextb17=b8;
                nextb10=b9;
                nextb9=b12;
                nextb12=b11;
                nextb11=b10;
            end
            else if(command==`f&&ischanged)begin
                nextb10=b13;
                nextb9=b14;
                nextb13=b21;
                nextb14=b24;
                nextb21=b5;
                nextb24=b6;
                nextb5=b10;
                nextb6=b9;
                nextb3=b4;
                nextb4=b2;
                nextb2=b1;
                nextb1=b3;
            end
            else if(command==`f_prime&&ischanged)begin
                nextb24=b14;
                nextb21=b13;
                nextb14=b9;
                nextb13=b10;
                nextb9=b6;
                nextb10=b5;
                nextb6=b24;
                nextb5=b21;
                nextb1=b2;
                nextb2=b4;
                nextb4=b3;
                nextb3=b1;
            end
            else if(command==`l&&ischanged)begin
                nextb1=b9;
                nextb2=b12;
                nextb9=b17;
                nextb12=b18;
                nextb17=b22;
                nextb18=b21;
                nextb22=b1;
                nextb21=b2;
                nextb15=b16;
                nextb16=b14;
                nextb14=b13;
                nextb13=b15;
            end
            else if(command==`l_prime&&ischanged)begin
                nextb1=b22;
                nextb2=b21;
                nextb22=b17;
                nextb21=b18;
                nextb17=b9;
                nextb18=b12;
                nextb9=b1;
                nextb12=b2;
                nextb13=b14;
                nextb14=b16;
                nextb16=b15;
                nextb15=b13;
            end
            else if(command==`x&&ischanged)begin
                nextb12=b2;
                nextb11=b4;
                nextb9=b1;
                nextb10=b3;
                nextb2=b21;
                nextb4=b24;
                nextb1=b22;
                nextb3=b23;
                nextb21=b18;
                nextb24=b20;
                nextb22=b17;
                nextb23=b19;
                nextb18=b12;
                nextb20=b11;
                nextb17=b9;
                nextb19=b10;
            end

        end
    endcase


    

end

endmodule
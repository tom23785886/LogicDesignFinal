`define r 5'b00000
`define r_prime 5'b00001
`define f 5'b00010
`define f_prime 5'b00011
`define u 5'b00100
`define u_prime 5'b00101 
`define l 5'b00110 
`define l_prime 5'b00111
`define x 5'b01000
`define x_prime 5'b01001
`define y 5'b01010
`define y_prime 5'b01011
`define z 5'b01100
`define z_prime 5'b01101
`define b 5'b01110
`define b_prime 5'b01111
`define d 5'b10000
`define d_prime 5'b10001
module cube_cntrl(
input wire clk,
input wire rst,
input wire [4:0]command,
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
output reg [11:0] b13,
output reg [11:0] b14,
output reg [11:0] b15,
output reg [11:0] b16,
output reg [11:0] b17,
output reg [11:0] b18,
output reg [11:0] b19,
output reg [11:0] b20,
output reg [11:0] b21,
output reg [11:0] b22,
output reg [11:0] b23,
output reg [11:0] b24,

input wire choosing,
input wire [2:0]entercnt,
input wire ischanged //ischanged 處理混色
);

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
                nextb5=b7;
                nextb7=b8;
                nextb8=b6;
                nextb6=b5;
                nextb13=b14;
                nextb14=b16;
                nextb16=b15;
                nextb15=b13;
            end
            else if(command==`x_prime&&ischanged)begin
                nextb1=b9;
                nextb2=b12;
                nextb3=b10;                
                nextb4=b11;
                nextb9=b17;
                nextb12=b18;
                nextb10=b19;
                nextb11=b20;
                nextb17=b22;
                nextb18=b21;
                nextb19=b23;
                nextb20=b24;
                nextb22=b1;
                nextb21=b2;
                nextb23=b3;
                nextb24=b4;
                nextb5=b6;
                nextb6=b8;
                nextb7=b5;
                nextb8=b7;
                nextb13=b15;
                nextb14=b13;
                nextb15=b16;
                nextb16=b14;
            end
            else if(command==`y&&ischanged)begin
                nextb1=b5;
                nextb2=b6;
                nextb3=b7;
                nextb4=b8;
                nextb5=b20;
                nextb6=b19;
                nextb7=b18;
                nextb8=b17;
                nextb20=b16;
                nextb19=b15;
                nextb18=b14;
                nextb17=b13;
                nextb16=b1;
                nextb15=b2;
                nextb14=b3;
                nextb13=b4;
                nextb9=b10;
                nextb10=b11;
                nextb11=b12;
                nextb12=b9;
                nextb21=b24;
                nextb22=b21;
                nextb23=b22;
                nextb24=b23;
            end
            else if(command==`y_prime&&ischanged)begin
                //16
                nextb1=b16;
                //15;
                nextb2=b15;
                //14;
                nextb3=b14;
                //13;
                nextb4=b13;
                //1;
                nextb5=b1;
                //2;
                nextb6=b2;
                //3;
                nextb7=b3;
                //4;
                nextb8=b4;
                //12
                nextb9=b12;
                //9
                nextb10=b9;
                //10
                nextb11=b10;
                //11
                nextb12=b11;
                //17
                nextb13=b17;
                //18
                nextb14=b18;
                //19
                nextb15=b19;
                //20
                nextb16=b20;
                //8
                nextb17=b8;
                //7
                nextb18=b7;
                //6
                nextb19=b6;
                //5
                nextb20=b5;
                //22
                nextb21=b22;
                //23
                nextb22=b23;
                //24
                nextb23=b24;
                //21
                nextb24=b21;
            end
            else if(command==`z&&ischanged)begin
                //3
                nextb1=b3;
                //1
                nextb2=b1;
                //4
                nextb3=b4;
                //2
                nextb4=b2;
                //10
                nextb5=b10;
                //9
                nextb6=b9;
                //11
                nextb7=b11;
                //12
                nextb8=b12;
                //14
                nextb9=b14;
                //13
                nextb10=b13;
                //15
                nextb11=b15;
                //16
                nextb12=b16;
                //21
                nextb13=b21;
                //24
                nextb14=b24;
                //22
                nextb15=b22;
                //23
                nextb16=b23;
                //18
                nextb17=b18;
                //20
                nextb18=b20;
                //17
                nextb19=b17;
                //19
                nextb20=b19;
                //5
                nextb21=b5;
                //7
                nextb22=b7;
                //8
                nextb23=b8;
                //6
                nextb24=b6;
            end
            else if(command==`z_prime&&ischanged)begin
                //2
                nextb1=b2;
                //4
                nextb2=b4;
                //1
                nextb3=b1;
                //3
                nextb4=b3;
                //21
                nextb5=b21;
                //24
                nextb6=b24;
                //22
                nextb7=b22;
                //23
                nextb8=b23;
                //6
                nextb9=b6;
                //5
                nextb10=b5;
                //7
                nextb11=b7;
                //8
                nextb12=b8;
                //10
                nextb13=b10;
                //9
                nextb14=b9;
                //11
                nextb15=b11;
                //12
                nextb16=b12;
                //19
                nextb17=b19;
                //17
                nextb18=b17;
                //20
                nextb19=b20;
                //18
                nextb20=b18;
                //13
                nextb21=b13;
                //15
                nextb22=b15;
                //16
                nextb23=b16;
                //14
                nextb24=b14;
            end
            else if(command==`b&&ischanged)begin
                nextb12=b8;
                nextb11=b7;
                nextb8=b23;
                nextb7=b22;
                nextb23=b16;
                nextb22=b15;
                nextb16=b12;
                nextb15=b11;
                nextb19=b20;
                nextb20=b18;
                nextb18=b17;
                nextb17=b19;
            end
            else if(command==`b_prime&&ischanged)begin
                nextb12=b16;
                nextb11=b15;
                nextb16=b23;
                nextb15=b22;
                nextb23=b8;
                nextb22=b7;
                nextb8=b12;
                nextb7=b11;
                nextb19=b17;
                nextb17=b18;
                nextb18=b20;
                nextb20=b19;
            end
            else if(command==`d&& ischanged)begin
                nextb1=b16;
                nextb3=b14;
                nextb16=b20;
                nextb14=b18;
                nextb20=b5;
                nextb18=b7;
                nextb5=b1;
                nextb7=b3;
                nextb21=b22;
                nextb22=b23;
                nextb23=b24;
                nextb24=b21;
            end
            else if(command==`d_prime&& ischanged)begin
                nextb1=b5;
                nextb3=b7;
                nextb5=b20;
                nextb7=b18;
                nextb20=b16;
                nextb18=b14;
                nextb16=b1;
                nextb14=b3;
                nextb21=b24;
                nextb24=b23;
                nextb23=b22;
                nextb22=b21;
            end

        end
    endcase


    

end

endmodule
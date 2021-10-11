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
`define Yellow 12'hff0
module solvetop(
    input clk,
    input rst,
   // input wire [11:0]f1,
    input wire [11:0]f2,
    //input wire [11:0]f3,
    input wire [11:0]f4,
   // input wire [11:0]f5,
    input wire [11:0]f6,
   // input wire [11:0]f7,
    input wire [11:0]f8,
    input wire [11:0]f9,
    input wire [11:0]f10,
    input wire [11:0]f11,
    input wire [11:0]f12,

    input wire [11:0]b1,
   // input wire [11:0]b2,
    input wire [11:0]b3,
    //input wire [11:0]b4,
    input wire [11:0]b5,
  //  input wire [11:0]b6,
    input wire [11:0]b7,
   // input wire [11:0]b8,
  //  input wire [11:0]b9,
    // input wire [11:0]b10,
    // input wire [11:0]b11,
    // input wire [11:0]b12,
    input wire ready,
    output reg topfacedone,
    output reg [4:0]AIcmd,
    output reg ischanged
);


reg [2:0]topfacestate,nexttopfacestate;



reg [24:0]count,nextcount;

reg [3:0]outputstate,nextoutputstate;
reg [2:0]pattern,nextpattern;

always@(posedge clk or posedge rst)begin
    if(rst)begin
        topfacestate<=1;
        pattern<=0;
        count<=0;
        outputstate<=0;
    end
    else begin
        topfacestate<=nexttopfacestate;
        pattern<=nextpattern;
        count<=nextcount;
        outputstate<=nextoutputstate;
    end

end


always@(*)begin
//top face
   
    nexttopfacestate=topfacestate;
    ischanged=0;
    nextpattern=pattern;
    AIcmd=5'b11111;
    nextcount=count;
    nextoutputstate=outputstate;
    topfacedone=0;
    if(ready)begin
        case(topfacestate)
            
            1:begin //finding pattern
                if(f12==`Yellow&&f2==`Yellow&&f6==`Yellow&&b7==`Yellow)begin
                    nexttopfacestate=2;
                    nextpattern=1;
                end
                else if(f9==`Yellow&&f4==`Yellow&&f8==`Yellow&&b5==`Yellow)begin
                    nexttopfacestate=2;
                    nextpattern=2;
                end
                else if(f12==`Yellow&&f10==`Yellow&&f2==`Yellow&&f8==`Yellow)begin
                    nexttopfacestate=2;
                    nextpattern=3;
                end
                else if(f2==`Yellow&&f10==`Yellow&&f11==`Yellow&&b5==`Yellow)begin
                    nexttopfacestate=2;
                    nextpattern=4;
                end
                else if(f10==`Yellow&&f11==`Yellow&&b1==`Yellow&&b3==`Yellow)begin
                    nexttopfacestate=2;
                    nextpattern=5;
                end
                else if(f2==`Yellow&&f4==`Yellow&&b5==`Yellow&&b7==`Yellow)begin
                    nexttopfacestate=2;
                    nextpattern=6;
                end
                else if(f4==`Yellow&&b1==`Yellow&&b3==`Yellow&&b7==`Yellow)begin
                    nexttopfacestate=2;
                    nextpattern=7;
                end
                else if(f9==`Yellow&&f10==`Yellow&&f11==`Yellow&&f12==`Yellow)begin
                    nexttopfacestate=3;
                end
                else begin
                    if(count<25'd33554431)begin
                        nextcount=count+1;
                    end
                    else begin
                        nextcount=0;
                        AIcmd=`y;
                        ischanged=1;
                    end

                end
            end
            2:begin //start solving
                case(pattern)
                    1:begin
                        case(outputstate)
                            0:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=1;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end
                            end
                            1:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=2;
                                    AIcmd=`u_prime;
                                    ischanged=1;
                                end
                            end
                            2:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=3;
                                    AIcmd=`r;
                                    ischanged=1;
                                end
                            end
                            3:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=4;
                                    AIcmd=`u_prime;
                                    ischanged=1;
                                end
                            end
                            4:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=5;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end
                            end
                            5:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=6;
                                    AIcmd=`u;
                                    ischanged=1;
                                end
                            end
                            6:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=7;
                                    AIcmd=`u;
                                    ischanged=1;
                                end
                            end
                            7:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    
                                    nexttopfacestate=3;
                                    AIcmd=`r;
                                    ischanged=1;
                                end
                            end
                        endcase
                    end
                    2:begin
                        case(outputstate)
                            0:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=1;
                                    AIcmd=`r;
                                    ischanged=1;
                                end
                            end
                            1:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=2;
                                    AIcmd=`u;
                                    ischanged=1;
                                end
                            end
                            2:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=3;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end
                            end
                            3:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=4;
                                    AIcmd=`u;
                                    ischanged=1;
                                end
                            end
                            4:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=5;
                                    AIcmd=`r;
                                    ischanged=1;
                                end
                            end
                            5:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=6;
                                    AIcmd=`u_prime;
                                    ischanged=1;
                                end
                            end
                            6:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=7;
                                    AIcmd=`u_prime;
                                    ischanged=1;
                                end
                            end
                            7:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    
                                    nexttopfacestate=3;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end
                            end
                        endcase
                    end
                    3:begin
                        case(outputstate)
                            0:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=1;
                                    AIcmd=`f;
                                    ischanged=1;
                                end
                            end
                            1:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=2;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end
                            end
                            2:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=3;
                                    AIcmd=`f_prime;
                                    ischanged=1;
                                end
                            end
                            3:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=4;
                                    AIcmd=`r;
                                    ischanged=1;
                                end
                            end
                            4:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=5;
                                    AIcmd=`u;
                                    ischanged=1;
                                end
                            end
                            5:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=6;
                                    AIcmd=`r;
                                    ischanged=1;
                                end
                            end
                            6:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=7;
                                    AIcmd=`u_prime;
                                    ischanged=1;
                                end
                            end
                            7:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nexttopfacestate=3;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end
                            end
                        endcase
                    end
                    4:begin
                        case(outputstate)
                            0:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=1;
                                    AIcmd=`r;
                                    ischanged=1;
                                end
                            end
                            1:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=2;
                                    AIcmd=`u;
                                    ischanged=1;
                                end
                            end
                            2:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=3;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end
                            end
                            3:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=4;
                                    AIcmd=`u_prime;
                                    ischanged=1;
                                end
                            end
                            4:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=5;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end
                            end
                            5:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=6;
                                    AIcmd=`f;
                                    ischanged=1;
                                end
                            end
                            6:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=7;
                                    AIcmd=`r;
                                    ischanged=1;
                                end
                            end
                            7:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nexttopfacestate=3;
                                    AIcmd=`f_prime;
                                    ischanged=1;
                                end
                            end
                        endcase
                    end
                    5:begin
                        case(outputstate)
                            0:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=1;
                                    AIcmd=`f;
                                    ischanged=1;
                                end
                            end
                            1:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=2;
                                    AIcmd=`r;
                                    ischanged=1;
                                end
                            end
                            2:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=3;
                                    AIcmd=`u;
                                    ischanged=1;
                                end
                            end
                            3:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=4;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end
                            end
                            4:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=5;
                                    AIcmd=`u_prime;
                                    ischanged=1;
                                end
                            end
                            5:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nexttopfacestate=3;
                                    AIcmd=`f_prime;
                                    ischanged=1;
                                end
                            end                            
                        endcase
                    end
                    6:begin
                        case(outputstate)
                            0:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=1;
                                    AIcmd=`r;
                                    ischanged=1;
                                end
                            end
                            1:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=2;
                                    AIcmd=`r;
                                    ischanged=1;
                                end
                            end
                            2:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=3;
                                    AIcmd=`u;
                                    ischanged=1;
                                end
                            end
                            3:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=4;
                                    AIcmd=`u;
                                    ischanged=1;
                                end
                            end
                            4:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=5;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end
                            end
                            5:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=6;
                                    AIcmd=`u;
                                    ischanged=1;
                                end
                            end
                            6:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=7;
                                    AIcmd=`u;
                                    ischanged=1;
                                end
                            end
                            7:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextoutputstate=8;
                                    nextcount=0;
                                    AIcmd=`r_prime;
                                    ischanged=1;

                                end
                            end
                            8:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nexttopfacestate=3;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end
                            end
                        endcase
                    end
                    7:begin
                        case(outputstate)
                            0:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=1;
                                    AIcmd=`f;
                                    ischanged=1;
                                end
                            end
                            1:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=2;
                                    AIcmd=`r;
                                    ischanged=1;
                                end
                            end
                            2:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=3;
                                    AIcmd=`u;
                                    ischanged=1;
                                end
                            end
                            3:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=4;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end
                            end
                            4:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=5;
                                    AIcmd=`u_prime;
                                    ischanged=1;
                                end
                            end
                            5:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=6;
                                    AIcmd=`r;
                                    ischanged=1;
                                end
                            end
                            6:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=7;
                                    AIcmd=`u;
                                    ischanged=1;
                                end
                            end
                            7:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=8;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end
                            end
                            8:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=9;
                                    AIcmd=`u_prime;
                                    ischanged=1;
                                end
                            end
                            9:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nexttopfacestate=3;
                                    AIcmd=`f_prime;
                                    ischanged=1;
                                end
                            end
                        endcase
                    end
                    default:begin
                        nexttopfacestate=3;
                    end
                endcase
            end
            3:begin
                AIcmd=5'b11111;
                ischanged=1;
                topfacedone=1;
            end
        endcase
    end 

end


endmodule


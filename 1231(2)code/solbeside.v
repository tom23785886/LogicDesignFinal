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

module solveside(
    input clk,
    input rst,
    input wire [11:0]f1,
    input wire [11:0]f2,
    input wire [11:0]f3,
    input wire [11:0]f4,
    input wire [11:0]f5,
    input wire [11:0]f6,
    input wire [11:0]f7,
    input wire [11:0]f8,
    /*input wire [11:0]f9,
    input wire [11:0]f10,
    input wire [11:0]f11,
    input wire [11:0]f12,*/

    input wire [11:0]b1,
    input wire [11:0]b2,
    input wire [11:0]b3,
    input wire [11:0]b4,
    input wire [11:0]b5,
    input wire [11:0]b6,
    input wire [11:0]b7,
    input wire [11:0]b8,
    /*input wire [11:0]b9,
    input wire [11:0]b10,
    input wire [11:0]b11,
    input wire [11:0]b12,*/
    input wire ready,
    output reg isdone,
    output reg [4:0]AIcmd,
    output reg ischanged,
    output wire [3:0]testing
);


reg [4:0] sidestate,nextsidestate; 
reg [24:0]count,nextcount;



reg [3:0]countpair,nextcountpair;
reg [4:0]outputstate,nextoutputstate;
//reg [1:0]checkstate,nextcheckstate;


wire countface_1,countface_2,countface_3,countface_4,countface_5,countface_6,countface_7,countface_8;
wire [1:0]inface_1,inface_2,inface_3,inface_4; //0: no 1: top 2: down 3:both 
//reg [1:0] nextinface_1_r,nextinface_2_r,nextinface_3_r,nextinface_4_r,inface_1_r,inface_2_r,inface_3_r,inface_4_r;

/*assign inface_1=(f1==f3&&f2==f4)? 3:(f1==f3)? 2:(f2==f4)? 1:0; //check pair location
assign inface_2=(f5==f7&&f6==f8)? 3:(f5==f7)? 2:(f6==f8)? 1:0;
assign inface_3=(b1==b3&&b2==b4)? 3:(b1==b3)? 2:(b2==b4)? 1:0;
assign inface_4=(b5==b7&&b6==b8)? 3:(b5==b7)? 2:(b6==b8)? 1:0;*/

assign countface_1=(f1==f3)? 1:0;  //countiing pair
assign countface_2=(f2==f4)? 1:0;
assign countface_3=(f5==f7)? 1:0;
assign countface_4=(f6==f8)? 1:0;
assign countface_5=(b1==b3)? 1:0;
assign countface_6=(b2==b4)? 1:0;
assign countface_7=(b5==b7)? 1:0;
assign countface_8=(b6==b8)? 1:0;

assign testing=countpair;

always@(posedge clk or posedge rst)begin
    if(rst)begin
        sidestate<=6;
        outputstate<=0;
        countpair<=0;
        count<=0;
       /* inface_1_r<=0;
        inface_2_r<=0;
        inface_3_r<=0;
        inface_4_r<=0;
        checkstate<=0;*/
    end
    else begin
        sidestate<=nextsidestate;
        outputstate<=nextoutputstate;
        countpair<=nextcountpair;
        count<=nextcount;
       /* inface_1_r<=nextinface_1_r;
        inface_2_r<=nextinface_2_r;
        inface_3_r<=nextinface_3_r;
        inface_4_r<=nextinface_4_r;
        checkstate<=nextcheckstate;*/
    end
end

always@(*)begin
    AIcmd=5'b11111;
    ischanged=0;
    isdone=0;
    nextcountpair=countpair;
    nextcount=count;
    nextsidestate=sidestate;
    nextoutputstate=outputstate;
    /*nextinface_1_r=inface_1_r;
    nextinface_2_r=inface_2_r;
    nextinface_3_r=inface_3_r;
    nextinface_4_r=inface_4_r;
    nextcheckstate=checkstate;*/
    if(ready)begin
        case(sidestate)
            0:begin //finding pairs
                nextcountpair=countface_1+countface_2+countface_3+countface_4+countface_5+countface_6+countface_7+countface_8;
                nextsidestate=1;
            end
            1:begin
                case(countpair)//moving pairs to right pos
                    0:begin
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
                                    AIcmd=`f;
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
                                    AIcmd=`f;
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
                                    nextsidestate=3;
                                    AIcmd=`r;
                                    ischanged=1;
                                end
                            end
                            
                        endcase
                    end
                    1:begin
                        if(f2==f4)begin
                            nextsidestate=2;
                        end
                        else if(f1==f3)begin                                                            
                            nextsidestate=5;
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
                    2:begin
                        if(f1==f3&&f2==f4)begin
                            nextsidestate=2;
                        end
                        else begin
                            if(f1!=f3&&f2!=f4)begin
                               if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    AIcmd=`y;                                    
                                    ischanged=1;
                                end 
                            end
                            else begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    AIcmd=`d;                                    
                                    ischanged=1;
                                end
                            end
                        end
                    end
                    4:begin
                        if(f2==f4)begin
                            nextsidestate=5;
                        end
                        else begin
                            nextsidestate=2;
                        end
                    end
                    5:begin
                        if(f2==f4&&f6==f8)begin
                            nextsidestate=5;
                        end
                        else begin
                            nextsidestate=2;
                        end
                    end                    
                    default:begin
                        nextsidestate=3;
                    end
                endcase
            end
            2:begin
                case(countpair)
                    1:begin
                        case(outputstate)
                            0:begin
                                if(f1==f2)begin                                
                                    nextoutputstate=1;
                                end
                                else begin
                                    if(count<25'd33554431)begin
                                        nextcount=count+1;
                                    end
                                    else begin
                                        nextcount=0;
                                        AIcmd=`d;
                                        ischanged=1;
                                    end
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
                                    AIcmd=`f;
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
                                    AIcmd=`f;
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
                                    AIcmd=`l;
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
                                    AIcmd=`f_prime;
                                    ischanged=1;
                                end    
                            end
                            8:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextsidestate=3;
                                    AIcmd=`l;
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
                                    AIcmd=`d;
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
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end    
                            end
                            9:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=10;
                                    AIcmd=`u;
                                    ischanged=1;
                                end    
                            end
                            10:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=11;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end    
                            end
                            11:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextsidestate=3;
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
                                    AIcmd=`u_prime;
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
                                    AIcmd=`f_prime;
                                    ischanged=1;
                                end    
                            end
                            9:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=10;
                                    AIcmd=`r;
                                    ischanged=1;
                                end    
                            end
                            10:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=11;
                                    AIcmd=`u;
                                    ischanged=1;
                                end    
                            end
                            11:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=12;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end    
                            end
                            12:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=13;
                                    AIcmd=`u_prime;
                                    ischanged=1;
                                end 
                            end
                            13:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=14;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end 
                            end
                            14:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=15;
                                    AIcmd=`f;
                                    ischanged=1;
                                end 
                            end
                            15:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=16;
                                    AIcmd=`r;
                                    ischanged=1;
                                end 
                            end
                            16:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=17;
                                    AIcmd=`f_prime;
                                    ischanged=1;
                                end 
                            end
                            17:begin
                                if(f1==f2)begin
                                    nextsidestate=3;
                                end
                                else begin
                                    if(count<25'd33554431)begin
                                        nextcount=count+1;
                                    end
                                    else begin
                                        nextcount=0;
                                        AIcmd=`u;
                                        ischanged=1;
                                    end 
                                end
                            end
                        endcase   
                    end
                    5:begin
                        case(outputstate)
                            0:begin
                                if(b1==b3)begin
                                    nextoutputstate=1;
                                end
                                else begin
                                    if(count<25'd33554431)begin
                                        nextcount=count+1;
                                    end
                                    else begin
                                        nextcount=0;
                                        AIcmd=`u;
                                        ischanged=1;
                                    end
                                end                                
                            end
                            1:begin //start
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
                                    AIcmd=`r_prime;
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
                                    AIcmd=`f;
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
                                    AIcmd=`r;
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
                                    AIcmd=`r;
                                    ischanged=1;
                                end    
                            end
                            9:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=10;
                                    AIcmd=`u_prime;
                                    ischanged=1;
                                end    
                            end
                            10:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=11;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end    
                            end
                            11:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=12;
                                    AIcmd=`u_prime;
                                    ischanged=1;
                                end    
                            end
                            12:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=13;
                                    AIcmd=`r;
                                    ischanged=1;
                                end 
                            end
                            13:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=14;
                                    AIcmd=`u;
                                    ischanged=1;
                                end 
                            end
                            14:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextcount=0;
                                    nextoutputstate=15;
                                    AIcmd=`r_prime;
                                    ischanged=1;
                                end 
                            end
                            15:begin
                                if(count<25'd33554431)begin
                                    nextcount=count+1;
                                end
                                else begin
                                    nextsidestate=3;
                                    AIcmd=`f_prime;
                                    ischanged=1;
                                end 
                            end
                        endcase
                    end
                    default:begin
                        nextsidestate=3;
                    end
                endcase
            end
            3:begin  //end 
                if(f1!=f2&&b1!=b2)begin
                    nextsidestate=7;
                end
                else begin
                    AIcmd=5'b11111;
                    ischanged=0;
                    isdone=1;
                end
            end
            5:begin //zz to turn cube upsidedown
                case(outputstate)
                    0:begin
                        if(count<25'd33554431)begin
                            nextcount=count+1;
                        end
                        else begin
                            nextcount=0;
                            nextoutputstate=1;
                            AIcmd=`z;
                            ischanged=1;
                        end
                    end
                    1:begin
                        if(count<25'd33554431)begin
                            nextcount=count+1;
                        end
                        else begin
                            nextcount=0;
                            nextoutputstate=0;
                            nextsidestate=1;
                            AIcmd=`z;
                            ischanged=1;
                        end
                    end
                endcase
            end
            6:begin //rest   !!!!!!!!!!!!!!!!!!!!!!!!!!!
                if(count<25'd33554431)begin
                    nextcount=count+1;
                end
                else begin
                    nextcount=0;
                    nextsidestate=0;
                end
            end
            7:begin //u 
                if(count<25'd33554431)begin
                    nextcount=count+1;
                end
                else begin
                    nextcount=0;
                    nextsidestate=3;
                    AIcmd=`u;
                    ischanged=1;
                end
            end

            default:begin
                nextsidestate=3;
            end

        endcase
    end
end


endmodule
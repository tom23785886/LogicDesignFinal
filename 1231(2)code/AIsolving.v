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

`define Red 12'hf00
`define Green 12'h0f0
`define Blue 12'h00f
`define White 12'hfff
`define Orange 12'hf90
`define Yellow 12'hff0

`define f_face1 3'b000
`define f_face2 3'b001
`define f_face3 3'b010
`define b_face1 3'b011
`define b_face2 3'b100
`define b_face3 3'b101 

`define d_block1 3'b000
`define d_block2 3'b001
`define d_block3 3'b010
`define d_block4 3'b011
`define d_blockdefault 3'b100


//finding where is the white on the top of the cube except the down part
`define findwhiteblockf4 5'd1
`define findwhiteblockf6 5'd2
`define findwhiteblockf10 5'd3
`define findwhiteblockf8  5'd4
 
`define findwhiteblockb7 5'd5
`define findwhiteblockf11 5'd6
`define findwhiteblockb5 5'd7
`define findwhiteblockb3 5'd8

`define findwhiteblockf12 5'd9
`define findwhiteblockb1 5'd10
`define findwhiteblockf2 5'd11
`define findwhiteblockf9 5'd12

`define findwhiteblockf3 5'd13
`define findwhiteblockf5 5'd14
`define findwhiteblockf7 5'd15
`define findwhiteblockb8 5'd16

`define findwhiteblockb6 5'd17
`define findwhiteblockb4 5'd18
`define findwhiteblockb2 5'd19
`define findwhiteblockf1 5'd20
`define nowhitefound 5'd21



//// states
`define Initial 7'd0
`define Scan 7'd1
`define FindD 7'd2
`define Turning 7'd3
`define Turnagain 7'd4
`define Findspace 7'd5
`define TurningDown 7'd6
`define DownTurnagain 7'd7



`define f4_situation 7'd8
`define f6_situation 7'd9
`define f10_situation 7'd10
`define f8_situation 7'd11

`define b7_situation 7'd12
`define f11_situation 7'd13
`define b5_situation 7'd14
`define b3_situation 7'd15

`define f12_situation 7'd16
`define b1_situation 7'd17
`define f2_situation 7'd18
`define f9_situation 7'd19

`define f3_situation 7'd20
`define f5_situation 7'd21
`define f7_situation 7'd22
`define b8_situation 7'd23

`define b6_situation 7'd24
`define b4_situation 7'd25
`define b2_situation 7'd26
`define f1_situation 7'd27

`define findWhite 7'd28
`define readyturnwhite 7'd29
`define End 7'd30

`define f4_step2 7'd31
`define f4_step3 7'd32
`define f4_step4 7'd33
`define rest 7'd34

`define f6_step2 7'd35
`define f6_step3 7'd36
`define f6_step4 7'd37

`define f10_step2 7'd38
`define f10_step3 7'd39
`define f10_step4 7'd40
`define f10_step5 7'd41
`define f10_step6 7'd42

`define f8_step2 7'd43

`define b7_step2 7'd44

`define f11_step2 7'd45

`define b5_step2 7'd46
`define b5_step3 7'd47

`define b3_step2 7'd48
`define b3_step3 7'd49

`define f12_step2 7'd50
`define f12_step3 7'd51

`define b1_step2 7'd52

`define f2_step2 7'd53

`define f9_step2 7'd54

`define f3_step2 7'd55
`define f3_step3 7'd56
`define f3_step4 7'd57

`define f5_step2 7'd58
`define f5_step3 7'd59
`define f5_step4 7'd60

`define f7_step2 7'd61
`define b8_step2 7'd62

`define b6_step2 7'd63
`define b6_step3 7'd64

`define b4_step2 7'd56
`define b4_step3 7'd57 

`define b2_step2 7'd58
`define f1_step2 7'd59

`define maxcnt 27'd33554431

module AIsolving(clk,rst,ischanged,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12, b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12, AIcmd,ready,downfacedone);
    input wire clk;
    input wire rst;
    output reg ischanged;
    input wire ready;
    output reg downfacedone;
    input wire [11:0]f1;
    input wire [11:0]f2;
    input wire [11:0]f3;
    input wire [11:0]f4;
    input wire [11:0]f5;
    input wire [11:0]f6;
    input wire [11:0]f7;
    input wire [11:0]f8;
    input wire [11:0]f9;
    input wire [11:0]f10;
    input wire [11:0]f11;
    input wire [11:0]f12;

    input wire [11:0]b1;
    input wire [11:0]b2;
    input wire [11:0]b3;
    input wire [11:0]b4;
    input wire [11:0]b5;
    input wire [11:0]b6;
    input wire [11:0]b7;
    input wire [11:0]b8;
    input wire [11:0]b9;
    input wire [11:0]b10;
    input wire [11:0]b11;
    input wire [11:0]b12;

    output wire[4:0]AIcmd;

    reg [4:0]aicmd;
   
    reg [6:0]state;
    reg [6:0]nextstate;
    reg [4:0]nowblock;
    reg [4:0]nextnowblock;

    reg [3:0]f_face1_cnt;
    reg [3:0]f_face2_cnt;
    reg [3:0]f_face3_cnt;    
    reg [3:0]b_face1_cnt;
    reg [3:0]b_face2_cnt;
    reg [3:0]b_face3_cnt;

    reg [3:0]next_f_face1_cnt;
    reg [3:0]next_f_face2_cnt;
    reg [3:0]next_f_face3_cnt;    
    reg [3:0]next_b_face1_cnt;
    reg [3:0]next_b_face2_cnt;
    reg [3:0]next_b_face3_cnt;

    reg [2:0]facecnter;
    reg [2:0]nextfacecnter;
    reg [2:0]Dface;
    reg [2:0]nextDface;
    reg [3:0]maxwhite;
    reg [3:0]nextmaxwhite;
    reg [27:0]turncnt;
    reg [27:0]nextturncnt;
    reg [2:0]spaceblock;
    reg [2:0]nextspaceblock;
    reg [4:0]nowwhiteblock;
    reg [4:0]nextnowwhiteblock;

    wire aiclk;
    assign AIcmd=aicmd;
    clk_divider #(25) AIclk(.clk(clk),.clk_div(aiclk));


    always@(*)
        begin
            next_f_face1_cnt=f_face1_cnt;
            next_f_face2_cnt=f_face2_cnt;
            next_f_face3_cnt=f_face3_cnt;
            next_b_face1_cnt=b_face1_cnt;
            next_b_face2_cnt=b_face2_cnt;
            next_b_face3_cnt=b_face3_cnt;
            nextstate=state;
            aicmd=5'b11111;
            nextnowblock=nowblock;
            nextfacecnter=facecnter;
            nextDface=Dface;
            nextmaxwhite=maxwhite;
            nextturncnt=turncnt;
            nextspaceblock=spaceblock;
            nextnowwhiteblock=nowwhiteblock;
            ischanged=0;
            downfacedone=0;
            if(rst)
                begin
                    aicmd=5'b11111;
                    nextnowblock=5'b00000;                    
                    next_f_face1_cnt=4'b0000;
                    next_f_face2_cnt=4'b0000;
                    next_f_face3_cnt=4'b0000;
                    next_b_face1_cnt=4'b0000;
                    next_b_face2_cnt=4'b0000;
                    next_b_face3_cnt=4'b0000;    
                    nextfacecnter=3'b000;    
                    nextDface=`f_face1;   
                    nextmaxwhite=4'b0000;   
                    nextturncnt=0;      
                    nextspaceblock=`d_blockdefault;
                    nextnowwhiteblock=`nowhitefound;
                    nextstate=`Initial;
                end
            else
                begin
                    if(ready)begin
                        case(state)
                            `Initial:
                                begin                                
                                    aicmd=5'b11111;
                                    ischanged=0;
                                    nextnowblock=5'b00000;
                                    nextstate=`Scan;
                                end
                            `Scan:
                                begin
                                    aicmd=5'b11111;
                                    nextnowblock=nowblock+1;
                                    if(nowblock==5'd1)
                                        begin                                        
                                            if(f1==`White)begin next_f_face1_cnt=f_face1_cnt+1; end
                                            else begin next_f_face1_cnt=f_face1_cnt; end
                                        end
                                    else if(nowblock==5'd2)
                                        begin
                                            if(f2==`White)begin next_f_face1_cnt=f_face1_cnt+1; end
                                            else begin next_f_face1_cnt=f_face1_cnt; end
                                        end
                                    else if(nowblock==5'd3)
                                        begin
                                            if(f3==`White)begin next_f_face1_cnt=f_face1_cnt+1; end
                                            else begin next_f_face1_cnt=f_face1_cnt; end
                                        end
                                    else if(nowblock==5'd4)
                                        begin
                                            if(f4==`White)begin next_f_face1_cnt=f_face1_cnt+1; end
                                            else begin next_f_face1_cnt=f_face1_cnt; end
                                        end
                                    else if(nowblock==5'd5)
                                        begin
                                            if(f5==`White)begin next_f_face2_cnt=f_face2_cnt+1; end
                                            else begin next_f_face2_cnt=f_face2_cnt; end
                                        end
                                    else if(nowblock==5'd6)
                                        begin
                                            if(f6==`White)begin next_f_face2_cnt=f_face2_cnt+1; end
                                            else begin next_f_face2_cnt=f_face2_cnt; end
                                        end
                                    else if(nowblock==5'd7)
                                        begin
                                            if(f7==`White)begin next_f_face2_cnt=f_face2_cnt+1; end
                                            else begin next_f_face2_cnt=f_face2_cnt; end
                                        end
                                    else if(nowblock==5'd8)
                                        begin
                                            if(f8==`White)begin next_f_face2_cnt=f_face2_cnt+1; end
                                            else begin next_f_face2_cnt=f_face2_cnt; end
                                        end
                                    else if(nowblock==5'd9)
                                        begin
                                            if(f9==`White)begin next_f_face3_cnt=f_face3_cnt+1; end
                                            else begin next_f_face3_cnt=f_face3_cnt; end
                                        end
                                    else if(nowblock==5'd10)
                                        begin
                                            if(f10==`White)begin next_f_face3_cnt=f_face3_cnt+1; end
                                            else begin next_f_face3_cnt=f_face3_cnt; end
                                        end
                                    else if(nowblock==5'd11)
                                        begin
                                            if(f11==`White)begin next_f_face3_cnt=f_face3_cnt+1; end
                                            else begin next_f_face3_cnt=f_face3_cnt; end
                                        end
                                    else if(nowblock==5'd12)
                                        begin
                                            if(f12==`White)begin next_f_face3_cnt=f_face3_cnt+1; end
                                            else begin next_f_face3_cnt=f_face3_cnt; end
                                        end
                                    else if(nowblock==5'd13)
                                        begin
                                            if(b1==`White)begin next_b_face1_cnt=b_face1_cnt+1; end
                                            else begin next_b_face1_cnt=b_face1_cnt; end
                                        end
                                    else if(nowblock==5'd14)
                                        begin
                                            if(b2==`White)begin next_b_face1_cnt=b_face1_cnt+1; end
                                            else begin next_b_face1_cnt=b_face1_cnt; end
                                        end
                                    else if(nowblock==5'd15)
                                        begin
                                            if(b3==`White)begin next_b_face1_cnt=b_face1_cnt+1; end
                                            else begin next_b_face1_cnt=b_face1_cnt; end
                                        end
                                    else if(nowblock==5'd16)
                                        begin
                                            if(b4==`White)begin next_b_face1_cnt=b_face1_cnt+1; end
                                            else begin next_b_face1_cnt=b_face1_cnt; end
                                        end
                                    else if(nowblock==5'd17)
                                        begin
                                            if(b5==`White)begin next_b_face2_cnt=b_face2_cnt+1; end
                                            else begin next_b_face2_cnt=b_face2_cnt; end
                                        end
                                    else if(nowblock==5'd18)
                                        begin
                                            if(b6==`White)begin next_b_face2_cnt=b_face2_cnt+1; end
                                            else begin next_b_face2_cnt=b_face2_cnt; end
                                        end
                                    else if(nowblock==5'd19)
                                        begin
                                            if(b7==`White)begin next_b_face2_cnt=b_face2_cnt+1; end
                                            else begin next_b_face2_cnt=b_face2_cnt; end
                                        end
                                    else if(nowblock==5'd20)
                                        begin
                                            if(b8==`White)begin next_b_face2_cnt=b_face2_cnt+1; end
                                            else begin next_b_face2_cnt=b_face2_cnt; end
                                        end
                                    else if(nowblock==5'd21)
                                        begin
                                            if(b9==`White)begin next_b_face3_cnt=b_face3_cnt+1; end
                                            else begin next_b_face3_cnt=b_face3_cnt; end
                                        end
                                    else if(nowblock==5'd22)
                                        begin
                                            if(b10==`White)begin next_b_face3_cnt=b_face3_cnt+1; end
                                            else begin next_b_face3_cnt=b_face3_cnt; end
                                        end
                                    else if(nowblock==5'd23)
                                        begin
                                            if(b11==`White)begin next_b_face3_cnt=b_face3_cnt+1; end
                                            else begin next_b_face3_cnt=b_face3_cnt; end
                                        end
                                    else if(nowblock==5'd24)
                                        begin
                                            if(b12==`White)begin next_b_face3_cnt=b_face3_cnt+1; end
                                            else begin next_b_face3_cnt=b_face3_cnt; end
                                        end
                                    if(nowblock==5'd24)begin nextstate=`FindD; nextnowblock=0;end
                                    else begin nextstate=`Scan; end
                                end
                            `FindD:
                                begin
                                    nextfacecnter=facecnter+1;
                                    if(facecnter==3'd1)
                                        begin 
                                            if(f_face1_cnt>maxwhite) begin nextmaxwhite=f_face1_cnt; nextDface=`f_face1; end
                                            else begin nextmaxwhite=maxwhite; nextDface=Dface; end
                                        end
                                    else if(facecnter==3'd2)
                                        begin 
                                            if(f_face2_cnt>maxwhite) begin nextmaxwhite=f_face2_cnt; nextDface=`f_face2; end
                                            else begin nextmaxwhite=maxwhite; nextDface=Dface; end
                                        end
                                    else if(facecnter==3'd3)
                                        begin 
                                            if(f_face3_cnt>maxwhite) begin nextmaxwhite=f_face3_cnt; nextDface=`f_face3; end
                                            else begin nextmaxwhite=maxwhite; nextDface=Dface; end
                                        end
                                    else if(facecnter==3'd4)
                                        begin 
                                            if(b_face1_cnt>maxwhite) begin nextmaxwhite=b_face1_cnt; nextDface=`b_face1; end
                                            else begin nextmaxwhite=maxwhite; nextDface=Dface; end
                                        end
                                    else if(facecnter==3'd5)
                                        begin 
                                            if(b_face2_cnt>maxwhite) begin nextmaxwhite=b_face2_cnt; nextDface=`b_face2; end
                                            else begin nextmaxwhite=maxwhite; nextDface=Dface; end
                                        end
                                    else if(facecnter==3'd6)
                                        begin 
                                            if(b_face3_cnt>maxwhite) begin nextmaxwhite=b_face3_cnt; nextDface=`b_face3; end
                                            else begin nextmaxwhite=maxwhite; nextDface=Dface; end
                                            nextstate=`Turning;
                                            nextfacecnter=0;
                                        end
                                end
                            `Turning:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`Findspace;
                                            ischanged=1;
                                            nextturncnt=0;
                                            if(Dface==`f_face1) begin aicmd=`x_prime; end
                                            else if(Dface==`f_face2) begin aicmd=`z; end
                                            else if(Dface==`f_face3) begin aicmd=`z; nextstate=`Turnagain;end
                                            else if(Dface==`b_face1) begin aicmd=`z_prime; end
                                            else if(Dface==`b_face2) begin aicmd=`x; end
                                            else if(Dface==`b_face3) begin aicmd=5'b11111;end
                                            else begin aicmd=5'b11111; end
                                        end

                                end
                            `Turnagain:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`Findspace;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`z;
                                        end
                                end
                            `Findspace:
                                begin
                                    nextnowblock=nowblock+1;
                                    if(nowblock==5'd1)
                                        begin
                                            if(b12!=`White) begin nextspaceblock=`d_block1; end
                                            else begin nextspaceblock=spaceblock; end
                                        end
                                    else if(nowblock==5'd2)
                                        begin
                                            if(b11!=`White) begin nextspaceblock=`d_block2; end
                                            else begin nextspaceblock=spaceblock; end
                                        end
                                    else if(nowblock==5'd3)
                                        begin
                                            if(b10!=`White) begin nextspaceblock=`d_block3; end
                                            else begin nextspaceblock=spaceblock; end
                                        end
                                    else if(nowblock==5'd4)
                                        begin
                                            if(b9!=`White) begin nextspaceblock=`d_block4; end
                                            else begin nextspaceblock=spaceblock; end
                                            nextnowblock=0;
                                            nextstate=`TurningDown;
                                        end
                                end
                            `TurningDown:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`findWhite;
                                            ischanged=1;
                                            nextturncnt=0;
                                            if(spaceblock==`d_block1) begin aicmd=5'b11111; end
                                            else if(spaceblock==`d_block2) begin aicmd=`d_prime; end
                                            else if(spaceblock==`d_block3) begin aicmd=`d_prime; nextstate=`DownTurnagain;end
                                            else if(spaceblock==`d_block4) begin aicmd=`d; end
                                            else if(spaceblock==`d_blockdefault) begin aicmd=5'b11111; nextstate=`End; end
                                            else begin aicmd=5'b11111; end
                                        end
                                end
                            `DownTurnagain:
                                begin
                                     if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`findWhite;
                                            nextnowblock=0;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`d_prime;
                                        end
                                end
                            `findWhite:
                                begin
                                    nextnowblock=nowblock+1;
                                    if(nowblock==5'd1)
                                        begin
                                            if(f4==`White) begin nextnowwhiteblock=`findwhiteblockf4; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end
                                        end
                                    else if(nowblock==5'd2)
                                        begin
                                            if(f6==`White) begin nextnowwhiteblock=`findwhiteblockf6; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end
                                        end
                                    else if(nowblock==5'd3)
                                        begin
                                            if(f10==`White) begin nextnowwhiteblock=`findwhiteblockf10; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end
                                        end


                                    else if(nowblock==5'd4)
                                        begin
                                            if(f8==`White) begin nextnowwhiteblock=`findwhiteblockf8; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end
                                        end
                                    else if(nowblock==5'd5)
                                        begin
                                            if(b7==`White) begin nextnowwhiteblock=`findwhiteblockb7; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end 
                                        end
                                    else if(nowblock==5'd6)
                                        begin
                                            if(f11==`White) begin nextnowwhiteblock=`findwhiteblockf11; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end 
                                        end


                                    else if(nowblock==5'd7)
                                        begin
                                            if(b5==`White) begin nextnowwhiteblock=`findwhiteblockb5; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end 
                                        end
                                    else if(nowblock==5'd8)
                                        begin
                                            if(b3==`White) begin nextnowwhiteblock=`findwhiteblockb3; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end 
                                        end
                                    else if(nowblock==5'd9)
                                        begin
                                            if(f12==`White) begin nextnowwhiteblock=`findwhiteblockf12; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end
                                        end


                                    else if(nowblock==5'd10)
                                        begin
                                            if(b1==`White) begin nextnowwhiteblock=`findwhiteblockb1; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end 
                                        end
                                    else if(nowblock==5'd11)
                                        begin
                                            if(f2==`White) begin nextnowwhiteblock=`findwhiteblockf2; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end 
                                        end
                                    else if(nowblock==5'd12)
                                        begin
                                            if(f9==`White) begin nextnowwhiteblock=`findwhiteblockf9; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end 
                                        end


                                    else if(nowblock==5'd13)
                                        begin
                                            if(f3==`White) begin nextnowwhiteblock=`findwhiteblockf3; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end
                                        end
                                    else if(nowblock==5'd14)
                                        begin
                                            if(f5==`White) begin nextnowwhiteblock=`findwhiteblockf5; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end 
                                        end
                                    else if(nowblock==5'd15)
                                        begin
                                            if(f7==`White) begin nextnowwhiteblock=`findwhiteblockf7; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end
                                        end
                                    else if(nowblock==5'd16)
                                        begin
                                            if(b8==`White) begin nextnowwhiteblock=`findwhiteblockb8; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end
                                        end
                                    else if(nowblock==5'd17)
                                        begin
                                            if(b6==`White) begin nextnowwhiteblock=`findwhiteblockb6; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end 
                                        end
                                    else if(nowblock==5'd18)
                                        begin
                                            if(b4==`White) begin nextnowwhiteblock=`findwhiteblockb4; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end 
                                        end
                                    else if(nowblock==5'd19)
                                        begin
                                            if(b2==`White) begin nextnowwhiteblock=`findwhiteblockb2; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end 
                                        end
                                    else if(nowblock==5'd20)
                                        begin
                                            if(f1==`White) begin nextnowwhiteblock=`findwhiteblockf1; end
                                            else begin nextnowwhiteblock=nowwhiteblock; end 
                                            nextnowblock=0;
                                            nextstate=`readyturnwhite;
                                        end
                                end
                            `readyturnwhite:
                                begin
                                     if(nowwhiteblock==`findwhiteblockf4) begin nextstate=`f4_situation; end
                                     else if(nowwhiteblock==`findwhiteblockf6) begin nextstate=`f6_situation; end
                                     else if(nowwhiteblock==`findwhiteblockf10) begin nextstate=`f10_situation; end

                                     else if(nowwhiteblock==`findwhiteblockf8) begin nextstate=`f8_situation; end
                                     else if(nowwhiteblock==`findwhiteblockb7) begin nextstate=`b7_situation; end
                                     else if(nowwhiteblock==`findwhiteblockf11) begin nextstate=`f11_situation; end
                                     else if(nowwhiteblock==`findwhiteblockb5) begin nextstate=`b5_situation; end
                                     else if(nowwhiteblock==`findwhiteblockb3) begin nextstate=`b3_situation; end
                                     else if(nowwhiteblock==`findwhiteblockf12) begin nextstate=`f12_situation; end
                                     else if(nowwhiteblock==`findwhiteblockb1) begin nextstate=`b1_situation; end
                                     else if(nowwhiteblock==`findwhiteblockf2) begin nextstate=`f2_situation; end
                                     else if(nowwhiteblock==`findwhiteblockf9) begin nextstate=`f9_situation; end
                                     else if(nowwhiteblock==`findwhiteblockf3) begin nextstate=`f3_situation; end
                                     else if(nowwhiteblock==`findwhiteblockf5) begin nextstate=`f5_situation; end
                                     else if(nowwhiteblock==`findwhiteblockf7) begin nextstate=`f7_situation; end
                                     else if(nowwhiteblock==`findwhiteblockb8) begin nextstate=`b8_situation; end
                                     else if(nowwhiteblock==`findwhiteblockb6) begin nextstate=`b6_situation; end
                                     else if(nowwhiteblock==`findwhiteblockb4) begin nextstate=`b4_situation; end
                                     else if(nowwhiteblock==`findwhiteblockb2) begin nextstate=`b2_situation; end
                                     else if(nowwhiteblock==`findwhiteblockf1) begin nextstate=`f1_situation; end
                                     else if(nowwhiteblock==`nowhitefound) begin nextstate=`End; end
                                end
                            `f4_situation:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f4_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u;
                                        end
                                end
                            `f4_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f4_step3;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`r;
                                        end
                                end
                            `f4_step3:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f4_step4;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u_prime;
                                        end
                                end
                            `f4_step4:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`rest;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`r_prime;
                                        end
                                end
                            //////////////////////////f6
                            `f6_situation:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f6_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u_prime;
                                        end
                                end
                            `f6_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f6_step3;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`f_prime;
                                        end
                                end
                            `f6_step3:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f6_step4;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u;
                                        end
                                end
                            `f6_step4:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`rest;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`f;
                                        end
                                end

                            ///////////////////f10
                            `f10_situation:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f10_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`f_prime;
                                        end
                                end
                            `f10_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f10_step3;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u;
                                        end
                                end
                            `f10_step3:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f10_step4;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u;
                                        end
                                end
                            `f10_step4:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f10_step5;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`f;
                                        end
                                end
                            `f10_step5:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f10_step6;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u;
                                        end
                                end
                            `f10_step6:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f4_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end
                            ///////////////////////f8
                            `f8_situation:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f8_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u;
                                        end
                                end
                            `f8_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f4_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end
                            /////////////b7
                            `b7_situation:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`b7_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u;
                                        end
                                end
                            `b7_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f6_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end

                            /////////////////////f11
                            `f11_situation:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f11_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u;
                                        end
                                end
                            `f11_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f10_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end
                            
                            //////////////////////b5
                            `b5_situation:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`b5_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u;
                                        end
                                end
                            `b5_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`b5_step3;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u;
                                        end
                                end
                            `b5_step3:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f4_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end

                            ///////////////////b3
                            `b3_situation:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`b3_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u;
                                        end
                                end
                            `b3_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`b3_step3;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u;
                                        end
                                end
                            `b3_step3:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f6_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end
                            ///////////////////f12
                            `f12_situation:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f12_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u;
                                        end
                                end
                            `f12_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f12_step3;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u;
                                        end
                                end
                            `f12_step3:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f10_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end
                            /////////////////////////b1
                            `b1_situation:
                                begin
                                     if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`b1_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u_prime;
                                        end
                                end
                            `b1_step2:
                                begin
                                     if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f4_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end
                            
                            //////////////////f2
                            `f2_situation:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f2_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u_prime;
                                        end
                                end
                            `f2_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f6_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end

                            ////////////////////f9
                            `f9_situation:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f9_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u_prime;
                                        end
                                end
                            `f9_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f10_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end
                            //////////////////////f3
                            `f3_situation:
                                begin
                                     if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f3_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`r;
                                        end
                                end
                            `f3_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f3_step3;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u_prime;
                                        end
                                end
                            `f3_step3:
                                begin
                                     if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f3_step4;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`r_prime;
                                        end
                                end
                            `f3_step4:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f4_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end
                            /////////////////f5
                            `f5_situation:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f5_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`f_prime;
                                        end
                                end
                            `f5_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f5_step3;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`u;
                                        end
                                end
                            `f5_step3:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f5_step4;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`f;
                                        end
                                end
                            `f5_step4:
                                begin
                                     if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f6_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end
                            //////////////////f7
                            `f7_situation:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f7_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`d_prime;
                                        end
                                end
                            `f7_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f3_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end

                            /////////////////////b8
                            `b8_situation:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`b8_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`d_prime;
                                        end
                                end
                            `b8_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f5_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end
                            
                            //////////////////b6
                            `b6_situation:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`b6_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`d_prime;
                                        end
                                end
                            `b6_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`b6_step3;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`d_prime;
                                        end
                                end
                            `b6_step3:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f3_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end
                            
                            ///////////////////b4
                            `b4_situation:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`b4_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`d_prime;
                                        end
                                end
                            `b4_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`b4_step3;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`d_prime;
                                        end
                                end
                            `b4_step3:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f5_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end

                            ///////////////////b2
                            `b2_situation:
                                begin
                                     if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`b2_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`d;
                                        end
                                end
                            `b2_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f3_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end

                            ////////////////////////////////f1
                            `f1_situation:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f1_step2;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=`d;
                                        end
                                end
                            `f1_step2:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`f5_situation;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end
                                end
                            `rest:
                                begin
                                    if(turncnt<`maxcnt)
                                        begin
                                            nextturncnt=turncnt+1;
                                        end
                                    else
                                        begin
                                            nextstate=`Findspace;
                                            nextspaceblock=`d_blockdefault;
                                            nextnowwhiteblock=`nowhitefound;
                                            ischanged=1;
                                            nextturncnt=0;
                                            aicmd=5'b11111;
                                        end

                                end
                            `End:
                                begin
                                    nextstate=`End;
                                    aicmd=5'b11111;
                                    downfacedone=1;
                                end
                        endcase

                    end
                    
                end
        end

    always@(posedge clk or posedge rst)
        begin 
            if(rst)
                begin 
                   
                    nowblock<=5'b00000;
                    f_face1_cnt<=4'b0000;
                    f_face2_cnt<=4'b0000;
                    f_face3_cnt<=4'b0000;
                    b_face1_cnt<=4'b0000;
                    b_face2_cnt<=4'b0000;
                    b_face3_cnt<=4'b0000; 
                    facecnter<=3'b000;
                    Dface<=`f_face1;
                    maxwhite<=4'b0000;
                    turncnt<=0;
                    state<=`Initial;
                    spaceblock<=`d_blockdefault;
                    nowwhiteblock<=`nowhitefound;
                end
            else
                begin
                    
                    state<=nextstate;
                    nowblock<=nextnowblock;
                    f_face1_cnt<=next_f_face1_cnt;
                    f_face2_cnt<=next_f_face2_cnt;
                    f_face3_cnt<=next_f_face3_cnt;
                    b_face1_cnt<=next_b_face1_cnt;
                    b_face2_cnt<=next_b_face2_cnt;
                    b_face3_cnt<=next_b_face3_cnt; 
                    facecnter<=nextfacecnter;
                    Dface<=nextDface;
                    maxwhite<=nextmaxwhite;
                    turncnt<=nextturncnt;
                    spaceblock<=nextspaceblock;
                    nowwhiteblock<=nextnowwhiteblock;
                end
        end

endmodule
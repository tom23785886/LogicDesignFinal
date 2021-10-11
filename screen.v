`define red 3'b000
`define green 3'b001
`define blue 3'b010
`define white 3'b011
`define orange 3'b100
`define yellow 3'b101
`define black 3'b111
`define coloring 2'b00
`define returnblack 2'b01
module screen(input wire clk,input wire rst,output[3:0]vgaRed,output[3:0]vgaGreen,output [3:0]vgaBlue,output hsync,output vsync,
input [2:0]color,input [3:0]blockcommand,input isenter,input choosing,input[4:0]keyboardcommand,input ischanged,input auto,output[15:0] led,output isdone,input ismotor);
    wire clk_25MHz;
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480


     clock_divisor clk_wiz_0_inst(
      .clk(clk),
      .clk1(clk_25MHz)
    );

   pixel_gen pixel_gen_inst(
       .h_cnt(h_cnt),
       .v_cnt(v_cnt),
       .clk(clk),
       .rst(rst),
       .valid(valid),
       .vgaRed(vgaRed),
       .vgaGreen(vgaGreen),
       .vgaBlue(vgaBlue),
       .color(color),
       .blockcommand(blockcommand),
       .isenter(isenter),
       .choosing(choosing),
       .keyboardcommand(keyboardcommand),
       .keyboardischanged(ischanged),
       .auto(auto),
       .led(led),
       .isdone(isdone),
       .ismotor(ismotor)

    );
    vga_controller   vga_inst(
      .pclk(clk_25MHz),
      .reset(rst),
      .hsync(hsync),
      .vsync(vsync),
      .valid(valid),
      .h_cnt(h_cnt),
      .v_cnt(v_cnt)
    );
endmodule
module clock_divisor(clk1, clk);
input clk;
output clk1;

reg [1:0] num;
wire [1:0] next_num;

always @(posedge clk) begin
  num <= next_num;
end

assign next_num = num + 1'b1;
assign clk1 = num[1];

endmodule
module pixel_gen(
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   input clk,
   input rst,
   input valid,
   input [2:0]color,
   input [3:0]blockcommand,
   input isenter,
   input choosing,
   input [4:0]keyboardcommand,
   input ismotor,
   output reg [3:0] vgaRed,
   output reg [3:0] vgaGreen,
   output reg [3:0] vgaBlue,
   input wire keyboardischanged,
   input wire auto,
   output wire[15:0]led,
   output wire isdone
   );
   wire v_1;
   wire v_2;
   wire v_3;
   wire v_4;
   wire h_1;
   wire h_2;
   wire h_3;
   wire h_4;
   wire h_5;
   wire h_6;
   wire h_7;
   wire h_8;
   wire h_9;
   wire h_10;
   wire h_11;
   wire blackpart1;
   wire blackpart2;
   wire blackpart3;
   wire blackpart4;
   wire blackpart5;
   wire blackpart6;
   wire blackpart7;
   wire blackpart8;
   wire blackpart9;
   wire blackpart10;
   wire block1;
   wire block2;
   wire block3;
   wire block4;
   wire block5;
   wire block6;
   wire block7;
   wire block8;
   wire block9;
   wire block10;
   wire block11;
   wire block12;
   wire bound1;
   wire bound2;
   wire bound3;
   wire bound4;
   wire bound5;
   wire bound6;
   wire frame1;
   wire frame2;
   wire frame3;
   wire frame4;
   wire frame5;
   wire frame6;
   wire frame7;
   wire frame8;
   wire frame9;
   wire frame;
   wire frame10;
   wire frame11;
   wire frame12;
   wire blank;
  
   reg [2:0]color1,nextcolor1;
   reg [2:0]color2,nextcolor2;
   reg [2:0]color3,nextcolor3;
   reg [2:0]color4,nextcolor4;
   reg [2:0]color5,nextcolor5;
   reg [2:0]color6,nextcolor6;
   reg [2:0]color7,nextcolor7;
   reg [2:0]color8,nextcolor8;
   reg [2:0]color9,nextcolor9;
   reg [2:0]color10,nextcolor10;
   reg [2:0]color11,nextcolor11;
   reg [2:0]color12,nextcolor12; 
   reg [11:0] colors1,colors2,colors3,colors4,colors5,colors6,colors7,colors8,colors9,colors10,colors11,colors12;
   reg [11:0] nextcolors1,nextcolors2,nextcolors3,nextcolors4,nextcolors5,nextcolors6,nextcolors7,nextcolors8,nextcolors9,nextcolors10,nextcolors11,nextcolors12;
   reg [1:0]state;
   reg [1:0]nextstate;
   wire isenter_de;
   wire isenter_pul;
   wire clk13;
   reg [2:0]entercnt;
   reg [2:0]nextentercnt;
   reg entering;
   reg [1:0]cnt2;
   reg [1:0]nextcnt2;
   reg flag;
   reg nextflag;
//    reg flag2;
//    reg nextflag2;
   wire colorfull;
   wire b_1,b_2,b_3,b_4,b_5,b_6,b_7,b_8;
   wire [11:0] b1;
   wire [11:0] b2;
   wire [11:0] b3;
   wire [11:0] b4;
   wire [11:0] b5;
   wire [11:0] b6;
   wire [11:0] b7;
   wire [11:0] b8;
   wire [11:0] b9;
   wire [11:0] b10;
   wire [11:0] b11;
   wire [11:0] b12;
   wire [11:0] b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, b24;

    wire [4:0]downfacecommand,command,topfacecommand,sidefacecommand;
    wire downfaceischanged,topfaceischanged,sidefaceischanged;
   wire [11:0]f_colors1,f_colors2,f_colors3,f_colors4,f_colors5,f_colors6,f_colors7,f_colors8,f_colors9,f_colors10,f_colors11,f_colors12;
   wire [11:0]b_colors1,b_colors2,b_colors3,b_colors4,b_colors5,b_colors6,b_colors7,b_colors8,b_colors9,b_colors10,b_colors11,b_colors12;
   reg prechoosing;
   cube_cntrl cub1(.clk(clk),.rst(rst),.command(command),.colors1(f_colors1),.colors2(f_colors2),.colors3(f_colors3),.colors4(f_colors4),.colors5(f_colors5),.colors6(f_colors6),
   .colors7(f_colors7),.colors8(f_colors8),.colors9(f_colors9),.colors10(f_colors10),.colors11(f_colors11),.colors12(f_colors12),
   .colors13(b_colors1),.colors14(b_colors2),.colors15(b_colors3),.colors16(b_colors4),.colors17(b_colors5),.colors18(b_colors6),.colors19(b_colors7),
   .colors20(b_colors8),.colors21(b_colors9),.colors22(b_colors10),.colors23(b_colors11),.colors24(b_colors12),
   .b1(b1),.b2(b2),.b3(b3),.b4(b4),.b5(b5),.b6(b6),.b7(b7),.b8(b8),.b9(b9),.b10(b10),.b11(b11),.b12(b12),
   .b13(b13),.b14(b14),.b15(b15),.b16(b16),.b17(b17),.b18(b18),.b19(b19),.b20(b20),.b21(b21),.b22(b22),.b23(b23),.b24(b24),
   .choosing(choosing),.entercnt(entercnt),.ischanged(ischanged));

//sol
    
    wire downfaceready,downfacedone,topfaceready,topfacedone,sidefaceready;
    wire [3:0]testing;
    AIsolving sol0(.clk(clk),.rst(rst),.ischanged(downfaceischanged),.f1(b1),.f2(b2),.f3(b3),.f4(b4),.f5(b5),.f6(b6),.f7(b7),.f8(b8),.f9(b9),.f10(b10),.f11(b11),.f12(b12),
    .b1(b13),.b2(b14),.b3(b15),.b4(b16),.b5(b17),.b6(b18),.b7(b19),.b8(b20),.b9(b21),.b10(b22),.b11(b23),.b12(b24), .AIcmd(downfacecommand),.ready(downfaceready)
    ,.downfacedone(downfacedone),.ismotor(ismotor));
    solvetop sol1(.clk(clk),.rst(rst),.ischanged(topfaceischanged),.f2(b2),.f4(b4),.f6(b6),.f8(b8),.f9(b9),.f10(b10),.f11(b11),.f12(b12),
    .b1(b13),.b3(b15),.b5(b17),.b7(b19),/*.b10(b22),.b11(b23),.b12(b24),*/ .AIcmd(topfacecommand),.ready(topfaceready)
    ,.topfacedone(topfacedone),.ismotor(ismotor)
    );
    solveside sol2(.clk(clk),.rst(rst),.ischanged(sidefaceischanged),.f1(b1),.f2(b2),.f3(b3),.f4(b4),.f5(b5),.f6(b6),.f7(b7),.f8(b8),
    /*.f9(b9),.f10(b10),.f11(b11),.f12(b12),*/
    .b1(b13),.b2(b14),.b3(b15),.b4(b16),.b5(b17),.b6(b18),.b7(b19),.b8(b20),
    /*.b9(b21),.b10(b22),.b11(b23),.b12(b24), */
    .AIcmd(sidefacecommand),.ready(sidefaceready)
    ,.isdone(isdone),.testing(testing),.ismotor(ismotor)
    );

    assign led=(isdone)?16'b1111_1111_1111_1111:(topfacedone)?16'b0000_0011_1111_1111:(downfacedone)?16'b0000_0000_0001_1111:16'b0000_0000_0000_0000;
    assign downfaceready=(auto==1&&choosing==0&&entercnt>=2)? 1:0;
    assign topfaceready=(downfacedone==1)? 1:0;
    assign sidefaceready=(topfacedone==1)? 1:0;

   assign command=(auto==0)? keyboardcommand:(downfacedone==0)? downfacecommand:(topfacedone==0)? topfacecommand:sidefacecommand;
   assign ischanged=(auto==0)? keyboardischanged:(downfacedone==0)? downfaceischanged:(topfacedone==0)? topfaceischanged:sidefaceischanged;

//assign ischanged=keyboardischanged;



   assign v_1=(h_cnt>222&&h_cnt<268)?1'b1:1'b0;
   assign v_2=(h_cnt>272&&h_cnt<318)?1'b1:1'b0;
   assign v_3=(h_cnt>322&&h_cnt<368)?1'b1:1'b0;
   assign v_4=(h_cnt>372&&h_cnt<418)?1'b1:1'b0;

   assign h_1=(427*(v_cnt)<105042+h_cnt*234)?1'b1:1'b0;
   assign h_2=(427*(v_cnt+100)<105042+h_cnt*234)?1'b1:1'b0;
   assign h_3=(427*(v_cnt+200)<105042+h_cnt*234)?1'b1:1'b0;
   assign h_4=(1732*v_cnt<1000*h_cnt-37197)?1'b1:1'b0;
   assign h_5=(1732*v_cnt<1000*h_cnt-137209)?1'b1:1'b0;
   assign h_6=(1000*h_cnt+1732*v_cnt<508490)?1'b1:1'b0;
   assign h_7=(1000*h_cnt+1732*v_cnt<606017)?1'b1:1'b0;
   assign h_8=(1000*h_cnt+1732*v_cnt<702783)?1'b1:1'b0;
   assign h_9=(1000*h_cnt+1732*(v_cnt-100)<702783)?1'b1:1'b0;
   assign h_10=(1000*h_cnt+1732*(v_cnt-200)<702783)?1'b1:1'b0;

   assign b_1=(427*(v_cnt-2)<105042+h_cnt*234 && 427*(v_cnt+100+2)>105042+h_cnt*234)? 1:0;
   assign b_2=(427*(v_cnt+100-2)<105042+h_cnt*234 && 427*(v_cnt+200+2)>105042+h_cnt*234)? 1:0;
   assign b_3=(427*(v_cnt+200-2)<105042+h_cnt*234 && 1732*(v_cnt+2)>1000*h_cnt-37197)? 1:0;
   assign b_4=(1732*(v_cnt-2)<1000*h_cnt-37197 && 1732*(v_cnt+2)>1000*h_cnt-137209)? 1:0;
   assign b_5=(1000*h_cnt+1732*(v_cnt-200-2)<702783 && 1000*h_cnt+1732*(v_cnt-100+2)>702783)? 1:0;
   assign b_6=(1000*h_cnt+1732*(v_cnt-100-2)<702783 && 1000*h_cnt+1732*(v_cnt+2)>702783)? 1:0;
   assign b_7=(1000*h_cnt+1732*(v_cnt-2)<702783 && 1000*h_cnt+1732*(v_cnt+2)>606017)? 1:0;
   assign b_8=(1000*h_cnt+1732*(v_cnt-2)<606017 && 1000*h_cnt+1732*(v_cnt+2)>508490)? 1:0;


   assign blackpart1=((427*(v_cnt-2)<105042+h_cnt*234)&&(427*(v_cnt+2)>105042+h_cnt*234))?1'b1:1'b0;
   assign blackpart2=((427*(v_cnt+100-2)<105042+h_cnt*234)&&(427*(v_cnt+100+2)>105042+h_cnt*234))?1'b1:1'b0;
   assign blackpart3=((427*(v_cnt+200-2)<105042+h_cnt*234)&&(427*(v_cnt+200+2)>105042+h_cnt*234))?1'b1:1'b0;

   assign blackpart4=((1000*h_cnt+1732*(v_cnt-200-2)<702783)&&(1000*h_cnt+1732*(v_cnt-200+2)>702783))?1'b1:1'b0;
   assign blackpart5=((1000*h_cnt+1732*(v_cnt-100-2)<702783)&&(1000*h_cnt+1732*(v_cnt-100+2)>702783))?1'b1:1'b0;
   assign blackpart6=((1000*h_cnt+1732*(v_cnt-2)<702783)&&(1000*h_cnt+1732*(v_cnt+2)>702783))?1'b1:1'b0;

   assign blackpart7=((1732*(v_cnt-2)<1000*h_cnt-37197)&&(1732*(v_cnt+2)>1000*h_cnt-37197))?1'b1:1'b0;
   assign blackpart8=((1732*(v_cnt-2)<1000*h_cnt-137209)&&(1732*(v_cnt+2)>1000*h_cnt-137209))?1'b1:1'b0;

   assign blackpart9=((1000*h_cnt+1732*(v_cnt-2)<606017)&&(1000*h_cnt+1732*(v_cnt+2)>606017))?1'b1:1'b0;
   assign blackpart10=((1000*h_cnt+1732*(v_cnt-2)<508490)&&(1000*h_cnt+1732*(v_cnt+2)>508490))?1'b1:1'b0;


    assign block1=(v_1&&b_1&&!blackpart1&&!blackpart2)?1'b1:1'b0;
    assign block2=(v_1&&b_2&&!blackpart2&&!blackpart3)?1'b1:1'b0;
    assign block3=(v_2&&b_1&&!blackpart1&&!blackpart2)?1'b1:1'b0;
    assign block4=(v_2&&b_2&&!blackpart2&&!blackpart3)?1'b1:1'b0;

    assign block5=(v_3&&b_5&&!blackpart4&&!blackpart5)?1'b1:1'b0;
    assign block6=(v_3&&b_6&&!blackpart5&&!blackpart6)?1'b1:1'b0;
    assign block7=(v_4&&b_5&&!blackpart4&&!blackpart5)?1'b1:1'b0;
    assign block8=(v_4&&b_6&&!blackpart5&&!blackpart6)?1'b1:1'b0;
    assign block9=(b_3&&b_8&&!blackpart3&&!blackpart7&&!blackpart9&&!blackpart10)?1'b1:1'b0;
    assign block10=(b_3&&b_7&&!blackpart6&&!blackpart3&&!blackpart7&&!blackpart9)?1'b1:1'b0;
    assign block11=(b_4&&b_7&&!blackpart6&&!blackpart7&&!blackpart8&&!blackpart9)?1'b1:1'b0;
    assign block12=(b_4&&b_8&&!blackpart7&&!blackpart8&&!blackpart9&&!blackpart10)?1'b1:1'b0;

    assign bound1=(h_cnt<220-2)?1'b1:1'b0;
    assign bound2=(h_cnt>420+2)?1'b1:1'b0;
    assign bound3=(1000*h_cnt+1732*(v_cnt+2)<508490)?1'b1:1'b0;
    assign bound4=(427*(v_cnt-2)>105042+h_cnt*234)?1'b1:1'b0;
    assign bound5=(1732*(v_cnt+2)<1000*h_cnt-137209)?1'b1:1'b0;
    assign bound6=(1000*h_cnt+1732*(v_cnt-200-2)>702783)?1'b1:1'b0;
    assign blank=(bound1|bound2|bound3|bound4|bound5|bound6);


    assign frame1=((blackpart2&&h_cnt>218&&h_cnt<272)||(h_cnt>270-2&&h_cnt<270+2&&h_1&&!h_2)||(blackpart1&&h_cnt>218&&h_cnt<272)||(h_cnt<222&&!blank&&!h_2));
    assign frame2=((blackpart3&&h_cnt>218&&h_cnt<272)||(h_cnt>270-2&&h_cnt<270+2&&h_2&&!h_3)||(blackpart2&&h_cnt>218&&h_cnt<272)||(h_cnt<222&&!blank&&!h_3&&h_2));
    assign frame3=((h_cnt>270-2&&h_cnt<270+2&&h_1&&!h_2)||(h_cnt>270-2&&h_cnt<320+2&&blackpart1)||(h_cnt>320-2&&h_cnt<320+2&&h_1&&!h_2)||(h_cnt>270-2&&h_cnt<320+2&&blackpart2));
    assign frame4=((h_cnt>270-2&&h_cnt<270+2&&h_2&&!h_3)||(h_cnt>270-2&&h_cnt<320+2&&blackpart2)||(h_cnt>320-2&&h_cnt<320+2&&h_2&&!h_3)||(h_cnt>270-2&&h_cnt<320+2&&blackpart3));
    assign frame5=((h_cnt>320-2&&h_cnt<320+2&&h_1&&!h_2)||(h_cnt>320-2&&h_cnt<370+2&&blackpart4)||(h_cnt>370-2&&h_cnt<370+2&&h_10&&!h_9)||(h_cnt>320-2&&h_cnt<370+2&&blackpart5));
    assign frame6=((h_cnt>320-2&&h_cnt<320+2&&h_2&&!h_3)||(h_cnt>320-2&&h_cnt<370+2&&blackpart5)||(h_cnt>370-2&&h_cnt<370+2&&h_9&&!h_8)||(h_cnt>320-2&&h_cnt<370+2&&blackpart6));
    assign frame7=((h_cnt>370-2&&h_cnt<370+2&&h_10&&!h_9)||(h_cnt>370-2&&h_cnt<420+2&&blackpart4)||(h_cnt>420-2&&h_cnt<420+2&&h_10&&!h_9)||(h_cnt>370-2&&h_cnt<420+2&&blackpart5));
    assign frame8=((h_cnt>370-2&&h_cnt<370+2&&h_9&&!h_8)||(h_cnt>370-2&&h_cnt<420+2&&blackpart5)||(h_cnt>420-2&&h_cnt<420+2&&h_9&&!h_8)||(h_cnt>370-2&&h_cnt<420+2&&blackpart6));
    assign frame9=((h_cnt>220-2&&h_cnt<270+2&&blackpart3)||(h_3&&!h_4&&blackpart9)||(h_7&&!h_6&&blackpart7)||(h_3&&!h_4&&blackpart10));
    assign frame10=((h_cnt>270-2&&h_cnt<320+2&&blackpart3)||(h_3&&!h_4&&blackpart6)||(h_8&&!h_7&&blackpart7)||(h_3&&!h_4&&blackpart9));
    assign frame11=((h_8&&!h_7&&blackpart7)||(h_4&&!h_5&&blackpart6)||(h_8&&!h_7&&blackpart8)||(h_4&&!h_5&&blackpart9));
    assign frame12=((h_7&&!h_6&&blackpart7)||(h_4&&!h_5&&blackpart9)||(h_7&&!h_6&&blackpart8)||(h_4&&!h_5&&blackpart10));
    assign frame=blockcommand==1?frame1:
                 blockcommand==2?frame2:
                 blockcommand==3?frame3:
                 blockcommand==4?frame4:
                 blockcommand==5?frame5:
                 blockcommand==6?frame6:
                 blockcommand==7?frame7:
                 blockcommand==8?frame8:
                 blockcommand==9?frame9:
                 blockcommand==10?frame10:
                 blockcommand==11?frame11:
                 blockcommand==12?frame12:
                 frame1;
        always@(posedge clk or posedge rst)begin
            if(rst)begin
                color1<=3'b111;
                color2<=3'b111;
                color3<=3'b111;
                color4<=3'b111;
                color5<=3'b111;
                color6<=3'b111;
                color7<=3'b111;
                color8<=3'b111;
                color9<=3'b111;
                color10<=3'b111;
                color11<=3'b111;
                color12<=3'b111;

                colors1<=12'h0;
                colors2<=12'h0;
                colors3<=12'h0;
                colors4<=12'h0;
                colors5<=12'h0;
                colors6<=12'h0;
                colors7<=12'h0;
                colors8<=12'h0;
                colors9<=12'h0;
                colors10<=12'h0;
                colors11<=12'h0;
                colors12<=12'h0;
                state<=2'b00;
                flag<=1'b0;
                // flag2<=1'b0;
                prechoosing<=0;
            end
            else begin
                color1<=nextcolor1;
                color2<=nextcolor2;
                color3<=nextcolor3;
                color4<=nextcolor4;
                color5<=nextcolor5;
                color6<=nextcolor6;
                color7<=nextcolor7;
                color8<=nextcolor8;
                color9<=nextcolor9;
                color10<=nextcolor10;
                color11<=nextcolor11;
                color12<=nextcolor12;

                colors1<=nextcolors1;
                colors2<=nextcolors2;
                colors3<=nextcolors3;
                colors4<=nextcolors4;
                colors5<=nextcolors5;
                colors6<=nextcolors6;
                colors7<=nextcolors7;
                colors8<=nextcolors8;
                colors9<=nextcolors9;
                colors10<=nextcolors10;
                colors11<=nextcolors11;
                colors12<=nextcolors12;
                state<=nextstate;
                flag<=nextflag;
                //flag2<=nextflag2;
                prechoosing<=choosing;
            end
        end
        always@(*)begin
            nextcolor1=(blockcommand==1&&choosing)? color:color1;
            nextcolor2=(blockcommand==2&&choosing)? color:color2;
            nextcolor3=(blockcommand==3&&choosing)? color:color3;
            nextcolor4=(blockcommand==4&&choosing)? color:color4;
            nextcolor5=(blockcommand==5&&choosing)? color:color5;
            nextcolor6=(blockcommand==6&&choosing)? color:color6;
            nextcolor7=(blockcommand==7&&choosing)? color:color7;
            nextcolor8=(blockcommand==8&&choosing)? color:color8;
            nextcolor9=(blockcommand==9&&choosing)? color:color9;
            nextcolor10=(blockcommand==10&&choosing)? color:color10;
            nextcolor11=(blockcommand==11&&choosing)? color:color11;
            nextcolor12=(blockcommand==12&&choosing)? color:color12;
            nextcolors1=colors1;
            nextcolors2=colors2;
            nextcolors3=colors3;
            nextcolors4=colors4;
            nextcolors5=colors5;
            nextcolors6=colors6;
            nextcolors7=colors7;
            nextcolors8=colors8;
            nextcolors9=colors9;
            nextcolors10=colors10;
            nextcolors11=colors11;
            nextcolors12=colors12;
            nextflag=flag;
           // nextflag2=flag2;
            nextstate=state;
            if(choosing)
                begin
                    case(state)
                        `coloring:
                            begin
                                nextcolors1=(prechoosing==0&&choosing==1)? 12'h0:(color1==3'b000)?12'hf00:(color1==3'b001)?12'h0f0:(color1==3'b010)?12'h00f:(color1==3'b011)?12'hfff:(color1==3'b100)?12'hf90:(color1==3'b101)?12'hff0:colors1;
                                nextcolors2=(prechoosing==0&&choosing==1)? 12'h0:(color2==3'b000)?12'hf00:(color2==3'b001)?12'h0f0:(color2==3'b010)?12'h00f:(color2==3'b011)?12'hfff:(color2==3'b100)?12'hf90:(color2==3'b101)?12'hff0:colors2;
                                nextcolors3=(prechoosing==0&&choosing==1)? 12'h0:(color3==3'b000)?12'hf00:(color3==3'b001)?12'h0f0:(color3==3'b010)?12'h00f:(color3==3'b011)?12'hfff:(color3==3'b100)?12'hf90:(color3==3'b101)?12'hff0:colors3;
                                nextcolors4=(prechoosing==0&&choosing==1)? 12'h0:(color4==3'b000)?12'hf00:(color4==3'b001)?12'h0f0:(color4==3'b010)?12'h00f:(color4==3'b011)?12'hfff:(color4==3'b100)?12'hf90:(color4==3'b101)?12'hff0:colors4;
                                nextcolors5=(prechoosing==0&&choosing==1)? 12'h0:(color5==3'b000)?12'hf00:(color5==3'b001)?12'h0f0:(color5==3'b010)?12'h00f:(color5==3'b011)?12'hfff:(color5==3'b100)?12'hf90:(color5==3'b101)?12'hff0:colors5;
                                nextcolors6=(prechoosing==0&&choosing==1)? 12'h0:(color6==3'b000)?12'hf00:(color6==3'b001)?12'h0f0:(color6==3'b010)?12'h00f:(color6==3'b011)?12'hfff:(color6==3'b100)?12'hf90:(color6==3'b101)?12'hff0:colors6;
                                nextcolors7=(prechoosing==0&&choosing==1)? 12'h0:(color7==3'b000)?12'hf00:(color7==3'b001)?12'h0f0:(color7==3'b010)?12'h00f:(color7==3'b011)?12'hfff:(color7==3'b100)?12'hf90:(color7==3'b101)?12'hff0:colors7;
                                nextcolors8=(prechoosing==0&&choosing==1)? 12'h0:(color8==3'b000)?12'hf00:(color8==3'b001)?12'h0f0:(color8==3'b010)?12'h00f:(color8==3'b011)?12'hfff:(color8==3'b100)?12'hf90:(color8==3'b101)?12'hff0:colors8;
                                nextcolors9=(prechoosing==0&&choosing==1)? 12'h0:(color9==3'b000)?12'hf00:(color9==3'b001)?12'h0f0:(color9==3'b010)?12'h00f:(color9==3'b011)?12'hfff:(color9==3'b100)?12'hf90:(color9==3'b101)?12'hff0:colors9;
                                nextcolors10=(prechoosing==0&&choosing==1)? 12'h0:(color10==3'b000)?12'hf00:(color10==3'b001)?12'h0f0:(color10==3'b010)?12'h00f:(color10==3'b011)?12'hfff:(color10==3'b100)?12'hf90:(color10==3'b101)?12'hff0:colors10;
                                nextcolors11=(prechoosing==0&&choosing==1)? 12'h0:(color11==3'b000)?12'hf00:(color11==3'b001)?12'h0f0:(color11==3'b010)?12'h00f:(color11==3'b011)?12'hfff:(color11==3'b100)?12'hf90:(color11==3'b101)?12'hff0:colors11;
                                nextcolors12=(prechoosing==0&&choosing==1)? 12'h0:(color12==3'b000)?12'hf00:(color12==3'b001)?12'h0f0:(color12==3'b010)?12'h00f:(color12==3'b011)?12'hfff:(color12==3'b100)?12'hf90:(color12==3'b101)?12'hff0:colors12;
                                nextstate=(entercnt==3'b001&&flag==1'b0)?`returnblack:`coloring;
                            end
                        `returnblack:
                             begin
                                nextcolor1=3'b111;
                                nextcolor2=3'b111;
                                nextcolor3=3'b111;
                                nextcolor4=3'b111;
                                nextcolor5=3'b111;
                                nextcolor6=3'b111;
                                nextcolor7=3'b111;
                                nextcolor8=3'b111;
                                nextcolor9=3'b111;
                                nextcolor10=3'b111;
                                nextcolor11=3'b111;
                                nextcolor12=3'b111;
                                nextcolors1=0;
                                nextcolors2=0;
                                nextcolors3=0;
                                nextcolors4=0;
                                nextcolors5=0;
                                nextcolors6=0;
                                nextcolors7=0;
                                nextcolors8=0;
                                nextcolors9=0;
                                nextcolors10=0;
                                nextcolors11=0;
                                nextcolors12=0;
                                nextflag=1'b1;
                               // nextflag2=1'b1;
                                nextstate=`coloring;
                            end
                    endcase
                end    
            else 
                begin
                    nextcolors1=b1;
                    nextcolors2=b2;
                    nextcolors3=b3;
                    nextcolors4=b4;
                    nextcolors5=b5;
                    nextcolors6=b6;
                    nextcolors7=b7;
                    nextcolors8=b8;
                    nextcolors9=b9;
                    nextcolors10=b10;
                    nextcolors11=b11;
                    nextcolors12=b12;
                end
           

        end
       
        assign colorfull=(colors1!=0&&colors2!=0&&colors3!=0&&colors4!=0&&colors5!=0&&colors6!=0&&colors7!=0
                        &&colors8!=0&&colors9!=0&&colors10!=0&&colors11!=0&&colors12!=0)?1'b1:1'b0;
        clk_divider#(13) clk_13(.clk(clk),.clk_div(clk13));
        /*debounce descreen1(.pb_debounced(isenter_de),.pb(isenter),.clk(clk13));
        onepulse onscreen1(.pb_debounced(isenter_de),.clk(clk13),.pb_1pulse(isenter_pul));*/
        always@(*)
            begin
                if(rst)begin nextentercnt=0; cnt2=0;end
                else
                    begin
                        if(isenter && entercnt==3'b000 && colorfull) begin nextentercnt=entercnt+3'b001; end
                        else if(isenter && entercnt==3'b001) begin nextentercnt=entercnt+3'b001; end
                        else if(isenter && entercnt==3'b010 && colorfull) begin nextentercnt=entercnt+3'b001; end
                        else begin nextentercnt=entercnt; end
                    end
                
            end
        always@(posedge clk or posedge rst)
            begin 
                if(rst) begin entercnt<=0; end
                else begin entercnt<=nextentercnt; end
            end
        wire tmpenter;
        wire tmpenter2;
        assign tmpenter=(entercnt==3'b001&&flag==1'b0&&choosing)?1'b1:1'b0;
        assign tmpenter2=(entercnt==3'b010&&choosing)?1'b1:1'b0;
        storecolor str1(.colors1(colors1),.colors2(colors2),.colors3(colors3),.colors4(colors4),.colors5(colors5),
                        .colors6(colors6),.colors7(colors7),.colors8(colors8),.colors9(colors9),.colors10(colors10),.colors11(colors11),.colors12(colors12),

                .f_colors1(f_colors1),.f_colors2(f_colors2),.f_colors3(f_colors3),.f_colors4(f_colors4),.f_colors5(f_colors5),.
                f_colors6(f_colors6),.f_colors7(f_colors7),.f_colors8(f_colors8),.f_colors9(f_colors9),.f_colors10(f_colors10),.f_colors11(f_colors11),.f_colors12(f_colors12),

                .b_colors1(b_colors1),.b_colors2(b_colors2),.b_colors3(b_colors3),.b_colors4(b_colors4),.b_colors5(b_colors5),.b_colors6(b_colors6),
                .b_colors7(b_colors7),.b_colors8(b_colors8),.b_colors9(b_colors9),.b_colors10(b_colors10),.b_colors11(b_colors11),.b_colors12(b_colors12),
                .isenteronce(tmpenter),.isentertwice(tmpenter2),.rst(rst),.clk(clk));

       always @(*) begin

       if(!valid)
             {vgaRed, vgaGreen, vgaBlue} = 12'h0;
        else if(frame)
        begin
            if(choosing&&entercnt==3'b000) begin {vgaRed, vgaGreen, vgaBlue} = 12'h60c; end
            else if(choosing&&entercnt==3'b001) begin {vgaRed, vgaGreen, vgaBlue} = 12'h0; end
            else if(choosing&&entercnt==3'b010) begin {vgaRed, vgaGreen, vgaBlue} = 12'h60c; end
            else if(choosing&&entercnt==3'b011) begin {vgaRed, vgaGreen, vgaBlue} = 12'h0; end
            else if(!choosing) begin {vgaRed, vgaGreen, vgaBlue} = 12'h0; end
            else begin {vgaRed, vgaGreen, vgaBlue} = 12'h0; end
        end
        else if(block1)begin
            if(choosing&&entercnt==3'b000)begin {vgaRed, vgaGreen, vgaBlue} =colors1; end
            else if(choosing&&entercnt==3'b001) begin {vgaRed, vgaGreen, vgaBlue} = f_colors1; end
            else if(choosing&&entercnt==3'b010) begin {vgaRed, vgaGreen, vgaBlue} = colors1; end
            else if(choosing&&entercnt==3'b011) begin {vgaRed, vgaGreen, vgaBlue} = b_colors1; end
            else if(!choosing) begin {vgaRed, vgaGreen, vgaBlue} = b1; end
            else begin {vgaRed, vgaGreen, vgaBlue} = 12'h0; end
        end
        else if(block2)begin
             if(choosing&&entercnt==3'b000)begin {vgaRed, vgaGreen, vgaBlue} = colors2; end
             else if(choosing&&entercnt==3'b001) begin {vgaRed, vgaGreen, vgaBlue} = f_colors2; end
             else if(choosing&&entercnt==3'b010) begin {vgaRed, vgaGreen, vgaBlue} = colors2; end
             else if(choosing&&entercnt==3'b011) begin {vgaRed, vgaGreen, vgaBlue} = b_colors2; end
             else if(!choosing) begin {vgaRed, vgaGreen, vgaBlue} = b2; end
             else begin {vgaRed, vgaGreen, vgaBlue} = 12'h0; end
        end
        else if(block3)begin
            if(choosing&&entercnt==3'b000)begin {vgaRed, vgaGreen, vgaBlue} = colors3; end
            else if(choosing&&entercnt==3'b001) begin {vgaRed, vgaGreen, vgaBlue} = f_colors3; end
            else if(choosing&&entercnt==3'b010) begin {vgaRed, vgaGreen, vgaBlue} = colors3; end
            else if(choosing&&entercnt==3'b011) begin {vgaRed, vgaGreen, vgaBlue} = b_colors3; end
            else if(!choosing) begin {vgaRed, vgaGreen, vgaBlue} = b3; end
            else begin {vgaRed, vgaGreen, vgaBlue} = 12'h0; end
        end
        else if(block4)begin
            if(choosing&&entercnt==3'b000)begin {vgaRed, vgaGreen, vgaBlue} = colors4; end
            else if(choosing&&entercnt==3'b001) begin {vgaRed, vgaGreen, vgaBlue} = f_colors4; end
            else if(choosing&&entercnt==3'b010) begin {vgaRed, vgaGreen, vgaBlue} = colors4; end
            else if(choosing&&entercnt==3'b011) begin {vgaRed, vgaGreen, vgaBlue} = b_colors4; end
            else if(!choosing) begin {vgaRed, vgaGreen, vgaBlue} = b4; end
            else begin {vgaRed, vgaGreen, vgaBlue} = 12'h0; end
        end
        else if(block5)begin
            if(choosing&&entercnt==3'b000)begin {vgaRed, vgaGreen, vgaBlue} = colors5; end
            else if(choosing&&entercnt==3'b001) begin {vgaRed, vgaGreen, vgaBlue} = f_colors5; end
            else if(choosing&&entercnt==3'b010) begin {vgaRed, vgaGreen, vgaBlue} = colors5; end
            else if(choosing&&entercnt==3'b011) begin {vgaRed, vgaGreen, vgaBlue} = b_colors5; end
            else if(!choosing) begin {vgaRed, vgaGreen, vgaBlue} = b5; end
            else begin {vgaRed, vgaGreen, vgaBlue} = 12'h0; end
        end
        else if(block6)begin
            if(choosing&&entercnt==3'b000)begin {vgaRed, vgaGreen, vgaBlue} = colors6; end
            else if(choosing&&entercnt==3'b001) begin {vgaRed, vgaGreen, vgaBlue} = f_colors6; end
            else if(choosing&&entercnt==3'b010) begin {vgaRed, vgaGreen, vgaBlue} = colors6; end
            else if(choosing&&entercnt==3'b011) begin {vgaRed, vgaGreen, vgaBlue} = b_colors6; end
            else if(!choosing) begin {vgaRed, vgaGreen, vgaBlue} = b6; end
            else begin {vgaRed, vgaGreen, vgaBlue} = 12'h0; end
        end
        else if(block7)begin
            if(choosing&&entercnt==3'b000)begin {vgaRed, vgaGreen, vgaBlue} = colors7; end
            else if(choosing&&entercnt==3'b001) begin {vgaRed, vgaGreen, vgaBlue} = f_colors7; end
            else if(choosing&&entercnt==3'b010) begin {vgaRed, vgaGreen, vgaBlue} = colors7; end
            else if(choosing&&entercnt==3'b011) begin {vgaRed, vgaGreen, vgaBlue} = b_colors7; end
            else if(!choosing) begin {vgaRed, vgaGreen, vgaBlue} = b7; end
            else begin {vgaRed, vgaGreen, vgaBlue} = 12'h0; end
        end
        else if(block8)begin
            if(choosing&&entercnt==3'b000)begin {vgaRed, vgaGreen, vgaBlue} = colors8; end
            else if(choosing&&entercnt==3'b001) begin {vgaRed, vgaGreen, vgaBlue} = f_colors8; end
            else if(choosing&&entercnt==3'b010) begin {vgaRed, vgaGreen, vgaBlue} = colors8; end
            else if(choosing&&entercnt==3'b011) begin {vgaRed, vgaGreen, vgaBlue} = b_colors8; end
            else if(!choosing) begin {vgaRed, vgaGreen, vgaBlue} = b8; end
            else begin {vgaRed, vgaGreen, vgaBlue} = 12'h0; end
        end
        else if(block9)begin
            if(choosing&&entercnt==3'b000)begin {vgaRed, vgaGreen, vgaBlue} = colors9; end
            else if(choosing&&entercnt==3'b001) begin {vgaRed, vgaGreen, vgaBlue} = f_colors9; end
            else if(choosing&&entercnt==3'b010) begin {vgaRed, vgaGreen, vgaBlue} = colors9; end
            else if(choosing&&entercnt==3'b011) begin {vgaRed, vgaGreen, vgaBlue} = b_colors9; end
            else if(!choosing) begin {vgaRed, vgaGreen, vgaBlue} = b9; end
            else begin {vgaRed, vgaGreen, vgaBlue} = 12'h0; end
        end
        else if(block10)begin
            if(choosing&&entercnt==3'b000)begin{vgaRed, vgaGreen, vgaBlue} = colors10; end
            else if(choosing&&entercnt==3'b001) begin {vgaRed, vgaGreen, vgaBlue} = f_colors10; end
            else if(choosing&&entercnt==3'b010) begin {vgaRed, vgaGreen, vgaBlue} = colors10; end
            else if(choosing&&entercnt==3'b011) begin {vgaRed, vgaGreen, vgaBlue} = b_colors10; end
            else if(!choosing) begin {vgaRed, vgaGreen, vgaBlue} = b10; end
            else begin {vgaRed, vgaGreen, vgaBlue} = 12'h0; end
        
        end
        else if(block11)begin
            if(choosing&&entercnt==3'b000)begin {vgaRed, vgaGreen, vgaBlue} = colors11; end
            else if(choosing&&entercnt==3'b001) begin {vgaRed, vgaGreen, vgaBlue} = f_colors11;end
            else if(choosing&&entercnt==3'b010) begin {vgaRed, vgaGreen, vgaBlue} = colors11; end
            else if(choosing&&entercnt==3'b011) begin {vgaRed, vgaGreen, vgaBlue} = b_colors11; end
            else if(!choosing) begin {vgaRed, vgaGreen, vgaBlue} = b11; end
            else begin {vgaRed, vgaGreen, vgaBlue} = 12'h0; end
        end
        else if(block12)begin
            if(choosing&&entercnt==3'b000)begin {vgaRed, vgaGreen, vgaBlue} = colors12; end
            else if(choosing&&entercnt==3'b001) begin {vgaRed, vgaGreen, vgaBlue} = f_colors12; end
            else if(choosing&&entercnt==3'b010) begin {vgaRed, vgaGreen, vgaBlue} = colors12; end
            else if(choosing&&entercnt==3'b011) begin {vgaRed, vgaGreen, vgaBlue} = b_colors12; end
            else if(!choosing) begin {vgaRed, vgaGreen, vgaBlue} = b12; end
            else begin {vgaRed, vgaGreen, vgaBlue} = 12'h0; end
        
        end
        else if(blank)
            {vgaRed, vgaGreen, vgaBlue} = 12'hffc;
        else
             {vgaRed, vgaGreen, vgaBlue} = 12'h0;
   end
endmodule
`timescale 1ns/1ps
/////////////////////////////////////////////////////////////////
// Module Name: vga
/////////////////////////////////////////////////////////////////

module vga_controller (
    input wire pclk, reset,
    output wire hsync, vsync, valid,
    output wire [9:0]h_cnt,
    output wire [9:0]v_cnt
    );

    reg [9:0]pixel_cnt;
    reg [9:0]line_cnt;
    reg hsync_i,vsync_i;

    parameter HD = 640;
    parameter HF = 16;
    parameter HS = 96;
    parameter HB = 48;
    parameter HT = 800; 
    parameter VD = 480;
    parameter VF = 10;
    parameter VS = 2;
    parameter VB = 33;
    parameter VT = 525;
    parameter hsync_default = 1'b1;
    parameter vsync_default = 1'b1;

    always @(posedge pclk)
        if (reset)
            pixel_cnt <= 0;
        else
            if (pixel_cnt < (HT - 1))
                pixel_cnt <= pixel_cnt + 1;
            else
                pixel_cnt <= 0;

    always @(posedge pclk)
        if (reset)
            hsync_i <= hsync_default;
        else
            if ((pixel_cnt >= (HD + HF - 1)) && (pixel_cnt < (HD + HF + HS - 1)))
                hsync_i <= ~hsync_default;
            else
                hsync_i <= hsync_default; 

    always @(posedge pclk)
        if (reset)
            line_cnt <= 0;
        else
            if (pixel_cnt == (HT -1))
                if (line_cnt < (VT - 1))
                    line_cnt <= line_cnt + 1;
                else
                    line_cnt <= 0;

    always @(posedge pclk)
        if (reset)
            vsync_i <= vsync_default; 
        else if ((line_cnt >= (VD + VF - 1)) && (line_cnt < (VD + VF + VS - 1)))
            vsync_i <= ~vsync_default; 
        else
            vsync_i <= vsync_default; 

    assign hsync = hsync_i;
    assign vsync = vsync_i;
    assign valid = ((pixel_cnt < HD) && (line_cnt < VD));

    assign h_cnt = (pixel_cnt < HD) ? pixel_cnt : 10'd0;
    assign v_cnt = (line_cnt < VD) ? line_cnt : 10'd0;

endmodule


`define red 3'b000
`define green 3'b001
`define blue 3'b010
`define white 3'b011
`define orange 3'b100
`define yellow 3'b101
`define black 3'b110
module storecolor(colors1,colors2,colors3,colors4,colors5,colors6,colors7,colors8,colors9,colors10,colors11,colors12,
                f_colors1,f_colors2,f_colors3,f_colors4,f_colors5,f_colors6,f_colors7,f_colors8,f_colors9,f_colors10,f_colors11,f_colors12,
                b_colors1,b_colors2,b_colors3,b_colors4,b_colors5,b_colors6,b_colors7,b_colors8,b_colors9,b_colors10,b_colors11,b_colors12,
                isenteronce,isentertwice,rst,clk);
        input wire [11:0]colors1;
        input wire [11:0]colors2;
        input wire [11:0]colors3;
        input wire [11:0]colors4;
        input wire [11:0]colors5;
        input wire [11:0]colors6;
        input wire [11:0]colors7;
        input wire [11:0]colors8;
        input wire [11:0]colors9;
        input wire [11:0]colors10;
        input wire [11:0]colors11;
        input wire [11:0]colors12;

        input wire isenteronce;
        input wire isentertwice;
        input wire rst;
        input wire clk;

        output reg [11:0]f_colors1;
        output reg [11:0]f_colors2;
        output reg [11:0]f_colors3;
        output reg [11:0]f_colors4;
        output reg [11:0]f_colors5;
        output reg [11:0]f_colors6;
        output reg [11:0]f_colors7;
        output reg [11:0]f_colors8;
        output reg [11:0]f_colors9;
        output reg [11:0]f_colors10;
        output reg [11:0]f_colors11;
        output reg [11:0]f_colors12;

        output reg [11:0]b_colors1;
        output reg [11:0]b_colors2;
        output reg [11:0]b_colors3;
        output reg [11:0]b_colors4;
        output reg [11:0]b_colors5;
        output reg [11:0]b_colors6;
        output reg [11:0]b_colors7;
        output reg [11:0]b_colors8;
        output reg [11:0]b_colors9;
        output reg [11:0]b_colors10;
        output reg [11:0]b_colors11;
        output reg [11:0]b_colors12;


        reg [11:0]nextf_colors1;
        reg [11:0]nextf_colors2;
        reg [11:0]nextf_colors3;
        reg [11:0]nextf_colors4;
        reg [11:0]nextf_colors5;
        reg [11:0]nextf_colors6;
        reg [11:0]nextf_colors7;
        reg [11:0]nextf_colors8;
        reg [11:0]nextf_colors9;
        reg [11:0]nextf_colors10;
        reg [11:0]nextf_colors11;
        reg [11:0]nextf_colors12;

        reg [11:0]nextb_colors1;
        reg [11:0]nextb_colors2;
        reg [11:0]nextb_colors3;
        reg [11:0]nextb_colors4;
        reg [11:0]nextb_colors5;
        reg [11:0]nextb_colors6;
        reg [11:0]nextb_colors7;
        reg [11:0]nextb_colors8;
        reg [11:0]nextb_colors9;
        reg [11:0]nextb_colors10;
        reg [11:0]nextb_colors11;
        reg [11:0]nextb_colors12;

        /*wire [11:0]tmpcolor1,tmpcolor2,tmpcolor3,tmpcolor4,tmpcolor5,tmpcolor6,tmpcolor7,tmpcolor8,tmpcolor9,tmpcolor10,tmpcolor11,tmpcolor12;
        assign tmpcolor1=(color1==3'b000)?12'hf00:(color1==3'b001)?12'h0f0:(color1==3'b010)?12'h00f:(color1==3'b011)?12'hfff:(color1==3'b100)?12'hf90:(color1==3'b101)?12'hff0:0;
        assign tmpcolor2=(color2==3'b000)?12'hf00:(color2==3'b001)?12'h0f0:(color2==3'b010)?12'h00f:(color2==3'b011)?12'hfff:(color2==3'b100)?12'hf90:(color2==3'b101)?12'hff0:0;
        assign tmpcolor3=(color3==3'b000)?12'hf00:(color3==3'b001)?12'h0f0:(color3==3'b010)?12'h00f:(color3==3'b011)?12'hfff:(color3==3'b100)?12'hf90:(color3==3'b101)?12'hff0:0;
        assign tmpcolor4=(color4==3'b000)?12'hf00:(color4==3'b001)?12'h0f0:(color4==3'b010)?12'h00f:(color4==3'b011)?12'hfff:(color4==3'b100)?12'hf90:(color4==3'b101)?12'hff0:0;
        assign tmpcolor5=(color5==3'b000)?12'hf00:(color5==3'b001)?12'h0f0:(color5==3'b010)?12'h00f:(color5==3'b011)?12'hfff:(color5==3'b100)?12'hf90:(color5==3'b101)?12'hff0:0;
        assign tmpcolor6=(color6==3'b000)?12'hf00:(color6==3'b001)?12'h0f0:(color6==3'b010)?12'h00f:(color6==3'b011)?12'hfff:(color6==3'b100)?12'hf90:(color6==3'b101)?12'hff0:0;
        assign tmpcolor7=(color7==3'b000)?12'hf00:(color7==3'b001)?12'h0f0:(color7==3'b010)?12'h00f:(color7==3'b011)?12'hfff:(color7==3'b100)?12'hf90:(color7==3'b101)?12'hff0:0;
        assign tmpcolor8=(color8==3'b000)?12'hf00:(color8==3'b001)?12'h0f0:(color8==3'b010)?12'h00f:(color8==3'b011)?12'hfff:(color8==3'b100)?12'hf90:(color8==3'b101)?12'hff0:0;
        assign tmpcolor9=(color9==3'b000)?12'hf00:(color9==3'b001)?12'h0f0:(color9==3'b010)?12'h00f:(color9==3'b011)?12'hfff:(color9==3'b100)?12'hf90:(color9==3'b101)?12'hff0:0;
        assign tmpcolor10=(color10==3'b000)?12'hf00:(color10==3'b001)?12'h0f0:(color10==3'b010)?12'h00f:(color10==3'b011)?12'hfff:(color10==3'b100)?12'hf90:(color10==3'b101)?12'hff0:0;
        assign tmpcolor11=(color11==3'b000)?12'hf00:(color11==3'b001)?12'h0f0:(color11==3'b010)?12'h00f:(color11==3'b011)?12'hfff:(color11==3'b100)?12'hf90:(color11==3'b101)?12'hff0:0;
        assign tmpcolor12=(color12==3'b000)?12'hf00:(color12==3'b001)?12'h0f0:(color12==3'b010)?12'h00f:(color12==3'b011)?12'hfff:(color12==3'b100)?12'hf90:(color12==3'b101)?12'hff0:0;*/
       always@(posedge clk or posedge rst)begin
                if(rst)begin
                        f_colors1<=0;
                        f_colors2<=0;
                        f_colors3<=0;
                        f_colors4<=0;
                        f_colors5<=0;
                        f_colors6<=0;
                        f_colors7<=0;
                        f_colors8<=0;
                        f_colors9<=0;
                        f_colors10<=0;
                        f_colors11<=0;
                        f_colors12<=0;

                        b_colors1<=0;
                        b_colors2<=0;
                        b_colors3<=0;
                        b_colors4<=0;
                        b_colors5<=0;
                        b_colors6<=0;
                        b_colors7<=0;
                        b_colors8<=0;
                        b_colors9<=0;
                        b_colors10<=0;
                        b_colors11<=0;
                        b_colors12<=0;

                end
                else begin
                        f_colors1<=nextf_colors1;
                        f_colors2<=nextf_colors2;
                        f_colors3<=nextf_colors3;
                        f_colors4<=nextf_colors4;
                        f_colors5<=nextf_colors5;
                        f_colors6<=nextf_colors6;
                        f_colors7<=nextf_colors7;
                        f_colors8<=nextf_colors8;
                        f_colors9<=nextf_colors9;
                        f_colors10<=nextf_colors10;
                        f_colors11<=nextf_colors11;
                        f_colors12<=nextf_colors12;

                        b_colors1<=nextb_colors1;
                        b_colors2<=nextb_colors2;
                        b_colors3<=nextb_colors3;
                        b_colors4<=nextb_colors4;
                        b_colors5<=nextb_colors5;
                        b_colors6<=nextb_colors6;
                        b_colors7<=nextb_colors7;
                        b_colors8<=nextb_colors8;
                        b_colors9<=nextb_colors9;
                        b_colors10<=nextb_colors10;
                        b_colors11<=nextb_colors11;
                        b_colors12<=nextb_colors12;
                end
           
       end
       always@(*)
        begin
                nextf_colors1=(isenteronce)?colors1:f_colors1;
                nextf_colors2=(isenteronce)?colors2:f_colors2;
                nextf_colors3=(isenteronce)?colors3:f_colors3;
                nextf_colors4=(isenteronce)?colors4:f_colors4;
                nextf_colors5=(isenteronce)?colors5:f_colors5;
                nextf_colors6=(isenteronce)?colors6:f_colors6;
                nextf_colors7=(isenteronce)?colors7:f_colors7;
                nextf_colors8=(isenteronce)?colors8:f_colors8;
                nextf_colors9=(isenteronce)?colors9:f_colors9;
                nextf_colors10=(isenteronce)?colors10:f_colors10;
                nextf_colors11=(isenteronce)?colors11:f_colors11;
                nextf_colors12=(isenteronce)?colors12:f_colors12;

                nextb_colors1=(isentertwice)?colors1:b_colors1;
                nextb_colors2=(isentertwice)?colors2:b_colors2;
                nextb_colors3=(isentertwice)?colors3:b_colors3;
                nextb_colors4=(isentertwice)?colors4:b_colors4;
                nextb_colors5=(isentertwice)?colors5:b_colors5;
                nextb_colors6=(isentertwice)?colors6:b_colors6;
                nextb_colors7=(isentertwice)?colors7:b_colors7;
                nextb_colors8=(isentertwice)?colors8:b_colors8;
                nextb_colors9=(isentertwice)?colors9:b_colors9;
                nextb_colors10=(isentertwice)?colors10:b_colors10;
                nextb_colors11=(isentertwice)?colors11:b_colors11;
                nextb_colors12=(isentertwice)?colors12:b_colors12;

        end
        /*assign f_colors1=(isenteronce)?colors1:0;
        assign f_colors2=(isenteronce)?colors2:0;
        assign f_colors3=(isenteronce)?colors3:0;
        assign f_colors4=(isenteronce)?colors4:0;
        assign f_colors5=(isenteronce)?colors5:0;
        assign f_colors6=(isenteronce)?colors6:0;
        assign f_colors7=(isenteronce)?colors7:0;
        assign f_colors8=(isenteronce)?colors8:0;
        assign f_colors9=(isenteronce)?colors9:0;
        assign f_colors10=(isenteronce)?colors10:0;
        assign f_colors11=(isenteronce)?colors11:0;
        assign f_colors12=(isenteronce)?colors12:0;

        assign b_colors1=(isentertwice)?colors1:0;
        assign b_colors2=(isentertwice)?colors2:0;
        assign b_colors3=(isentertwice)?colors3:0;
        assign b_colors4=(isentertwice)?colors4:0;
        assign b_colors5=(isentertwice)?colors5:0;
        assign b_colors6=(isentertwice)?colors6:0;
        assign b_colors7=(isentertwice)?colors7:0;
        assign b_colors8=(isentertwice)?colors8:0;
        assign b_colors9=(isentertwice)?colors9:0;
        assign b_colors10=(isentertwice)?colors10:0;
        assign b_colors11=(isentertwice)?colors11:0;
        assign b_colors12=(isentertwice)?colors12:0;*/
endmodule
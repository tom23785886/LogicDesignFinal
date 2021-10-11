module final_project(clk,rst,play,DIGIT,DISPLAY,vgaRed,vgaGreen,vgaBlue, hsync,vsync,PS2_CLK,PS2_DATA,choosing,auto,led,ismotor,pwm1,pwm2,sw_0,sw_180,sw_push,sw_pinch);
    input clk;
    input rst;
    input play;
    inout wire PS2_DATA;
    inout wire PS2_CLK;
   // input wire isenter;
    input wire auto;
    input wire choosing;
    input wire ismotor;
    output wire [15:0]led;
    output [3:0]DIGIT;
    output [6:0]DISPLAY;
    output [3:0]vgaRed;
    output [3:0]vgaGreen;
    output [3:0]vgaBlue;
    output hsync;
    output vsync;

    output wire pwm1;
    output wire pwm2;
    input wire sw_0;
    input wire sw_180;
    input wire sw_push;
    input wire sw_pinch;


    wire [4:0]keyboardcommand;
    
    wire [2:0]color;
    wire [3:0]blockcommand;
    wire ischanged;
    wire isdone;
    counter cnt1(.clk(clk),.rst(rst),.digit(DIGIT),.display(DISPLAY),.play(play),.choosing(choosing),.isdone(isdone));
    screen scr1(.clk(clk),.rst(rst),.vgaRed(vgaRed),.vgaGreen(vgaGreen),.vgaBlue(vgaBlue),.hsync(hsync),.vsync(vsync),
                .color(color),.blockcommand(blockcommand),.isenter(enter),.choosing(choosing),.keyboardcommand(keyboardcommand),
                .ischanged(ischanged),.auto(auto),.led(led),.isdone(isdone),.ismotor(ismotor));

    keyboard keyboard0(
        .PS2_CLK(PS2_CLK),
        .PS2_DATA(PS2_DATA),
        .rst(rst),  
        .clk(clk),
        .command(keyboardcommand),
        .blockcommand(blockcommand),
        .color(color),
        .enter(enter),
        .ischanged(ischanged)
    );
    
    servo servos(
        .clk(clk),
        .rst(rst),
        .pwm1(pwm1),
        .pwm2(pwm2),
        .sw_0(sw_0),
        .sw_180(sw_180),
        .sw_push(sw_push),
        .sw_pinch(sw_pinch)
    );
    


endmodule
module counter(clk,rst,digit,display,play,choosing,isdone);
    input clk;
    input rst;
    input play;
    output [3:0]digit;
    output [6:0]display;
    input isdone;
    wire clk_sec;
    wire clk13;
    wire play_de;
    wire play_pul;
    input choosing;
    clktosec clktosec1(.clk(clk),.clk_sec(clk_sec));
    reg [10:0]cnt;
    reg [10:0]nextcnt;
    wire [3:0]BCD0;
    wire [3:0]BCD1;
    wire [3:0]BCD2;
    wire [3:0]BCD3;
    reg [3:0]nextBCD0;
    reg [3:0]nextBCD1;
    reg [3:0]nextBCD2;
    reg [3:0]nextBCD3;
    reg [3:0]val;
    reg [3:0]digit;
    reg [6:0]display;
    reg playing;
    reg nextplaying;

    

    clk_divider #(13) clk1(.clk(clk),.clk_div(clk13));
    debounce de1(.pb_debounced(play_de),.pb(play),.clk(clk13));
    onepulse on1(.pb_debounced(play_de),.pb_1pulse(play_pul),.clk(clk13));
    always@(*)
        begin
            nextcnt=cnt;
            if(rst) 
                begin 
                    nextcnt=0;
                    /*nextBCD0=0;
                    nextBCD1=0;
                    nextBCD2=0;
                    nextBCD3=0; */
                    nextplaying=1;
                    
                end
            else
                begin
                    if(choosing)
                        begin 
                            nextplaying=1;
                            nextcnt=0;
                        end
                    else
                        begin
                            if(isdone)
                                begin
                                    nextplaying=0;
                                end
                            else
                                begin
                                    if(play_pul)begin nextplaying=!playing;end
                                    else begin nextplaying=playing; end
                                    if(playing) begin nextcnt=cnt+1; end
                                    else begin nextcnt=cnt; end
                                end
                             
                        end
                   
                   /* nextBCD0=(cnt%60)%10;
                    nextBCD1=(cnt%60)/10;
                    nextBCD2=(cnt/60)%10;
                    nextBCD3=(cnt/60)/10;*/
                end
            case(val)
                4'b0000:begin display=7'b0000001; end
                4'b0001:begin display=7'b1001111; end
                4'b0010:begin display=7'b0010010; end
                4'b0011:begin display=7'b0000110; end
                4'b0100:begin display=7'b1001100; end
                4'b0101:begin display=7'b0100100; end
                4'b0110:begin display=7'b0100000; end
                4'b0111:begin display=7'b0001111; end
                4'b1000:begin display=7'b0000000; end
                4'b1001:begin display=7'b0000100; end
                default:begin display=7'b1111111; end
            endcase

        end
    always@(posedge clk_sec or posedge rst)
        begin
            if(rst)
                begin
                   /* BCD0<=0;
                    BCD1<=0;
                    BCD2<=0;
                    BCD3<=0;*/
                    cnt<=0;
                   
                end
            else
                begin
                    cnt<=nextcnt;
                    
                    /*BCD0<=nextBCD0;
                    BCD1<=nextBCD1;
                    BCD2<=nextBCD2;
                    BCD3<=nextBCD3;*/
                end
            
        end
    assign BCD0=(cnt%60)%10;
    assign BCD1=(cnt%60)/10;
    assign BCD2=(cnt/60)%10;
    assign BCD3=(cnt/60)/10;
    always@(posedge clk13 or posedge rst)
        begin
            if(rst) begin 
                playing<=1'b1; 
                
            end
            else begin 
                playing<=nextplaying; 
                
            end
        end
    always@(posedge clk13)  
        begin
            case(digit)
                4'b1110:begin val=BCD1; digit=4'b1101; end
                4'b1101:begin val=BCD2; digit=4'b1011; end
                4'b1011:begin val=BCD3; digit=4'b0111; end
                4'b0111:begin val=BCD0; digit=4'b1110; end
                default:begin val=BCD0; digit=4'b1110; end
            endcase
            
        end
endmodule
module clktosec(clk,clk_sec);
    parameter n=30;
    input clk;
    output clk_sec;
    reg clk_sec;
    wire nextclk_sec;
    reg[n-1:0]num1;
    wire[n-1:0]nextnum1;
    always@(posedge clk)
        begin
            num1<=nextnum1;
            clk_sec<=nextclk_sec;
        end
    assign nextclk_sec=(num1==30'd49999999)?~clk_sec:clk_sec;
    assign nextnum1=(num1==30'd49999999)?0:num1+1;
endmodule
module clk_divider(clk,clk_div);
    parameter n=4;
    input clk;
    output clk_div;
    reg [n-1:0]num;
    wire [n-1:0]nextnum;
    always@(posedge clk)
        begin
            num=nextnum;
        end
    assign nextnum=num+1;
    assign clk_div=num[n-1];
endmodule
module debounce(pb_debounced,pb,clk);
    output pb_debounced;
    input pb;
    input clk;
    reg[3:0] shift_reg;
    always@(posedge clk)
        begin
            shift_reg[3:1]<=shift_reg[2:0];
            shift_reg[0]<=pb;
        end
    assign pb_debounced=((shift_reg==4'b1111)?1'b1:1'b0);
endmodule
module onepulse(pb_debounced,clk,pb_1pulse);
    input pb_debounced;
    input clk;
    output pb_1pulse;
    reg pb_1pulse;
    reg pb_debounced_delay;
    always@(posedge clk)
        begin
            if(pb_debounced==1'b1&pb_debounced_delay==1'b0)
                begin
                    pb_1pulse<=1'b1;
                end
            else 
                begin
                    pb_1pulse<=1'b0;
                end
            pb_debounced_delay<=pb_debounced;
        end
endmodule


`define red 3'b000
`define green 3'b001
`define blue 3'b010
`define white 3'b011
`define orange 3'b100
`define yellow 3'b101

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
module keyboard(
inout wire PS2_DATA,
inout wire PS2_CLK,
input wire rst,
input wire clk,
output reg [4:0] command,
output reg [3:0] blockcommand,
output reg [2:0] color,
output wire enter
);
	reg [4:0] nextcommand;
	reg [3:0] nextblockcommand;
    parameter [8:0] ENTER = 9'b0_0101_1010;
    parameter [8:0] RIGHT_ENTER = 9'b1_0101_1010;

    parameter [8:0] R=9'b0_0010_1101; //R 2D
    parameter [8:0] B=9'b0_0011_0010; //B 32
    parameter [8:0] G=9'b0_0011_0100; //G 34
    parameter [8:0] Y=9'b0_0011_0101; //Y 35
    parameter [8:0] O=9'b0_0100_0100; //O 44
    parameter [8:0] W=9'b0_0001_1101; //W 1D
    parameter [8:0] UP=9'b0_0111_0101; // right_8 => 75
    parameter [8:0] DOWN=9'b0_0111_0010; // right_2 => 72
    parameter [8:0] LEFT=9'b0_0110_1011; // right_4 => 6B
    parameter [8:0] RIGHT=9'b0_0111_0100; // right_6 => 74
	
	parameter [8:0] F=9'b0_0010_1011; //F 2B
	parameter [8:0] U=9'b0_0011_1100; //U 3C
	parameter [8:0] L=9'b0_0100_1011; //L 4B
	


	parameter [8:0] LEFT_SHIFT  = 9'b0_0001_0010;
	parameter [8:0] RIGHT_SHIFT = 9'b0_0101_1001; 
	
    
	wire [511:0] key_down;
	wire [8:0] last_change;
	wire been_ready;
    
	wire shiftdown;
	wire direction_press;
	assign direction_press=been_ready && (key_down[UP] | key_down[RIGHT] | key_down[LEFT] | key_down[DOWN]);
    
	assign enter=been_ready & (key_down[ENTER]|key_down[RIGHT_ENTER]);
	assign shiftdown=been_ready & (key_down[LEFT_SHIFT] | key_down[RIGHT_SHIFT]);
	
    KeyboardDecoder key_de (
		.key_down(key_down),
		.last_change(last_change),
		.key_valid(been_ready),
		.PS2_DATA(PS2_DATA),
		.PS2_CLK(PS2_CLK),
		.rst(rst),
		.clk(clk)
	);
    always @ (posedge clk, posedge rst) begin
		if (rst) begin
			blockcommand<=2;
			command<=4'b1111;
		end 
		else begin
			if(been_ready&& direction_press)
				blockcommand<=nextblockcommand;
			command<=nextcommand;
		end
	end
    always @ (*) begin
		
		case (last_change)
			R:begin
				color=`red;
			end
			B:begin
				color=`blue;
			end
			G:begin
				color=`green;
			end
			Y:begin
				color=`yellow;
			end
			O:begin
				color=`orange;
			end
			W:begin
				color=`white;
			end
			default:begin
				color=3'b111;
			end
		endcase
	end    
	always@(*)begin
		nextcommand=command;
		if(key_down[R]&& !shiftdown && been_ready)begin
			nextcommand=`r;
		end
		if(key_down[R] && shiftdown && been_ready)begin
			nextcommand=`r_prime;
		end
		else if(key_down[F] && shiftdown&&been_ready)begin
			nextcommand=`f_prime;
		end
		else if(key_down[F]&& !shiftdown&&been_ready)begin
			nextcommand=`f;
		end
		else if(key_down[U]&& !shiftdown&&been_ready)begin
			nextcommand=`u;
		end
		else if(key_down[U]&& shiftdown&&been_ready)begin
			nextcommand=`u_prime;
		end
		else if(key_down[L]&& !shiftdown&&been_ready)begin
			nextcommand=`l;
		end
		else if(key_down[L]&& shiftdown&&been_ready)begin
			nextcommand=`l_prime;
		end

	end
	always@(*)begin
		nextblockcommand=blockcommand;
		
		if(key_down[UP]==1'b1&&been_ready)begin
		
			case(blockcommand)
				4'd1:begin 
				nextblockcommand=4'd2; 
				end
				4'd2:begin
				nextblockcommand=4'd9;
				end
				4'd3:nextblockcommand=4'd4;
				4'd4:nextblockcommand=4'd10;
				4'd5:nextblockcommand=4'd6;
				4'd6:nextblockcommand=4'd10;
				4'd7:nextblockcommand=4'd8;
				4'd8:nextblockcommand=4'd11;
				4'd9:nextblockcommand=4'd12;
				4'd10:nextblockcommand=4'd11;
				4'd11:nextblockcommand=4'd12;
				default:nextblockcommand=blockcommand;
			endcase
		end
		else if(key_down[LEFT]==1'b1&&been_ready)begin
			case(blockcommand)
				4'd3:nextblockcommand=4'd1;
				4'd4:nextblockcommand=4'd2;
				4'd5:nextblockcommand=4'd3;
				4'd6:nextblockcommand=4'd4;
				4'd7:nextblockcommand=4'd5;
				4'd8:nextblockcommand=4'd6;
				4'd10:nextblockcommand=4'd9;
				4'd11:nextblockcommand=4'd10;
				4'd12:nextblockcommand=4'd9;
				default:nextblockcommand=blockcommand;
			endcase
		end
		else if(key_down[RIGHT]==1'b1&&been_ready)begin
			case(blockcommand)
				4'd1:nextblockcommand=4'd3;
				4'd2:nextblockcommand=4'd4;
				4'd3:nextblockcommand=4'd5;
				4'd4:nextblockcommand=4'd6;
				4'd5:nextblockcommand=4'd7;
				4'd6:nextblockcommand=4'd8;
				4'd9:nextblockcommand=4'd10;
				4'd10:nextblockcommand=4'd6;
				4'd12:nextblockcommand=4'd11;
				default:nextblockcommand=blockcommand;
			endcase
		end
		else if(key_down[DOWN]==1'b1&&been_ready)begin
			case(blockcommand)
				4'd2:nextblockcommand=4'd1;
				4'd4:nextblockcommand=4'd3;
				4'd6:nextblockcommand=4'd5;	
				4'd8:nextblockcommand=4'd7;
				4'd9:nextblockcommand=4'd2;
				4'd10:nextblockcommand=4'd4;
				4'd11:nextblockcommand=4'd8;
				default:nextblockcommand=blockcommand;
			endcase
		end
	end
endmodule


module debounced(pb,pbdebounce,clk);
input clk;
input pb;
output pbdebounce;
reg [3:0] shift_reg;
always@(posedge clk)begin
    shift_reg[3:1]<=shift_reg[2:0];
    shift_reg[0]<=pb;
end
assign pbdebounce=(shift_reg==4'b1111)? 1:0;
endmodule

module clk_divider(clk,clk_div);
input clk;
output clk_div;
parameter n=16;
reg [n-1:0]out;
wire [n-1:0]nextout;
always@(posedge clk)begin
    out<=nextout;
end
assign nextout=out+1'b1;
assign clk_div=out[n-1];
endmodule
module KeyboardDecoder(
	output reg [511:0] key_down,
	output wire [8:0] last_change,
	output reg key_valid,
	inout wire PS2_DATA,
	inout wire PS2_CLK,
	input wire rst,
	input wire clk
    );
    
    parameter [1:0] INIT			= 2'b00;
    parameter [1:0] WAIT_FOR_SIGNAL = 2'b01;
    parameter [1:0] GET_SIGNAL_DOWN = 2'b10;
    parameter [1:0] WAIT_RELEASE    = 2'b11;
    
	parameter [7:0] IS_INIT			= 8'hAA;
    parameter [7:0] IS_EXTEND		= 8'hE0;
    parameter [7:0] IS_BREAK		= 8'hF0;
    
    reg [9:0] key;		// key = {been_extend, been_break, key_in}
    reg [1:0] state;
    reg been_ready, been_extend, been_break;
    
    wire [7:0] key_in;
    wire is_extend;
    wire is_break;
    wire valid;
    wire err;
    
    wire [511:0] key_decode = 1 << last_change;
    assign last_change = {key[9], key[7:0]};
    
    KeyboardCtrl_0 inst (
		.key_in(key_in),
		.is_extend(is_extend),
		.is_break(is_break),
		.valid(valid),
		.err(err),
		.PS2_DATA(PS2_DATA),
		.PS2_CLK(PS2_CLK),
		.rst(rst),
		.clk(clk)
	);
	
	OnePulse op (
		.signal_single_pulse(pulse_been_ready),
		.signal(been_ready),
		.clock(clk)
	);
    
    always @ (posedge clk, posedge rst) begin
    	if (rst) begin
    		state <= INIT;
    		been_ready  <= 1'b0;
    		been_extend <= 1'b0;
    		been_break  <= 1'b0;
    		key <= 10'b0_0_0000_0000;
    	end else begin
    		state <= state;
			been_ready  <= been_ready;
			been_extend <= (is_extend) ? 1'b1 : been_extend;
			been_break  <= (is_break ) ? 1'b1 : been_break;
			key <= key;
    		case (state)
    			INIT : begin
    					if (key_in == IS_INIT) begin
    						state <= WAIT_FOR_SIGNAL;
    						been_ready  <= 1'b0;
							been_extend <= 1'b0;
							been_break  <= 1'b0;
							key <= 10'b0_0_0000_0000;
    					end else begin
    						state <= INIT;
    					end
    				end
    			WAIT_FOR_SIGNAL : begin
    					if (valid == 0) begin
    						state <= WAIT_FOR_SIGNAL;
    						been_ready <= 1'b0;
    					end else begin
    						state <= GET_SIGNAL_DOWN;
    					end
    				end
    			GET_SIGNAL_DOWN : begin
						state <= WAIT_RELEASE;
						key <= {been_extend, been_break, key_in};
						been_ready  <= 1'b1;
    				end
    			WAIT_RELEASE : begin
    					if (valid == 1) begin
    						state <= WAIT_RELEASE;
    					end else begin
    						state <= WAIT_FOR_SIGNAL;
    						been_extend <= 1'b0;
    						been_break  <= 1'b0;
    					end
    				end
    			default : begin
    					state <= INIT;
						been_ready  <= 1'b0;
						been_extend <= 1'b0;
						been_break  <= 1'b0;
						key <= 10'b0_0_0000_0000;
    				end
    		endcase
    	end
    end
    
    always @ (posedge clk, posedge rst) begin
    	if (rst) begin
    		key_valid <= 1'b0;
    		key_down <= 511'b0;
    	end else if (key_decode[last_change] && pulse_been_ready) begin
    		key_valid <= 1'b1;
    		if (key[8] == 0) begin
    			key_down <= key_down | key_decode;
    		end else begin
    			key_down <= key_down & (~key_decode);
    		end
    	end else begin
    		key_valid <= 1'b0;
			key_down <= key_down;
    	end
    end

endmodule
module OnePulse (
	output reg signal_single_pulse,
	input wire signal,
	input wire clock
	);
	reg signal_delay;
	always @(posedge clock) begin
		if (signal == 1'b1 & signal_delay == 1'b0)
		  signal_single_pulse <= 1'b1;
		else
		  signal_single_pulse <= 1'b0;
		signal_delay <= signal;
	end
endmodule

module onepulse(onepulse,pbdebounce,rst,clk);
input pbdebounce;
input rst;
input clk;
output reg onepulse;
reg pbdebounce_delay;
reg nextpb_onepulse;
always@(*)begin
    nextpb_onepulse=pbdebounce& ~pbdebounce_delay;
end
always@(posedge clk or posedge rst)begin
    if(rst)begin
        pbdebounce_delay<=0;
        onepulse<=0;    
    end
    else begin
        pbdebounce_delay<=pbdebounce;
        onepulse<=nextpb_onepulse; 
    end
end
endmodule
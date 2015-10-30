`timescale 1 ns / 1 ps

module liangzhu_player (
	clk,
	i_button_n,
	o_audio
);

input clk;
input i_button_n;
output o_audio;

reg [23:0] counter_4Hz;
reg [23:0] counter_6MHz;
reg [13:0] count;
reg [13:0] origin;
reg audio_reg;
reg clk_6MHz;
reg clk_4Hz;
reg [4:0] note;
reg [7:0] len;

assign o_audio = i_button_n ?  1'b1 : audio_reg;

always @ (posedge clk) begin
	counter_6MHz <= counter_6MHz + 1'b1;
	if (counter_6MHz == 1) begin
		clk_6MHz = ~clk_6MHz;
		counter_6MHz <= 24'b0;
	end
end

always @ (posedge clk) begin
	counter_4Hz <= counter_4Hz + 1'b1;
	if (counter_4Hz == 2999999) begin	
		clk_4Hz = ~clk_4Hz;
		counter_4Hz <= 24'b0;
	end
end

always @ (posedge clk_6MHz) begin
    if(count == 16383) begin
        count = origin;
        audio_reg = ~audio_reg;
    end else
		count = count + 1;
end


always @ (posedge clk_4Hz) begin
	case (note)
		'd1: origin <= 'd4916;
		'd2: origin <= 'd6168;
		'd3: origin <= 'd7281;
		'd4: origin <= 'd7791;
		'd5: origin <= 'd8730;
		'd6: origin <= 'd9565;
		'd7: origin <= 'd10310;
		'd8: origin <= 'd010647;
		'd9: origin <= 'd011272;
		'd10: origin <= 'd011831;
		'd11: origin <= 'd012087;
		'd12: origin <= 'd012556;
		'd13: origin <= 'd012974;
		'd14: origin <= 'd013346;
		'd15: origin <= 'd13516;
		'd16: origin <= 'd13829;
		'd17: origin <= 'd14108;
		'd18: origin <= 'd11535;
		'd19: origin <= 'd14470;
		'd20: origin <= 'd14678;
		'd21: origin <= 'd14864;
		default: origin <= 'd011111;
    endcase             
end

always @ (posedge clk_4Hz) begin
	if (len == 63)
		len <= 0;
    else
		len <= len + 1;
	case (len)
		0: note <= 3;
		1: note <= 3;
		2: note <= 3;
		3: note <= 3;
		4: note <= 5;
		5: note <= 5;
		6: note <= 5;
		7: note <= 6;
		8: note <= 8;
		9: note <= 8;
		10: note <= 8;
		11: note <= 6;
		12: note <= 6;
		13: note <= 6;
		14: note <= 6;
		15: note <= 12;
		16: note <= 12;
		17: note <= 12;
		18: note <= 15;
		19: note <= 15;
		20: note <= 15;
		21: note <= 15;
		22: note <= 15;
		23: note <= 9;
		24: note <= 9;
		25: note <= 9;
		26: note <= 9;
		27: note <= 9;
		28: note <= 9;
		29: note <= 9;
		30: note <= 9;
		31: note <= 9;
		32: note <= 9;
		33: note <= 9;
		34: note <= 10;
		35: note <= 7;
		36: note <= 7;
		37: note <= 6;
		38: note <= 6;
		39: note <= 5;
		40: note <= 5;
		41: note <= 5;
		42: note <= 6;
		43: note <= 8;
		44: note <= 8;
		45: note <= 9;
		46: note <= 9;
		47: note <= 3;
		48: note <= 3;
		49: note <= 8;
		50: note <= 8;
		51: note <= 8;
		52: note <= 5;
		53: note <= 5;
		54: note <= 8;
		55: note <= 5;
		56: note <= 5;
		57: note <= 5;
		58: note <= 5;
		59: note <= 5;
		60: note <= 5;
		61: note <= 5;
		62: note <= 5;
		63: note <= 5;
	endcase            
end
endmodule
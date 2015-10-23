module beep_music_top (
	clk,
	i_start_n,
	o_buzzer,
);

input clk;
input i_start_n;
output o_buzzer;

parameter DO	= 16'd45801;
parameter RE	= 16'd40816;
parameter MI	= 16'd36363;
parameter FA	= 16'd34383;
parameter SO	= 16'd30612;
parameter LA	= 16'd27272;
parameter SI	= 16'd24291;
parameter DO_	= 16'd22944;
parameter TIME	= 32'd12000000;
//python -c "print '\n'.join([str(2**16-10**6/i) for i in [262,294,330,349,392,440,494,523]])"

reg [15:0] counter;
reg [15:0] counter_end;
reg [31:0] counter_beat;
reg [7:0] state;
reg beep_reg;

assign o_buzzer = beep_reg;

always @ (posedge clk) begin
	if (!i_start_n) begin
		counter <= counter + 1'b1;
		if (counter == counter_end) begin
			counter <= 16'b0;
			beep_reg <= ~beep_reg;
		end
		if (counter_beat < TIME) begin
			counter_beat <= counter_beat + 1'b1;
		end else begin
			counter_beat <= 32'b0;
			if (state == 8'd28) begin
				state <= 8'd0;
			end else begin
				state <= state + 1'b1;
				case (state) 
					8'd0, 8'd1:		counter_end = DO;
					8'd2, 8'd3:		counter_end = SO;
					8'd4, 8'd5:		counter_end = LA;
					8'd6:			counter_end = SO;
					8'd7, 8'd8:		counter_end = FA;
					8'd9, 8'd10:	counter_end = MI;
					8'd11, 8'd12:	counter_end = RE;
					8'd13:			counter_end = DO;
					8'd14, 8'd15:	counter_end = SO;
					8'd16, 8'd17:	counter_end = FA;
					8'd18, 8'd19:	counter_end = MI;
					8'd20:			counter_end = RE;
					8'd21, 8'd22:	counter_end = SO;
					8'd23, 8'd24:	counter_end = FA;
					8'd25, 8'd26:	counter_end = MI;
					8'd27:			counter_end = RE;
				endcase
			end
		end
		
	end
end 
endmodule 
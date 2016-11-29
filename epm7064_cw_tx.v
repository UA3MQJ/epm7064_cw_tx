module epm7064_test(clk, out_clk, out_lf, out_rf);
input wire clk;
output wire [4:0] out_clk;
output wire out_lf;
output wire out_rf;

reg [28:0] cnt; initial cnt <= 24'd0;

always @(posedge clk) cnt <= cnt + 1'b1;

assign out_clk = cnt[23:19];

wire [4:0] hi_bits = cnt[26:26-4];

wire cw = (hi_bits == 5'd0) ||
		    (hi_bits == 5'd2) ||
		    (hi_bits == 5'd4) ||
		    (hi_bits == 5'd8) ||
		    (hi_bits == 5'd9) ||
		    (hi_bits == 5'd10) ||
		    (hi_bits == 5'd12) ||
		    (hi_bits == 5'd13) ||
		    (hi_bits == 5'd14) ||
		    (hi_bits == 5'd16) ||
		    (hi_bits == 5'd17) ||
		    (hi_bits == 5'd18) ||
		    (hi_bits == 5'd22) ||
		    (hi_bits == 5'd24) ||
		    (hi_bits == 5'd26);
			 
assign out_lf = cw;

wire audio = cnt[13]; // 14й бит - 1536 Гц - тон звуковой частоты
wire rf    = cnt[ 4]; //  5й бит - ~786 RГц - радиочастота

assign out_rf = cw & rf & audio;

endmodule

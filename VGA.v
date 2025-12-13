module VGA(input clk, input [9:0] x, input [9:0] y, input [9:0] py, output reg hsync, output reg vsync, output reg [2:0] RGB, output reg vga_clk);

reg [10:0] hpos = 0;
reg [9:0] vpos = 0;

always @(posedge clk) begin
	if (hpos == 1055) begin
		hpos <= 0;
		if (vpos == 627) begin
			vpos <= 0;
		end else begin
			vpos <= vpos + 1;
		end
	end else begin
		hpos <= hpos + 1;
	end
	
	
	hsync <= 1;
	vsync <= 1;
	vga_clk <= 0;
	
	if (vpos >= 600 && vpos < 604) begin
		vsync <= 0;
		vga_clk <= 1;
	end
	if (hpos >= 839 && hpos < 967) begin
		hsync <= 0;
	end
end


always @(posedge clk) begin
	if (hpos > 799 || vpos > 599) begin
		RGB <= 3'b000;
	end else if (hpos > x - 6 && hpos < x + 6 && vpos > y - 6 && vpos < y + 6) begin
		RGB <= 3'b011;
	end else if (hpos >= 774 && hpos <= 784 && vpos >= py - 30 && vpos <= py + 30) begin
		RGB <= 3'b110;
	end else begin
		RGB <= 3'b000;
	end
end

endmodule
	
	
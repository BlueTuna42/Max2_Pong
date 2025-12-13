module pong(input vga_clk, input [1:0] key, output reg [9:0] x, output reg [9:0] y, output reg [9:0] py, output reg [7:0] led);

reg signed [3:0] vx = 1;
reg signed [3:0] vy = 1;

reg signed [7:0] sx = 50;
reg signed [7:0] sy = 37;
reg [6:0] spy = 37;

reg en = 1;

initial begin
	led = 0;
	sx = 50;
	sy = 37;
end

always @(posedge vga_clk) begin

	if (~key[1]) begin
		if (spy <= 71) begin
			spy = spy + 2;
		end
	end else if (~key[0]) begin
		if (spy > 5) begin
			spy = spy - 2;
		end
	end
	py = spy << 3;
	
	
	if (x <= 16) begin
		vx = 1;
		en = 1;
	end
	if (y <= 16) begin
		vy = 1;
		en = 1;
	end
	if (y >= 584) begin
		vy = -1;
		en = 1;
	end else if (x >= 792) begin
		led = 0;
		en = 1;
	end
	
	if (x >= 760 && x <= 768 && y < py + 40 && y > py - 40) begin
		vx = -1;
	if (led != 8'b11111111 && en == 1) begin
			led = led << 1;
			led = led | 8'b00000001;
			en = 0;
		end
	end
	
	sx = sx + vx;
	sy = sy + vy;
	
	x = sx << 3;
	y = sy << 3;
end

endmodule
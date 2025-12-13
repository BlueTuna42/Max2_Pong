module connections(input clk, output [2:0] RGB, output hsync, output vsync, input [1:0] key, output [7:0] led);

wire [10:0] x;
wire [10:0] y;
wire [10:0] py;
wire vga_clk;

VGA VGA (.clk(clk), .x(x), .y(y), .RGB(RGB), .hsync(hsync), .vsync(vsync), .vga_clk(vga_clk), .py(py));
pong pong (.x(x), .y(y), .vga_clk(vga_clk), .py(py), .key(key), .led(led));

endmodule
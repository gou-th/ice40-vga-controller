`timescale 1ns / 1ps

module vga_timing_tb;
    
    logic clk_tb;
    logic rst_tb;
    logic hsync_out,vsync_out,vga_active_out;
    logic [9:0] hcount_out,vcount_out;
    logic [3:0] r_out,g_out,b_out;
    
    vga_timing DUT (.clk(clk_tb),.rst(rst_tb),.hsync(hsync_out),.vsync(vsync_out),.hcount(hcount_out),.vcount(vcount_out),.vga_active(vga_active_out));
    vga_pixel_gen PIXEL_DUT(.clk(clk_tb),.rst(rst_tb),.hcount_in(hcount_out),.vcount_in(vcount_out),.vga_active_in(vga_active_out),.vga_r_out(r_out),.vga_g_out(g_out),.vga_b_out(b_out));
    initial begin 
        clk_tb = 1'b0;
        forever #19.895 clk_tb = ~clk_tb;
    end
    initial begin 
        rst_tb = 1'b1;
        #100;
        rst_tb = 1'b0;        
        #200_00_000;
        $finish;
    end
    
endmodule

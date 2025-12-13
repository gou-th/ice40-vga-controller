`timescale 1ns / 1ps


module vga_pixel_gen(
    input clk,
    input rst,
    input [9:0] hcount_in,
    input [9:0] vcount_in,
    input vga_active_in,
    output logic [3:0] vga_r_out,
    output logic [3:0] vga_g_out,
    output logic [3:0] vga_b_out
    );
    
    logic [9:0] scroll_offset;
    logic [5:0] frame_timer;
    always_ff @(posedge clk) begin
        if (rst) begin
            scroll_offset <= 0;
            frame_timer <= 0;
        end else if (hcount_in==0&&vcount_in==0) begin
            frame_timer <= frame_timer + 1;    
            if (frame_timer == 0) begin
                scroll_offset <= scroll_offset+10;
            end
        end
    end
    logic [9:0] current_x;
    assign current_x = hcount_in + scroll_offset;
    always_comb begin
        vga_r_out = 4'h0;
        vga_g_out = 4'h0;
        vga_b_out = 4'h0;       
        if (vga_active_in) begin
            case (current_x[9:8])
                2'b00: begin 
                    vga_r_out = 4'hF; 
                end 2'b01: begin
                    vga_g_out = 4'hF; 
                end 2'b10: begin
                    vga_b_out = 4'hF; 
                end 2'b11: begin
                    vga_r_out = 4'hF; vga_g_out = 4'hF; vga_b_out = 4'hF;
                end
            endcase
        end
    end
endmodule

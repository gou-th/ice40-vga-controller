`timescale 1ns / 1ps

module vga_timing(
    input logic clk,
    input logic rst,
    output logic hsync,
    output logic vsync,
    output logic [9:0] hcount,
    output logic [9:0] vcount,
    output logic vga_active
    );
    logic [9:0] h_count_reg;
    logic [9:0] v_count_reg;
    logic [9:0] h_next;
    logic [9:0] v_next;    
    logic h_tc_signal;
    logic h_active_sig;
    logic v_active_sig;
    always_ff @(posedge clk) begin 
        if (rst) begin 
            h_count_reg<='0;
        end else if (h_count_reg==799) begin 
            h_count_reg<='0;
        end else begin 
            h_count_reg<=h_count_reg+1;
        end
    end
    assign h_tc_signal=(h_count_reg==799);
    assign hcount=h_count_reg;
    
    always_ff @(posedge clk) begin 
        if (rst) begin 
            v_count_reg<=0;
         end else if (h_tc_signal) begin 
         if (v_count_reg==524) begin 
            v_count_reg<=0;
        end else begin 
            v_count_reg<=v_count_reg+1;
        end
     end
     end
     assign vcount=v_count_reg;
     
     assign hsync=(h_count_reg<96) ? 1'b0:1'b1;
     assign vsync=(v_count_reg<2) ? 1'b0:1'b1;
     
     assign h_active_sig=(h_count_reg>=144) && (h_count_reg<784);
     assign v_active_sig=(v_count_reg>=35) && (v_count_reg<515);
     assign vga_active=h_active_sig && v_active_sig;
endmodule

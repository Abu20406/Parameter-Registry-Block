`timescale 1ns / 1ps

module parameter_registry_block_tb;

    reg clk_test, reset_test, param_ld_test;
    reg [7:0] data_in_test;
    wire [10:0] mask_param_test, code_param_test;
    wire [2:0] sjw_test;
   
    parameter_registry_block uut (.clk(clk_test), .reset(reset_test), .param_ld(param_ld_test),
                                    .data_in(data_in_test), .mask_param(mask_param_test), .code_param(code_param_test),
                                        .sjw(sjw_test));
   
   
   localparam T = 20;
   
   always
    begin
        clk_test = 1'b1;
        #(T/2);
        clk_test = 1'b0;
        #(T/2);
        end
   
    initial
        begin
            reset_test = 1'b1;
	    #T;
	    reset_test = 1'b0;
	    #T;
	    data_in_test = 8'b11001100;
	    param_ld_test = 1'b1;
	    #80;
	    param_ld_test = 1'b0;
	    #20;
	    param_ld_test = 1'b1;
	    #80;
	    param_ld_test = 1'b0;
	    #40;
	    param_ld_test = 1'b1;
	    #50;
	    param_ld_test = 1'b0;
	    #35;
	    param_ld_test = 1'b1;
	    #80;
	    data_in_test = 8'b11110000;

	    param_ld_test = 1'b0;
	    #25;
	    param_ld_test = 1'b1;
	    #75;
	    param_ld_test = 1'b0;
	    #5;
	    data_in_test = 8'b10101010;

	    param_ld_test = 1'b1;
	    #40;
	    param_ld_test = 1'b0;
	    #20;
	    param_ld_test = 1'b1;
	    #55;
	    param_ld_test = 1'b0;
	    #20;
	    data_in_test = 8'b11001100;

	    param_ld_test = 1'b1;
	    #80;
	    param_ld_test = 1'b0;
	    #20;
	    param_ld_test = 1'b1;
	    #20;
	    reset_test = 1'b1;
	    #T;
	    reset_test = 1'b0;
	    #T;
	    reset_test = 1'b1;
	    #T;
	    reset_test = 1'b0;
	    #T;
	    reset_test = 1'b0;
	    #T;
	    
	    $finish;
      end   
endmodule

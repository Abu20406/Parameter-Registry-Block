`timescale 1ns / 1ps

module parameter_registry_block(
    input wire clk, reset, param_ld,
    input wire [7:0] data_in,
    output reg [10:0] mask_param, code_param,
    output reg [2:0] sjw
    );
   
    localparam [2:0] idle = 3'b000,
                     prmtr_0 = 3'b001,
                     prmtr_1 = 3'b010,
                     prmtr_2 = 3'b011,
                     prmtr_ld_cmp = 3'b100;
                     
    localparam N = 3;
    reg [N-1:0] r_reg; //output register
    reg [N-1:0] r_next; //next state register
   
    //state register
    always@(posedge clk, posedge reset)
        if(reset)
            r_reg <= idle;
        else
            r_reg <= r_next;
    //next state logic        
    always@*
        begin
            case(r_reg)
                idle:
                    begin
                    mask_param = 11'b0;
                    code_param = 11'b0;
                    sjw = 3'b0;
                   
                    if(param_ld)
                        r_next = prmtr_0;
                        end
                       
                prmtr_0:
                    begin
                        mask_param = {3'b0,data_in[7:0]};
                        code_param = 11'b0;
                        sjw = 3'b0;
                       //if (param_ld == 1)
                        r_next = prmtr_1;
                        end
               
                prmtr_1:
                    begin
                        mask_param = {data_in[2:0], mask_param[7:0]};
                        code_param = {6'b0,data_in[7:3]};
                        sjw = 3'b0;
                       //if (param_ld == 1)
                        r_next = prmtr_2;
                        end
                prmtr_2:
                    begin
			mask_param = {data_in[2:0], mask_param[7:0]};
                        code_param = {data_in[6:0], data_in[7:3]};
                        sjw = data_in[7:6];
                       //if (param_ld == 1)
                        r_next = prmtr_ld_cmp;
                        end
               prmtr_ld_cmp:
                    if(param_ld)
                        r_next = prmtr_0;
                    else
                        r_next = prmtr_ld_cmp;
               default: r_next = idle;
           endcase
          end
                       
endmodule

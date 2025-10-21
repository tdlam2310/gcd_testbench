interface gcd_if(input logic clk_i, input logic rst_i);
timeunit 1ns;
timeprecision 100ps;

    localparam TB_WIDTH = 8;

    // Define actual DUT signals here
    logic valid_i;
    logic [TB_WIDTH-1:0] a_i;
    logic [TB_WIDTH-1:0] b_i;
    logic [TB_WIDTH-1:0] gcd_o;
    logic valid_o;

endinterface : gcd_if

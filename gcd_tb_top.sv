module gcd_tb_top;

    timeunit 1ns;
    timeprecision 100ps;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import gcd_test_pkg::*;
    import gcd_seq_pkg::*;
    import gcd_agent_pkg::*;
    import gcd_env_pkg::*;

    logic clk = 0;
    logic rst = 0;

    always #10ns clk = ~clk;

    initial begin
        rst = 1;
        #10ns rst = 0;
       // #1000ns $finish;
    end

    // Interface instantiation
    gcd_if vif(clk, rst);

    // DUT instantiation
    gcd dut(
        .clk_i(clk),
        .rst_i(rst),
        .valid_i(vif.valid_i),
        .a_i(vif.a_i),
        .b_i(vif.b_i),
        .gcd_o(vif.gcd_o),
        .valid_o(vif.valid_o));

    initial begin
        // Initialize waveform dumping
        $shm_open("waves.shm");
        $shm_probe("AS");
        // Store the virtual interface handle 'if0' in the UVM configuration database
        // under the field name "vif" so all components under uvm_root can access it.
        //uvm_config_db #(virtual gcd_if)::set(uvm_root::get(), "*", "vif", vif);
        uvm_config_db #(virtual gcd_if)::set(null, "uvm_test_top", "gcd_if", vif);
        
        run_test();
    end

endmodule : gcd_tb_top

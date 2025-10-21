class gcd_sb extends uvm_scoreboard;
    `uvm_component_utils(gcd_sb)
    //import gcd_seq_pkg::*;
    uvm_analysis_imp #(gcd_seq_item, gcd_sb) item_analysis_export;
    //gcd_seq_item item_q[$];
    // Scoreboard statistics. You can optionally add more if you want
    int num_in, num_correct, num_incorrect;
    gcd_seq_item tr;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        //item_analysis_export = new("item_analysis_export", this);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        $display("[%0t] [SCOREBOARD Build phase scoreboard 2", $time);
        item_analysis_export = new("item_analysis_export", this);
    endfunction : build_phase
    
    //================VERSION 1==============================(if this is used, uncomment fifo)
    // function void write(gcd_seq_item req);
    // `uvm_info("SB", $sformatf("SB got item A=%0d B=%0d GCD=%0d",
    //         req.data_a, req.data_b, req.result_gcd), UVM_LOW)
	// 	item_q.push_back(req);
	// endfunction
    //============================================================
    
     //================VERSION 2==============================
    function void write(gcd_seq_item tr);
        $display("SB got item A=%0d B=%0d GCD=%0d", tr.data_a, tr.data_b, tr.result_gcd);
        num_in++;
        if (tr.result_gcd == compute_gcd(tr.data_a, tr.data_b)) begin
            num_correct++;
        end else begin
            num_incorrect++;
            $error("Mismatch: Received GCD=%0d, Expected GCD=%0d for inputs A=%0d, B=%0d", tr.result_gcd, compute_gcd(tr.data_a, tr.data_b), tr.data_a, tr.data_b);
        end
	endfunction
    //============================================================
    // Golden function to compute GCD
    function automatic bit [7:0] compute_gcd(bit [7:0] a, bit [7:0] b);
        bit [7:0] x = a;
        bit [7:0] y = b;
        while (y != 0) begin
            bit [7:0] temp = y;
            y = x % y;
            x = temp;
        end
        return x;
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        // $display("[%0t] [SCOREBOARD] RUN phase scoreboard", $time);
        // //gcd_seq_item tr;
        // forever begin
        //     $display("DIT CAI CON ME NHAT");
        //     $display("%d", item_q.size);
        //     wait(item_q.size > 0);
        //     if(item_q.size > 0) begin
        //         $display("DIT CAI CON ME MAY");
        //         tr = item_q.pop_front();
        //         num_in++;
        //         //bit [7:0] expected_gcd = compute_gcd(tr.data_a, tr.data_b);
        //         if (tr.result_gcd == compute_gcd(tr.data_a, tr.data_b)) begin
        //             num_correct++;
        //         end else begin
        //             num_incorrect++;
        //             `uvm_error(get_type_name(), $sformatf("Mismatch: Received GCD=%0d, Expected GCD=%0d for inputs A=%0d, B=%0d", tr.result_gcd, compute_gcd(tr.data_a, tr.data_b), tr.data_a, tr.data_b))
        //         end
        //     end
        // end
    endtask

    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Report:\n\n   Scoreboard: Simulation Statistics \n     Num In:   %0d     Num Correct: %0d\n     Num Incorrect: %0d\n", num_in, num_correct, num_incorrect), UVM_LOW)
        if (num_incorrect > 0)
            `uvm_error(get_type_name(), "Status:\n\nSimulation FAILED\n")
        else
            `uvm_info(get_type_name(), "Status:\n\nSimulation PASSED\n", UVM_NONE)
    endfunction : report_phase


endclass : gcd_sb

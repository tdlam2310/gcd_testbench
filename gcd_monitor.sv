class gcd_monitor extends uvm_monitor;
    `uvm_component_utils(gcd_monitor)
    virtual gcd_if vif;
    uvm_analysis_port #(gcd_seq_item) item_collect_port;
    gcd_seq_item seq_item;

    function new(string name = "gcd_monitor", uvm_component parent);
        super.new(name, parent);
       // item_collect_port = new("item_collect_port", this);
    endfunction : new

    //Dont need this shii in monitor
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        $display("[%0t] [MONITOR] Build phase monitor", $time);
        if(!uvm_config_db #(virtual gcd_if)::get(this, "", "gcd_if", vif)) begin
            `uvm_fatal(get_type_name(), "Faield to get virtual interface gcd_vif from uvm_db")
        end
        item_collect_port = new("item_collect_port", this);
    endfunction : build_phase

    task run_phase(uvm_phase phase);
         //super.run_phase(phase);
         $display("[%0t] [MONITOR] Run phase monitor", $time);
         wait(!vif.rst_i);
         //for (int i = 0; i < 2; i++) begin
        forever begin
            //wait(!vif.rst_i);
            //@(posedge vif.valid_i);
            //#1;
            wait(vif.valid_i);
            $display("[%0t] [MONITOR] forever loop", $time);
            seq_item = gcd_seq_item::type_id::create("seq_item", this);
            seq_item.data_a   = vif.a_i;
            seq_item.data_b   = vif.b_i;
            
            $display("[%0t] [MONITOR] data_a = %0d, data_b = %0d",  $time, seq_item.data_a, seq_item.data_b);
            //@(posedge vif.valid_o);
            wait(vif.valid_o);
            seq_item.result_gcd = vif.gcd_o;
            `uvm_info(get_type_name(), $sformatf("Monitored transaction: A=%0d, B=%0d, GCD=%0d", seq_item.data_a, seq_item.data_b, seq_item.result_gcd), UVM_HIGH)
            item_collect_port.write(seq_item);
         end
    endtask : run_phase

endclass : gcd_monitor

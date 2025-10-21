class gcd_driver extends uvm_driver #(gcd_seq_item);
    `uvm_component_utils(gcd_driver)
    gcd_seq_item seq_item;
    virtual gcd_if vif;
    
    function new(string name = "gcd_driver", uvm_component parent);
        super.new(name, parent);
        //seq_item_port = new("seq_item_port", this);
    endfunction : new
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        $display("[%0t] [DRIVER] Build phase driver", $time);
        
        if(!uvm_config_db #(virtual gcd_if)::get(this, "", "gcd_if", vif)) 
            `uvm_fatal(get_type_name(), "Faield to get virtual interface gcd_if from uvm_db")
    endfunction : build_phase   
    
    //virtual function void connect_phase(uvm_phase phase);
        
    //endfunction : connect_phase

    virtual task run_phase(uvm_phase phase);
       super.run_phase(phase);
       $display("[%0t] [DRIVER] RUN phase driver", $time);
       //@(negedge vif.rst_i);
       //for (int i = 0; i < 2; i++) begin
        forever begin
           //seq_item_port.get_next_item(seq_item);
           seq_item_port.get_next_item(req);

           
           $display("[%0t] [Driver] Driving transaction: A=%0d, B=%0d", $time, req.data_a, req.data_b);
           vif.a_i = req.data_a;
           vif.b_i = req.data_b;
           vif.valid_i = 1;
           $display("[%0t] [Driver] Interface recives from driver: A=%0d, B=%0d, VALID_I=%0d", $time, vif.a_i, vif.b_i, vif.valid_i);
           
           @(posedge vif.clk_i);
           vif.valid_i = 0;
           $display("[%0t] [Driver] Deasserted VALID_I signal", $time);
           @(posedge vif.valid_o);
           vif.valid_i = 0;
           //@(posedge vif.valid_o);
           wait(vif.valid_o == 1);

           //seq_item_port.put(req);
           seq_item_port.item_done();
           //@(posedge vif.valid_o);
        end
    endtask : run_phase

endclass : gcd_driver

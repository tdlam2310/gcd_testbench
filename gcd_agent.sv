class gcd_agent extends uvm_agent;
    `uvm_component_utils(gcd_agent)
    // Agent components
    gcd_driver    m_driver;
    gcd_monitor   m_monitor;
    gcd_sequencer m_sequencer;
    virtual gcd_if vif;

    function new(string name = "gcd_agent", uvm_component parent);
        super.new(name, parent);
    endfunction : new
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual gcd_if)::get(this, "", "gcd_if", vif))
          `uvm_fatal(get_type_name(), $sformatf("Faield to get virtual interface vif from uvm_db"))
       // end
        // Instantiate components
        if (get_is_active() == UVM_ACTIVE) begin
            `uvm_info(get_type_name(), "ACTIVE agent", UVM_HIGH)
            m_sequencer = gcd_sequencer::type_id::create("m_sequencer", this);
            m_driver    = gcd_driver::type_id::create("m_driver", this);
        end 
            //`uvm_info(get_type_name(), "PASSIVE agent", UVM_HIGH)
            m_monitor   = gcd_monitor::type_id::create("m_monitor", this);
            uvm_config_db#(virtual gcd_if)::set(this, "m_driver", "gcd_if", vif);
            uvm_config_db#(virtual gcd_if)::set(this, "m_monitor", "gcd_if", vif);
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // Connect sequencer to driver if active
        if (get_is_active() == UVM_ACTIVE) begin
            m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
        end
    endfunction : connect_phase

endclass : gcd_agent

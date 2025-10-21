class gcd_env extends uvm_env;
    `uvm_component_utils(gcd_env)
    gcd_agent     m_agent;
    gcd_sb        m_scoreboard;
    virtual gcd_if vif;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual gcd_if)::get(this, "", "gcd_if", vif))
          `uvm_fatal(get_type_name(), $sformatf("Faield to get virtual interface vif from uvm_db"))
      //  if(!uvm_config_db#(virtual gcd_if)::get(this, "", "vif", vif)) begin
      //    `uvm_fatal(get_type_name(), $sformatf("Faield to get virtual interface vif from uvm_db"))
      //  end
        `uvm_info("build phase", "Building environment", UVM_HIGH)
        if(!uvm_config_db#(virtual gcd_if)::get(this, "", "gcd_if", vif)) begin
          `uvm_fatal(get_type_name(), $sformatf("Failed to get virtual interface vif from uvm_db"))
        end
        
        m_agent      = gcd_agent::type_id::create("m_agent", this);
        m_scoreboard = gcd_sb::type_id::create("m_scoreboard", this);
        
      //  uvm_config_db#(virtual gcd_if)::set(this, "m_agent", "vif", vif);
        uvm_config_db#(virtual gcd_if)::set(this, "m_agent", "gcd_if", vif);
        `uvm_info("build phase", "Finished building environment", UVM_HIGH)
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("connect phase", "Connecting environment", UVM_HIGH)
        //conect
        m_agent.m_monitor.item_collect_port.connect(m_scoreboard.item_analysis_export);
        `uvm_info("connect phase", "Finished connecting environment", UVM_HIGH)
    endfunction : connect_phase

endclass : gcd_env

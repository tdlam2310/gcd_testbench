class gcd_sequencer extends uvm_sequencer #(gcd_seq_item);
    `uvm_component_utils(gcd_sequencer)

    function new(string name = "gcd_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
endclass : gcd_sequencer

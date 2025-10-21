class simple_gcd_seq extends base_gcd_seq;

    // UVM Component Macro
    `uvm_object_utils(simple_gcd_seq)

    // UVM Constructor
    function new(string name = "simple_gcd_seq");
        super.new(name);
    endfunction : new

    // Sequence body definition
    virtual task body();
        gcd_seq_item req;
        req = gcd_seq_item::type_id::create("req");
        for (int i = 0; i < 2; i++) begin
            //req = gcd_seq_item::type_id::create("req");
            start_item(req);
            req.randomize();
            finish_item(req);
            //get_response(rsp);

        end
        // Example transaction generation logic
        // This is where you would define the specific sequence behavior
        // `uvm_info(get_type_name(), "Executing simple sequence", UVM_LOW)
        // `uvm_do_with(req, { data_a == 2; data_b == 2; })           // both zero
        // `uvm_do_with(req, { data_a == 1; data_b == 255; })
       // `uvm_do_with(req, { data_b == 1; data_a == 255; })
       // `uvm_do_with(req, { data_a == data_b; data_a == 255; }) // equal values
        // req = gcd_seq_item::type_id::create("req", , get_full_name());
        // start_item(req);
        // if (!req.randomize() with { data_a == 1; data_b == 1; })
        //     `uvm_error(get_type_name(), "Randomize failed (1,1)");
        // finish_item(req);

        // start_item(req);
        // if (!req.randomize() with { data_a == 1; data_b == 255; })
        //     `uvm_error(get_type_name(), "Randomize failed (1,255)");
        // finish_item(req);

        // start_item(req);
        // if (!req.randomize() with { data_b == 1; data_a == 255; })
        //     `uvm_error(get_type_name(), "Randomize failed (255,1)");
        // finish_item(req);

        // start_item(req);
        // if (!req.randomize() with { data_a == data_b; data_a == 255; })
        //     `uvm_error(get_type_name(), "Randomize failed (255,255 equal)");
        // finish_item(req);
    endtask : body

endclass : simple_gcd_seq

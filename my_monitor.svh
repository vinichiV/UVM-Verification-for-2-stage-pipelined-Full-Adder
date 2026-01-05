class my_monitor extends uvm_monitor;
    `uvm_component_utils(my_monitor)

    // TLM port
    uvm_analysis_port #(my_transaction) ap;

    virtual FullAdder_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(virtual FullAdder_if)::get(this, "", "dut_vif", vif))
        `uvm_fatal("MONITOR", "Cannot get FullAdder_if")
    endfunction
	
          
    task run_phase(uvm_phase phase);
        my_transaction tr;
      	tr.cnt_in = 0;
   		tr.cnt_out = 0;
      
        forever begin
        	@(posedge vif.clk);
          
          	if (vif.in_valid) begin
              tr = my_transaction::type_id::create("tr");
              tr.is_input = 1;
              
              tr.in_valid = vif.in_valid;
              tr.a    = vif.a;
              tr.b    = vif.b;
              tr.cin  = vif.cin;
              
              tr.cnt_in++;

              `uvm_info("MONITOR", $sformatf("Transaction [%0d] INPUT: a=%0b b=%0b cin=%0b", tr.cnt_in, tr.a, tr.b, tr.cin), UVM_MEDIUM)
              
              ap.write(tr);
            end
          	
          	if (vif.out_valid) begin
              tr = my_transaction::type_id::create("tr");
              tr.is_output = 1;

              tr.sum  = vif.sum;
              tr.cout = vif.cout;
              
              tr.cnt_out++;
              
              `uvm_info("MONITOR", $sformatf("Transaction [%0d] OUTPUT: sum=%0b cout=%0b", tr.cnt_out, tr.sum, tr.cout), UVM_MEDIUM)

              ap.write(tr);
            end
        end
    endtask
endclass

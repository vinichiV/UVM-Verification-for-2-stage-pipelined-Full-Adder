class my_driver extends uvm_driver #(my_transaction);

  `uvm_component_utils(my_driver)

  virtual FullAdder_if dut_vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Get interface reference from config database
    if(!uvm_config_db#(virtual FullAdder_if)::get(this, "", "dut_vif", dut_vif))
    `uvm_fatal("DRIVER", "virtual interface not set")
    
  endfunction 

  task run_phase(uvm_phase phase);
    
    dut_vif.reset_n = 0;
    repeat(2) @(posedge dut_vif.clk);
    dut_vif.reset_n = 1;
    
    forever begin
      seq_item_port.get_next_item(req);

      @(posedge dut_vif.clk);
      dut_vif.in_valid <= req.in_valid;
      dut_vif.a        <= req.a;
      dut_vif.b        <= req.b;
      dut_vif.cin      <= req.cin;

      seq_item_port.item_done();
    end
  endtask

endclass: my_driver
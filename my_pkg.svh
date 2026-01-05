package my_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "my_transaction.svh"
    `include "my_sequence.svh"
    `include "my_scoreboard.svh"
    `include "my_driver.svh"
    `include "my_monitor.svh"

    class my_agent extends uvm_agent;

        `uvm_component_utils(my_agent)

        my_driver driver;
        uvm_sequencer#(my_transaction) sequencer;
      	my_monitor monitor;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
          
          	monitor = my_monitor::type_id::create("monitor", this);

            if (is_active == UVM_ACTIVE) begin
                driver    = my_driver::type_id::create("driver", this);
              	sequencer = uvm_sequencer#(my_transaction)::type_id::create("sequencer", this);
            end
        endfunction

        function void connect_phase(uvm_phase phase);
              super.connect_phase(phase);
              if (is_active == UVM_ACTIVE) begin
                driver.seq_item_port.connect(sequencer.seq_item_export);
              end
        endfunction

    endclass

    class my_env extends uvm_env;

        `uvm_component_utils(my_env)

        my_agent agent;
      	my_scoreboard scoreboard;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            agent = my_agent::type_id::create("agent", this);
          	scoreboard = my_scoreboard::type_id::create("scoreboard", this);
        endfunction
      
        function void connect_phase(uvm_phase phase);
          super.connect_phase(phase);
          agent.monitor.ap.connect(scoreboard.analysis_imp);
    	endfunction
      
    endclass

    class my_test extends uvm_test;

        `uvm_component_utils(my_test)

        my_env env;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            env = my_env::type_id::create("env", this);
        endfunction

        task run_phase(uvm_phase phase);
            my_sequence seq;

            phase.raise_objection(this);

            // Create and start sequence
            seq = my_sequence::type_id::create("seq");
            seq.start(env.agent.sequencer);
          	repeat (3) @(posedge env.agent.driver.dut_vif.clk);

            phase.drop_objection(this);
        endtask

    endclass

endpackage


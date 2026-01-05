class my_sequence extends uvm_sequence#(my_transaction);

    `uvm_object_utils(my_sequence)

    function new(string name = "");
        super.new(name);
    endfunction

    task body();
      	repeat (100) begin
            req = my_transaction::type_id::create("req");

            // Handshake driver
            start_item(req);

            // Randomize input of full adder
            if (!req.randomize() with { in_valid == 1; }) begin
                `uvm_error("SEQUENCE", "Randomize failed")
            end

            finish_item(req);
        end
    endtask : body

endclass: my_sequence

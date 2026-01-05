class my_transaction extends uvm_sequence_item;

    `uvm_object_utils(my_transaction)
    
    // ===== INPUT =====
    rand bit a;
    rand bit b;
    rand bit cin;
    rand bit in_valid;

    // ===== OUTPUT (filled by monitor) =====
    bit sum;
    bit cout;
    bit out_valid;
  
  	bit is_input;
  	bit is_output;
  
  	static int cnt_in;
   	static int cnt_out;
  
    constraint c_valid {
        in_valid == 1;
    }

    // Constructor
    function new(string name = "my_transaction");
        super.new(name);
    endfunction
  
//     bit exp_sum;
//     bit exp_cout;

//     function void calculate_expected();
//         exp_sum  = a ^ b ^ cin;
//         exp_cout = (a & b) | (cin & (a ^ b));
//     endfunction

endclass: my_transaction
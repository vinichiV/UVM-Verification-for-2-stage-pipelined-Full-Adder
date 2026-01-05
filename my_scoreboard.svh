class my_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(my_scoreboard)

  uvm_analysis_imp #(my_transaction, my_scoreboard) analysis_imp;

  typedef struct {
    bit sum;
    bit cout;
  } exp_t;

  exp_t exp_q[$];
  int pipeline_depth = 2;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
  endfunction

  function void write(my_transaction tr);
    exp_t exp;

    // ================= INPUT =================
    if (tr.is_input) begin
      {exp.cout, exp.sum} = tr.a + tr.b + tr.cin;
      
      exp_q.push_front(exp);
    end

    // ================= OUTPUT =================
    else if (tr.is_output) begin
//       if (exp_q.size() <= pipeline_depth) begin
//         `uvm_warning("SCOREBOARD", "Pipeline not filled yet")
//         return;
//       end

      exp = exp_q.pop_back();

      if (tr.sum !== exp.sum || tr.cout !== exp.cout) begin
        `uvm_error("SCOREBOARD", $sformatf("Mismatch! exp={%0b,%0b} got={%0b,%0b}", exp.sum, exp.cout, tr.sum, tr.cout))
      end
      else begin
        `uvm_info("SCOREBOARD", "PASS", UVM_LOW)
      end
      
    end
  endfunction
endclass

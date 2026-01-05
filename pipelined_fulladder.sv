interface FullAdder_if;
  logic clk;
  logic reset_n;
  logic in_valid;
  logic a, b, cin;
  logic out_valid;
  logic sum, cout;
endinterface

//   assign sum = a ^ b ^ cin;
//   assign cout = (a & b) | (cin & (a ^ b));
module FullAdder (FullAdder_if fa_if);

  logic r1, r2, cin_d, v1; 	// stage 1
  logic r3, r4, v2;			// stage 2

  always @(posedge fa_if.clk or negedge fa_if.reset_n) begin
    if (!fa_if.reset_n) begin
      r1 <= 0; r2 <= 0; cin_d <= 0; v1 <= 0;
      r3 <= 0; r4 <= 0; v2 <= 0;
    end else begin
      r1    <= fa_if.a ^ fa_if.b;
      r2    <= fa_if.a & fa_if.b;
      cin_d <= fa_if.cin;
      v1    <= fa_if.in_valid;

      r3 <= r1 ^ cin_d;
      r4 <= (r1 & cin_d) | r2;
      v2 <= v1;
    end
  end

  assign fa_if.sum       = r3;
  assign fa_if.cout      = r4;
  assign fa_if.out_valid = v2;

endmodule
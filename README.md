# UVM Verification for 2-Stage Pipelined Full Adder

This repository demonstrates a **UVM-based verification environment** for a **2-stage pipelined Full Adder** design, implemented in **SystemVerilog** and simulated using **QuestaSim**.

The project includes:
- A synthesizable 2-stage pipelined Full Adder DUT
- A complete UVM testbench (driver, sequencer, monitor, scoreboard)
- An automated simulation script (`run.do`) for quick setup and execution

---

## 🚀 How to Run the Simulation

### Prerequisite
- **QuestaSim** installed (with UVM support)

### Steps

```bash
git clone https://github.com/vinichiV/UVM-Verification-for-2-stage-pipelined-Full-Adder

cd UVM-Verification-for-2-stage-pipelined-Full-Adder

vsim -do run.do
```
<img width="921" height="848" alt="image" src="https://github.com/user-attachments/assets/bee335b1-57c6-471b-9415-867204e9d407" />


# Basics

Early exercises from when I was just starting to learn what Verilog and HDLs even were, before moving into the verification projects. It contains gate-level and behavioral Verilog, each in its own directory with a separate testbench, a run script and a README. Started with simple RTL designs like adder, MUX, sequential counter and then moved to sub-module based ones like `rca_16bit` using half adders and `counter_4bit_cdv` with self-checking testbench and eventually `rand`/`constraint`/`covergroup`.

Most were originally written and simulated in EDA Playground using Icarus Verilog. Only the CDV based counter was simulated through Aldec Riviera-Pro. Each directory now also has a `run.py` that compiles and simulates the design with ModelSim/Questa.

## Structure

Every module lives in its own directory:

```
module_name/
├── module_name.v        RTL
├── tb_module_name.v     testbench
├── run.py               compile and simulate script
└── README.md            project details
```

The CDV counter uses `.sv` files instead of `.v`.

## Running

Requires a ModelSim/Questa installation with `vlib`, `vmap`, `vlog` and `vsim` on your `PATH`, and Python 3. From inside any module directory, run:

```
python run.py
```

## Projects

| Directory | Briefing |
|---|---|
| [`adder_4bit/`](adder_4bit) | 4-bit adder, directed stimulus |
| [`subtractor_4bit/`](subtractor_4bit) | 4-bit subtractor, zero-on-underflow |
| [`alu_4bit/`](alu_4bit) | Behavioral ALU (add/subtract/AND/OR), directed stimulus; the earliest version of the ALU idea, before the CDV and UVM-style projects |
| [`mux_4bit/`](mux_4bit) | 4-to-1 mux built from `and`/`or`/`not` primitives instead of behavioral logic |
| [`counter_4bit/`](counter_4bit) | Free-running 4-bit sequential counter, plain Verilog |
| [`accumulator_manual/`](accumulator_manual) | Register + gate-level ripple-carry adder wired into a feedback accumulator |
| [`rca_16bit/`](rca_16bit) | 16-bit ripple-carry adder built from cascaded 4-bit blocks down to half-adders; `$random` stimulus with a self-checking task and error count |
| [`counter_4bit_cdv/`](counter_4bit_cdv) | Same counter idea as `counter_4bit`, rebuilt in SystemVerilog with `rand`/`constraint`/`covergroup` and a clocking-block interface; the first time these ideas started to show up before the main projects |
| [`traffic_light_simulator/`](traffic_light_simulator) | Simple traffic-light FSM driven off a free-running counter |
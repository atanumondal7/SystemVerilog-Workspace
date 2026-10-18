# Accumulator Manual

A 4-bit accumulator built entirely from gate-level primitives: a ripple-carry adder (RCA) made of full adders, which are in turn made of half adders. A 4-bit register feeds the adder output back to its own input, so every clock edge adds the input `d` to the running total.

## How it works

On every rising clock edge the register stores `q + d`. An asynchronous reset clears the total to zero.

Note that `carry` is the combinational carry-out of `q + d` using the *current* `q`. It is not a registered overflow flag, so it tells you whether the *next* addition will overflow.

## Module hierarchy

| Module | Description |
|---|---|
| `accumulator_manual` | Top level. Connects the register and the adder in a feedback loop. |
| `reg_4bit` | 4-bit register with asynchronous active-high reset. |
| `ripple_carry_adder` | 4-bit RCA chaining four full adders, with carry-in tied to `0`. |
| `fulladder` | Two half adders plus an OR gate for the carry. |
| `halfadder` | One `xor` (sum) and one `and` (carry) gate primitive. |

## Ports

| Port | Dir | Width | Description |
|---|---|---|---|
| `d` | in | 4 | Value to add each cycle |
| `clk` | in | 1 | Clock, rising-edge triggered |
| `rst` | in | 1 | Asynchronous reset, active high |
| `q` | out | 4 | Accumulated total (wraps modulo 16) |
| `carry` | out | 1 | Carry-out of `q + d` (combinational) |

## Testbench

`tb_accumulator_manual.v` is a directed testbench:

- 20 ns clock period (`timescale 1ns/1ps`).
- Applies reset, then drives `d` from `0` to `15` in order, one value per clock cycle. Inputs change on the falling edge so they are stable at the rising edge.
- Prints `d`, `rst`, `q` and `carry` after each step with a `disp` task.
- Dumps waveforms to `dump.vcd`.

The testbench is not self-checking, so I have verified the output through manual calculations.

### Expected output

Since `q` is the running sum of `d` modulo 16:

| d | q | carry |
|---|---|---|
| 0 (reset) | 0 | 0 |
| 1 | 1 | 0 |
| 2 | 3 | 0 |
| 3 | 6 | 0 |
| 4 | 10 | 0 |
| 5 | 15 | 1 |
| 6 | 5 | 0 |
| 7 | 12 | 1 |
| 8 | 4 | 0 |
| 9 | 13 | 1 |
| 10 | 7 | 1 |
| 11 | 2 | 0 |
| 12 | 14 | 1 |
| 13 | 11 | 1 |
| 14 | 9 | 1 |
| 15 | 8 | 1 |

## Running the simulation

Requires a ModelSim/Questa installation with `vlib`, `vmap`, `vlog` and `vsim` on your `PATH`, and Python 3.

From this directory, execute the command:

```
python run.py
```


## Files

| File | Purpose |
|---|---|
| `accumulator_manual.v` | RTL: accumulator, register, RCA, full adder, half adder |
| `tb_accumulator_manual.v` | Directed testbench |
| `run.py` | Compile and simulate script |
| `README.md` | Project details |
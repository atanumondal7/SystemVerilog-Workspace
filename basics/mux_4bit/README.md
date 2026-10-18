# Mux 4-bit

A 4-to-1 multiplexer built from three 2-to-1 multiplexers, each made of basic gate primitives. Despite the "4bit" in the name, the four data inputs are single bits. The 4 refers to the number of inputs.

## How it works

The 2-bit select `sel` chooses which of the four inputs `i0` to `i3` appears on `y`. It is built as two stages:

1. Two 2-to-1 muxes in the first stage. One chooses between `i0` and `i1`, the other between `i2` and `i3`. Both are controlled by `sel[0]`.
2. One 2-to-1 mux in the second stage that chooses between the two first-stage outputs, controlled by `sel[1]`.

Each 2-to-1 mux is built from gate primitives: `y = (a & ~sel) | (b & sel)`. This gives `a` when `sel` is `0` and `b` when `sel` is `1`.

| `sel` | `y` |
|---|---|
| `2'b00` | `i0` |
| `2'b01` | `i1` |
| `2'b10` | `i2` |
| `2'b11` | `i3` |

The design is purely combinational, so `y` updates whenever an input or `sel` changes.

## Module hierarchy

| Module | Description |
|---|---|
| `mux_4bit` | Top level. Connects three `mux2to1` instances in two stages. |
| `mux2to1` | 2-to-1 mux made of one `not`, two `and` and one `or` gate primitive |

Both modules are situated in one single RTL file.

## Ports

| Port | Dir | Width | Description |
|---|---|---|---|
| `i0` | in | 1 | Data input 0 |
| `i1` | in | 1 | Data input 1 |
| `i2` | in | 1 | Data input 2 |
| `i3` | in | 1 | Data input 3 |
| `sel` | in | 2 | Select, picks which input reaches `y` |
| `y` | out | 1 | Selected input |

## Testbench

`tb_mux_4bit.v` is a directed testbench:

- `timescale 1ns/1ps`, no clock since the design is combinational.
- For each of the four `sel` values, drives a one-hot pattern on the inputs (only one of `i0` to `i3` is high at a time), for 16 cases in total. Each case is held for 10 ns.
- Prints all inputs, `sel` and `y` after each step with a `disp` task.
- Dumps waveforms to `dump.vcd`.

Using one-hot inputs means `y` is `1` only when the high input is the one that `sel` selects, which makes mistakes in the select wiring easy to spot.

The testbench is not self-checking, so I have verified the output through manual calculations.

### Expected output

| i0 | i1 | i2 | i3 | sel | y |
|---|---|---|---|---|---|
| 1 | 0 | 0 | 0 | 00 | 1 |
| 0 | 1 | 0 | 0 | 00 | 0 |
| 0 | 0 | 1 | 0 | 00 | 0 |
| 0 | 0 | 0 | 1 | 00 | 0 |
| 1 | 0 | 0 | 0 | 01 | 0 |
| 0 | 1 | 0 | 0 | 01 | 1 |
| 0 | 0 | 1 | 0 | 01 | 0 |
| 0 | 0 | 0 | 1 | 01 | 0 |
| 1 | 0 | 0 | 0 | 10 | 0 |
| 0 | 1 | 0 | 0 | 10 | 0 |
| 0 | 0 | 1 | 0 | 10 | 1 |
| 0 | 0 | 0 | 1 | 10 | 0 |
| 1 | 0 | 0 | 0 | 11 | 0 |
| 0 | 1 | 0 | 0 | 11 | 0 |
| 0 | 0 | 1 | 0 | 11 | 0 |
| 0 | 0 | 0 | 1 | 11 | 1 |

## Running the simulation

Requires a ModelSim/Questa installation with `vlib`, `vmap`, `vlog` and `vsim` on your `PATH`, and Python 3.

From this directory, execute the command:

```
python run.py
```

## Files

| File | Purpose |
|---|---|
| `mux_4bit.v` | RTL: 4-to-1 mux and the 2-to-1 mux it is built from |
| `tb_mux_4bit.v` | Directed testbench |
| `run.py` | Compile and simulate script |
| `README.md` | Project details |
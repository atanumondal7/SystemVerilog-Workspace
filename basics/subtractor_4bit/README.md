# Subtractor 4-bit

A 4-bit combinational subtractor that computes `a - b` using two's complement addition. It outputs a 4-bit result and a flag that is set when the answer would be negative.

## How it works

The module compares the two operands inside an `always @(*)` block:

- If `a >= b`, the result is `a + (~b + 1)`. Adding the two's complement of `b` is the same as subtracting `b`. `negative` is `0`.
- If `a < b`, the result cannot be represented as an unsigned value, so `result` is forced to `0` and `negative` is set to `1`.

The design is purely combinational, so the outputs update whenever `a` or `b` changes. When `a` equals `b`, the result is `0` and `negative` is `0`.

## Module hierarchy

| Module | Description |
|---|---|
| `subtractor_4bit` | Single module. Compares the operands and computes the result and flag in one `always` block. |

## Ports

| Port | Dir | Width | Description |
|---|---|---|---|
| `a` | in | 4 | Minuend |
| `b` | in | 4 | Subtrahend |
| `result` | out | 4 | `a - b` when `a >= b`, otherwise `0` |
| `negative` | out | 1 | Set when `a < b` |

## Testbench

`tb_subtractor_4bit.v` is a directed testbench:

- `timescale 1ns/1ps`, no clock since the design is combinational.
- Applies three hand-picked `(a, b)` pairs, holding each for 10 ns before printing. They cover two normal subtractions and one case where `a < b`.
- Prints `a`, `b`, `result` and `negative` (as `Yes` or `No`) after each step with a `disp` task.
- Dumps waveforms to `dump.vcd`.

The case `a == b` is not covered by this testbench.

The testbench is not self-checking, so I have verified the output through manual calculations.

### Expected output

| a | b | result | negative |
|---|---|---|---|
| 7 | 3 | 4 | No |
| 9 | 5 | 4 | No |
| 3 | 11 | 0 | Yes |

In the last row `a < b`, so the result is clamped to `0` instead of wrapping around.

## Running the simulation

Requires a ModelSim/Questa installation with `vlib`, `vmap`, `vlog` and `vsim` on your `PATH`, and Python 3.

From this directory, execute the command:

```
python run.py
```

## Files

| File | Purpose |
|---|---|
| `subtractor_4bit.v` | RTL: 4-bit subtractor |
| `tb_subtractor_4bit.v` | Directed testbench |
| `run.py` | Compile and simulate script |
| `README.md` | Project details |
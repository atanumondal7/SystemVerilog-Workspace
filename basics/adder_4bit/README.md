# Adder 4-bit

A 4-bit combinational adder written behaviorally using the `+` operator. It takes two 4-bit inputs and produces a 4-bit sum and a carry-out bit.

## How it works

The module concatenates `carry` and `sum` into a single 5-bit target, `{carry, sum}`, and assigns it `a + b`. Verilog widens the addition to fit the 5-bit left-hand side, so the 5th bit of the result becomes `carry` and the lower 4 bits become `sum`. There is no clock or state, so the outputs update whenever `a` or `b` changes.

## Module hierarchy

| Module | Description |
|---|---|
| `adder_4bit` | Single module. Adds `a` and `b` with a continuous assignment. |

## Ports

| Port | Dir | Width | Description |
|---|---|---|---|
| `a` | in | 4 | First operand |
| `b` | in | 4 | Second operand |
| `sum` | out | 4 | Lower 4 bits of `a + b` |
| `carry` | out | 1 | Carry-out, set when `a + b` exceeds 15 |

## Testbench

`tb_adder_4bit.v` is a directed testbench:

- `timescale 1ns/1ps`, no clock since the design is combinational.
- Applies five hand-picked `(a, b)` pairs, holding each for 10 ns before printing.
- Prints `a`, `b`, `sum` and `carry` after each step with a `disp` task.
- Dumps waveforms to `dump.vcd`.

The testbench is not self-checking, so I have verified the output through manual calculations.

### Expected output

| a | b | sum | carry |
|---|---|---|---|
| 9 | 5 | 14 | 0 |
| 5 | 9 | 14 | 0 |
| 7 | 3 | 10 | 0 |
| 15 | 1 | 0 | 1 |
| 11 | 13 | 8 | 1 |

The last two rows overflow 4 bits: 15 + 1 = 16 and 11 + 13 = 24, which are `1_0000` and `1_1000` in binary.

## Running the simulation

Requires a ModelSim/Questa installation with `vlib`, `vmap`, `vlog` and `vsim` on your `PATH`, and Python 3.

From this directory, execute the command:

```
python run.py
```

## Files

| File | Purpose |
|---|---|
| `adder_4bit.v` | RTL: 4-bit adder |
| `tb_adder_4bit.v` | Directed testbench |
| `run.py` | Compile and simulate script |
| `README.md` | Project details |
# RCA 16-bit

A 16-bit ripple-carry adder built hierarchically: four 4-bit ripple-carry adders chained together, each made of four full adders, which are in turn made of half adders. It adds two 16-bit operands plus a carry-in and produces a 16-bit sum and a carry-out.

## How it works

The carry ripples from the least significant bit up through every stage:

1. `rca_16bit` splits the operands into four 4-bit slices. The carry-out of each slice feeds the carry-in of the next, and `cin` feeds the lowest slice.
2. Each `rca4bit` chains four `fulladder` modules the same way, one bit at a time.
3. Each `fulladder` uses two `halfadder` modules and an `or` gate: the first adds `a` and `b`, the second adds that sum and `cin`, and the two partial carries are ORed into `cout`.
4. Each `halfadder` computes `{cout, q} = a + b`.

The design is purely combinational, so the outputs update whenever an input changes. Because the carry has to ripple through all 16 bit positions, the delay grows with the width.

## Module hierarchy

| Module | Description |
|---|---|
| `rca_16bit` | Top level. Chains four `rca4bit` modules through their carry signals. |
| `rca4bit` | 4-bit ripple-carry adder made of four `fulladder` modules. |
| `fulladder` | Two `halfadder` modules plus an `or` gate for the carry. |
| `halfadder` | Single-bit adder written with `assign {cout, q} = a + b`. |

## Ports

| Port | Dir | Width | Description |
|---|---|---|---|
| `a` | in | 16 | First operand |
| `b` | in | 16 | Second operand |
| `cin` | in | 1 | Carry-in |
| `q` | out | 16 | Sum, the lower 16 bits of `a + b + cin` |
| `cout` | out | 1 | Carry-out, set when `a + b + cin` exceeds 65535 |

## Testbench

`tb_rca_16bit.v` is a self-checking, random-stimulus testbench:

- `timescale 1ns/1ps`, no clock since the design is combinational.
- Runs 10 iterations. Each one assigns random values to `a`, `b` and `cin` using `$random`, waits 10 ns, then calls the `check` task.
- The `check` task prints the inputs and outputs, computes the expected result as `{carry, sum} = a + b + cin` in a 17-bit value, and compares it with the DUT outputs. Mismatches are counted in `error_count`.
- Dumps waveforms to `dump.vcd`.

`$random` is called without a seed, so it gives the same sequence on every run. With only 10 vectors, corner cases such as all ones or a carry rippling through all 16 bits are not guaranteed to be hit.

### Expected output

Since the stimulus is random, there is no fixed table of values. Each iteration prints two lines:

```
[TB_CHECK] Input: a=<a>, b=<b>, cin=<c> | Output: sum=<q>, carry=<cout>
[SUCCESS] Time: <t> | Matched expected: sum=<sum>, carry=<carry>
```

A mismatch prints `[ERROR]` with the expected and actual values instead of `[SUCCESS]`. After the last iteration, the run ends with `All tests passed successfully!` if there were no mismatches, otherwise `Simulation failed! Encountered <n> errors`.

## Running the simulation

Requires a ModelSim/Questa installation with `vlib`, `vmap`, `vlog` and `vsim` on your `PATH`, and Python 3.

From this directory, execute the command:

```
python run.py
```

## Files

| File | Purpose |
|---|---|
| `rca_16bit.v` | RTL: 16-bit RCA, 4-bit RCA, full adder, half adder |
| `tb_rca_16bit.v` | Self-checking random testbench |
| `run.py` | Compile and simulate script |
| `README.md` | Project details |
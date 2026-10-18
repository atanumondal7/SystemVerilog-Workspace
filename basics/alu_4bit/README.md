# ALU 4-bit

A 4-bit combinational ALU that performs add, subtract, AND and OR on two 4-bit operands, selected by a 2-bit opcode. It also outputs carry, negative and zero flags.

## How it works

The module is a single `always @(*)` block. Every output is first set to `0`, then a `case` on `opcode` overrides what the selected operation needs. There is no clock or state, so the outputs update whenever `a`, `b` or `opcode` changes.

| Opcode | Operation | Behavior |
|---|---|---|
| `2'b00` | Add | `{carry_out, result} = a + b`. `zero_flag` is set if `result` is `0`. |
| `2'b01` | Subtract | If `a >= b`, `result = a - b` and `zero_flag` is set if the result is `0`. If `a < b`, `neg_flag` is set and `result` is forced to `0`. |
| `2'b10` | AND | `result = a & b`. `zero_flag` is set if `result` is `0`. |
| `2'b11` | OR | `result = a \| b`. `zero_flag` is set if `result` is `0`. |

Note that when subtraction underflows (`a < b`), `result` is clamped to `0` instead of wrapping, and `zero_flag` stays `0`, so `neg_flag` is the only indication. `carry_out` is only ever set by the add operation.

## Module hierarchy

| Module | Description |
|---|---|
| `alu_4bit` | Single module. Selects the operation with a `case` statement and sets the flags. |

## Ports

| Port | Dir | Width | Description |
|---|---|---|---|
| `a` | in | 4 | First operand |
| `b` | in | 4 | Second operand |
| `opcode` | in | 2 | Operation select (see table above) |
| `result` | out | 4 | Result of the selected operation |
| `carry_out` | out | 1 | Carry-out of the add operation |
| `neg_flag` | out | 1 | Set when subtraction is attempted with `a < b` |
| `zero_flag` | out | 1 | Set when a valid `result` is `0` |

## Testbench

`tb_alu_4bit.v` is a directed testbench:

- `timescale 1ns/1ps`, no clock since the design is combinational.
- Applies seven hand-picked `(a, b, opcode)` combinations, holding each for 10 ns before printing. They cover add with and without carry, each of the other three operations, and subtract in the `a < b` and `a == b` cases.
- Prints `a`, `b`, `opcode`, `result` and all three flags after each step with a `disp` task.
- Dumps waveforms to `dump.vcd`.

The testbench is not self-checking, so I have verified the output through manual calculations.

### Expected output

| a | b | opcode | result | carry_out | neg_flag | zero_flag |
|---|---|---|---|---|---|---|
| 7 | 3 | 0 (add) | 10 | 0 | 0 | 0 |
| 11 | 9 | 0 (add) | 4 | 1 | 0 | 0 |
| 7 | 3 | 1 (sub) | 4 | 0 | 0 | 0 |
| 7 | 3 | 2 (and) | 3 | 0 | 0 | 0 |
| 7 | 3 | 3 (or) | 7 | 0 | 0 | 0 |
| 3 | 7 | 1 (sub) | 0 | 0 | 1 | 0 |
| 3 | 3 | 1 (sub) | 0 | 0 | 0 | 1 |

The second row overflows 4 bits: 11 + 9 = 20, which is `1_0100` in binary.

## Running the simulation

Requires a ModelSim/Questa installation with `vlib`, `vmap`, `vlog` and `vsim` on your `PATH`, and Python 3.

From this directory, execute the command:

```
python run.py
```

## Files

| File | Purpose |
|---|---|
| `alu_4bit.v` | RTL: 4-bit ALU |
| `tb_alu_4bit.v` | Directed testbench |
| `run.py` | Compile and simulate script |
| `README.md` | Project details |
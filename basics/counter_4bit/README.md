# Counter 4-bit

A 4-bit synchronous up counter with an asynchronous reset. It increments by one on every rising clock edge and wraps from 15 back to 0.

## How it works

On every rising edge of `clk`, `count` is incremented by 1. When `rst` goes high, `count` is cleared to `0` immediately, without waiting for a clock edge. Because `count` is only 4 bits wide, it rolls over from `15` to `0` on its own.

## Module hierarchy

| Module | Description |
|---|---|
| `counter_4bit` | Single module. Holds the count in a register updated by one `always` block. |

## Ports

| Port | Dir | Width | Description |
|---|---|---|---|
| `clk` | in | 1 | Clock, rising-edge triggered |
| `rst` | in | 1 | Asynchronous reset, active high |
| `count` | out | 4 | Current count (wraps modulo 16) |

## Testbench

`tb_counter_4bit.v` is a directed testbench:

- 20 ns clock period (`timescale 1ns/1ps`).
- Asserts `rst` at the start, releases it after 5 ns, then lets the counter run for 200 ns before calling `$finish`.
- Uses `$monitor` to print `count` every time it changes.
- Dumps waveforms to `dump.vcd`.

The run is short, so `count` only reaches about 10 and never rolls over from 15 to 0. The wraparound is not exercised by this testbench.

The testbench is not self-checking, so I have verified the output through manual calculations.

### Expected output

Rising clock edges occur at 10 ns, 30 ns, 50 ns and so on. The count is `0` after reset and goes up by one at each edge:

| Time (ns) | count |
|---|---|
| 0 (after reset) | 0 |
| 10 | 1 |
| 30 | 2 |
| 50 | 3 |
| 70 | 4 |
| 90 | 5 |
| 110 | 6 |
| 130 | 7 |
| 150 | 8 |
| 170 | 9 |
| 190 | 10 |

The simulation ends at 210 ns, which is the same moment as the next clock edge. Whether a final `Counter: 11` line appears depends on the simulator's event ordering.

## Running the simulation

Requires a ModelSim/Questa installation with `vlib`, `vmap`, `vlog` and `vsim` on your `PATH`, and Python 3.

From this directory, execute the command:

```
python run.py
```

## Files

| File | Purpose |
|---|---|
| `counter_4bit.v` | RTL: 4-bit up counter |
| `tb_counter_4bit.v` | Directed testbench |
| `run.py` | Compile and simulate script |
| `README.md` | Project details |
# Traffic Light Simulator

A counter-based traffic light controller. A 4-bit counter runs freely, and the red, yellow and green outputs switch at fixed count values. One full light sequence takes 16 clock cycles.

## How it works

On every rising clock edge `count` is incremented by 1 and wraps from `15` back to `0`. An asynchronous reset clears `count` to `0` and turns on red only.

The lights change when the current `count` matches a fixed value at a clock edge, so the new light appears together with the next count value:

| `count` at the edge | Action |
|---|---|
| `5` | Red off, green on |
| `10` | Green off, yellow on |
| `12` | Yellow off, red on |

Reading the outputs after each clock edge, the sequence repeats every 16 cycles:

| `count` | red | yellow | green | Cycles |
|---|---|---|---|---|
| 0 to 5 | 1 | 0 | 0 | 6 |
| 6 to 10 | 0 | 0 | 1 | 5 |
| 11 to 12 | 0 | 1 | 0 | 2 |
| 13 to 15 | 1 | 0 | 0 | 3 |

Red is on for a total of 9 cycles per loop (`13`, `14`, `15`, then `0` to `5`), green for 5 and yellow for 2. Exactly one light is on at any time.

## Module hierarchy

| Module | Description |
|---|---|
| `traffic_light_simulator` | Single module. A free-running counter and the light-switching logic in one `always` block. |

## Ports

| Port | Dir | Width | Description |
|---|---|---|---|
| `clk` | in | 1 | Clock, rising-edge triggered |
| `rst` | in | 1 | Asynchronous reset, active high |
| `red` | out | 1 | Red light |
| `yellow` | out | 1 | Yellow light |
| `green` | out | 1 | Green light |
| `count` | out | 4 | Current cycle count (wraps modulo 16) |

## Testbench

`tb_traffic_light_simulator.v` is a directed testbench:

- 20 ns clock period (`timescale 1ns/1ps`).
- Asserts `rst` at the start, releases it after 5 ns, then lets the design run for 2400 ns, which is 120 clock cycles. That covers seven full light sequences and half of an eighth.
- Uses `$monitor` to print the signal values whenever any of them changes.
- Dumps waveforms to `dump.vcd`.

The testbench is not self-checking, so I have verified the behavior through manual calculations.

### Expected output

With the reset released, the outputs follow the table in the How it works section, starting from red on with `count` at `0`. The simulation ends at 2410 ns, which is the same moment as a clock edge, so whether the last transition is printed depends on the simulator's event ordering.

## Running the simulation

Requires a ModelSim/Questa installation with `vlib`, `vmap`, `vlog` and `vsim` on your `PATH`, and Python 3.

From this directory, execute the command:

```
python run.py
```

## Files

| File | Purpose |
|---|---|
| `traffic_light_simulator.v` | RTL: counter-based traffic light controller |
| `tb_traffic_light_simulator.v` | Directed testbench |
| `run.py` | Compile and simulate script |
| `README.md` | Project details |
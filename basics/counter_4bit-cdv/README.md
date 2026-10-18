# Counter 4-bit CDV

A 4-bit up counter with asynchronous reset and synchronous parallel load, verified with a constrained-random, coverage-driven testbench. The testbench uses a randomized stimulus class, a clocking-block interface, a reference model that checks every cycle, and functional coverage.

## How it works

The counter has three behaviors, in priority order:

1. `rst` high: `q` is cleared to `0` immediately, without waiting for a clock edge.
2. `load` high on a rising clock edge: `q` takes the value of `data_in`.
3. Otherwise, `q` increments by 1 on a rising clock edge, wrapping from `15` to `0`.

## Module hierarchy

| Module | Description |
|---|---|
| `counter_4bit_cdv` | The design under test. |
| `tb_counter_4bit_cdv` | Top-level testbench. Generates the clock, drives the DUT, runs the reference model check, and reports results. |
| `counter_if` | Interface bundling the DUT signals, with a clocking block for the testbench to drive and sample through. |
| `randomizer` | Class holding the random stimulus (`rst`, `load`, `data_in`), its constraints, and the covergroup. |

## Ports

| Port | Dir | Width | Description |
|---|---|---|---|
| `clk` | in | 1 | Clock, rising-edge triggered |
| `rst` | in | 1 | Asynchronous reset, active high |
| `load` | in | 1 | Synchronous load enable, active high |
| `data_in` | in | 4 | Value loaded into `q` when `load` is high |
| `q` | out | 4 | Current count (wraps modulo 16) |

## Testbench

`tb_counter_4bit_cdv.sv` is a constrained-random, self-checking testbench:

- 10 ns clock period (`timescale 1ns/1ps`).
- Holds `rst` high for the first 15 ns, then releases it.
- Runs 250 randomized cycles. Each cycle randomizes `rst`, `load` and `data_in`, drives them through the clocking block, waits for the next clock edge, then samples coverage, prints the cycle, and checks the output.
- The clocking block uses a 1 ns input and output skew.
- A reference model (`qn`) is updated with the same priority as the RTL (reset, then load, then increment) and compared with `q` in the `check` task. Mismatches are counted in `error_count`.
- Dumps waveforms to `dump.vcd`.

### Constraints

| Signal | Distribution |
|---|---|
| `load` | 80% high, 20% low |
| `rst` | 10% high, 90% low |

`data_in` is fully random over 0 to 15.

### Coverage

The `counter_cg` covergroup is sampled once per cycle.

| Item | What it covers |
|---|---|
| `cp_data_in` | Bins for `0`, `15`, and `1` to `14` |
| `cp_load` | `load` high and low |
| `cp_rst` | `rst` high and low |
| `X_data_in_load` | Cross of `data_in` and `load` |
| `X_data_in_rst` | Cross of `data_in` and `rst`, with `rst` low ignored |
| `x_all` | Cross of all three, with `rst` low and `load` low together ignored (that case is plain increment) |

Combinations such as `rst` high with `load` low and `data_in` at `0` or `15` are rare under these constraints, so coverage may finish below 100% in 250 cycles.

### Expected output

The stimulus is random, so there is no fixed table of values. Each cycle prints two lines:

```
[TB_CYCLE] Input: rst=<r>, load=<l>, data_in=<d> | Output: q=<q>
[SUCCESS] Time: <t> | Matched expected: <n>
```

A mismatch prints `[ERROR]` with the expected and actual values instead of `[SUCCESS]`. After all cycles, the run ends with:

- `Final function coverage: <percent>`
- `All tests passed successfully!` if there were no mismatches, otherwise `simulation failed! Encountered <n> errors.`

## Running the simulation

Requires a ModelSim/Questa installation with `vlib`, `vmap`, `vlog` and `vsim` on your `PATH`, and Python 3.

From this directory, execute the command:

```
python run.py
```

## Files

| File | Purpose |
|---|---|
| `4bit_counter_cdv.sv` | RTL: 4-bit counter with reset and load |
| `tb_counter_4bit_cdv.sv` | Constrained-random testbench with coverage |
| `run.py` | Compile and simulate script |
| `README.md` | Project details |
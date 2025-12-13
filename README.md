# ice40-vga-controller

A custom FPGA-based VGA video controller implemented from first principles, spanning digital logic design, SystemVerilog RTL simulation, and a complete 4-layer PCB implementation targeting the Lattice iCE40 FPGA family.

---

## Overview

This project implements a minimal VGA video controller capable of generating valid VGA timing signals and RGB pixel data without relying on vendor-provided IP cores. The design is structured to reflect a realistic hardware development flow, progressing from logic validation to RTL design and finally to a manufacturable PCB layout.

The focus of the project is on **signal correctness, modular design, and hardware-aware implementation**, rather than software abstraction.

---

## Design Architecture

The VGA controller is composed of three major functional layers:

### 1. VGA Timing Generation
- Horizontal and vertical counters generate standard VGA timing
- HSYNC and VSYNC signals follow VGA polarity and pulse width requirements
- Active video region detection is derived directly from counter values

### 2. Pixel Generation
- RGB pixel values are generated based on current pixel coordinates
- A simple scrolling color-bar pattern is implemented
- Color depth is 4 bits per channel (RGB444)

### 3. Hardware Output
- Digital RGB signals are converted to analog VGA levels using a resistor ladder DAC
- VGA DE-15 connector provides standard monitor interface
- FPGA I/O banks are powered from a 3.3 V rail with proper decoupling

---

## Implementation Flow

### Digital Logic Validation
The core VGA timing logic was first validated using logic-level simulation to confirm:
- Counter rollover behavior
- Sync pulse timing
- Active display window alignment

📂 Reference: [`digital/`](./digital)

---

### RTL Design and Simulation (SystemVerilog)

The design is implemented in SystemVerilog and organized into modular components:

- `vga_timing.sv`  
  Generates VGA timing signals and pixel counters

- `vga_pixel_gen.sv`  
  Produces RGB pixel values based on pixel position

- `vga_timing_tb.sv`  
  Testbench providing clock generation and waveform-level verification

Simulation verifies:
- HSYNC / VSYNC timing
- Active video region
- RGB output behavior over time

📂 Reference: [`systemverilog/`](./systemverilog)

---

### PCB Design (KiCad)

A complete **4-layer PCB** was designed to host the VGA controller:

**Layer stackup**
- Top layer: Signal routing
- Inner layer 1: Solid ground plane
- Inner layer 2: Power planes (3.3 V, FPGA core voltage)
- Bottom layer: Signal routing

**Key hardware features**
- Lattice iCE40 FPGA (TQFP package)
- Dedicated power planes for core and I/O voltages
- Local decoupling for all FPGA power pins
- VGA resistor ladder DAC placed close to FPGA outputs
- Fully routed and DRC-clean layout

📂 Reference: [`kicad/`](./kicad)

---

## 3D PCB View

> *(Insert KiCad 3D render image here)*

The 3D view illustrates final component placement, connector orientation, and overall board form factor.

---

## Repository Structure


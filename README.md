# ice40-vga-controller

A custom FPGA-based VGA controller designed for **640×480 @ 60 Hz**, implementing VGA timing generation, pixel logic and a **4-layer PCB** using the **Lattice iCE40HX1K** FPGA.

---

## Overview

This project implements a minimal yet fully functional VGA video controller without using vendor IP cores. The design follows a complete hardware development flow, starting from logic validation and RTL simulation to a manufacturable multilayer PCB.

The controller generates standard VGA sync signals and RGB video output compatible with conventional VGA displays.

---

## Architecture

The system is divided into three main functional blocks:

### VGA Timing Generation

* Horizontal and vertical pixel counters
* HSYNC and VSYNC pulse generation
* Active video region detection based on VGA timing parameters

### Pixel Generation

* RGB pixel values derived from current pixel coordinates
* Simple scrolling color-bar test pattern
* 4-bit color depth per RGB channel

### Hardware Output

* Digital RGB converted to analog VGA levels using a resistor ladder DAC
* Standard DE-15 VGA connector interface
* FPGA I/O powered at 3.3 V with proper decoupling

---

## Implementation Flow

### Logic Validation

Initial VGA timing was verified using Digital simulation software to confirm counter behavior, sync pulse timing and active display window alignment.

Reference: [`Digital`](./digital)

### RTL Design and Simulation

The design is implemented in SystemVerilog using a modular structure:

* [`vga_timing.sv`](./systemverilog/rtl/vga_timing.sv) – VGA timing and sync generation
* [`vga_pixel_gen.sv`](./systemverilog/rtl/vga_pixel_gen.sv) – RGB pixel generation
* [`vga_timing_tb.sv`](./systemverilog/rtl/vga_timing_tb.sv) – Testbench for waveform-level verification

References:

* RTL: [`RTL`](./systemverilog/rtl)
* Simulation: [`Simulation & Waveform`](./systemverilog/sim)

### PCB Design

A complete 4-layer PCB was designed in KiCad to host the VGA controller.

Layer stackup:

* Top: Signal routing
* Inner 1: Ground plane
* Inner 2: Power planes
* Bottom: Signal routing

Key hardware features:

* Lattice iCE40HX1K FPGA
* Dedicated core and I/O power planes
* Local decoupling on all power pins
* VGA DAC placed close to FPGA outputs

References:

* Schematic:  [`Schematic`](./kicad/schematic)
* PCB: [`PCB`](./kicad/pcb)
* Gerbers: [`Gerber`](./kicad/gerber)

---

## 3D PCB View

<p align="center">
  <img src="https://github.com/user-attachments/assets/25bc57f5-51db-4a89-864a-cd8d1c167256" width="800">
</p>

---

### Folder Structure

ice40-vga-controller/
├── digital/                                   # Timing validation using Digital simulation tool
├── systemverilog/
│ ├── rtl/                                     # SystemVerilog RTL modules
│ └── sim/                                     # Testbench and simulation files
├── kicad/
│ ├── schematic/                               # Circuit schematics
│ ├── pcb/                                     # PCB layout files
│ └── gerber/                                  # Manufacturing Gerber files
└── README.md



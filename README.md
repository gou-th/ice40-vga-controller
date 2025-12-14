# ice40-vga-controller

A custom FPGA-based VGA video controller implemented at a resolution of 640x480 @ 60Hz, spanning digital logic design, SystemVerilog RTL simulation and a complete 4-layer PCB implementation of iCE40HX1K.

---

## Overview

This project implements a minimal VGA video controller capable of generating valid VGA timing signals and RGB pixel data at a resolution of 640x480 @ 60Hz without relying on IP cores. The design is structured to reflect a realistic hardware development flow, progressing from logic validation to RTL design and finally to a manufacturable PCB layout.

---

## Design Architecture

THhe project is composed of three major functional layers:

### 1. VGA Timing Generation
- Horizontal and vertical counters generate standard VGA timing
- HSYNC and VSYNC signals follow VGA polarity and pulse width requirements
- Active video region detection is derived directly from counter values

### 2. Pixel Generation
- RGB pixel values are generated based on current pixel coordinates
- A simple scrolling color-bar pattern is implemented
- Color depth is 4 bits per channel

### 3. Hardware Output
- Digital RGB signals are converted to analog VGA levels using a resistor ladder DAC
- VGA DE-15 connector provides standard monitor interface
- FPGA I/O banks are powered from a 3.3 V rail with proper decoupling

---

## Implementation Flow

### Digital Logic
VGA timing logic was first validated using Digital (simulation software) to confirm:
- Counter rollover behavior
- Sync pulse timing
- Active display window alignment

Reference: [`Digital`](./digital)

---

### RTL Design and Simulation (SystemVerilog)

The design is implemented in SystemVerilog and organized into modular components:

- `vga_timing.sv`  
  Generates VGA timing signals and pixel counters

- `vga_pixel_gen.sv`  
  Produces RGB pixel values based on pixel position

- `vga_timing_tb.sv`  
  Testbench providing clock generation and waveform-level verification

Reference: 
- RTL: [`RTL`](./systemverilog/rtl)
- Simulation: [`Simulation & Waveform`](./systemverilog/sim)

---

### PCB Design (KiCad)

A complete **4-layer PCB** was designed to host the VGA controller using iCE40HX1K

**Layer stackup**
- Top layer: Signal routing
- Inner layer 1: Solid ground plane
- Inner layer 2: Power planes
- Bottom layer: Signal routing

**Key hardware features**
- Lattice iCE40HX1K FPGA
- Dedicated power planes for core and I/O voltages
- Local decoupling for all FPGA power pins
- VGA resistor ladder DAC placed close to FPGA outputs

Reference: 
- Schematic: [`Schematic`](./kicad/schematic)
- PCB routing: [`PCB`](./kicad/pcb)
- Gerber files: [`Gerber`](./kicad/gerber)

---

## 3D PCB View

<img width="3198" height="1806" alt="vga_3d_1" src="https://github.com/user-attachments/assets/25bc57f5-51db-4a89-864a-cd8d1c167256" />


<img width="3198" height="1806" alt="vga_3d_2" src="https://github.com/user-attachments/assets/0022020d-13de-41d6-8f03-79892f518bf2" />


<img width="3198" height="1806" alt="vga_3d_back" src="https://github.com/user-attachments/assets/082bd2ed-8aa0-4956-9452-a7c5eca5b33d" />



The 3D view shows the final component placement, orientation and final form factor. Main focus was to make the board as compact as possible.



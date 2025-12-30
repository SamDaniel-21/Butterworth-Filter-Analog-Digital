# Butterworth Filter Design: Analog and Digital Realisation

This repository presents the complete design, implementation, and verification of a Butterworth low-pass filter, realised in both the analog and digital domains.

## Objective
To design a Butterworth filter from given frequency specifications and realise it using:
- Analog-domain circuit simulation
- Digital-domain IIR filter implementation
- Fixed-point RTL design

## Design Flow
1. Specification-driven Butterworth filter design
2. Analog transfer function derivation and pole analysis
3. Analog verification using LTspice
4. Digital conversion using bilinear transformation with pre-warping
5. MATLAB-based frequency and stability analysis
6. Fixed-point coefficient quantisation (Q2.14)
7. RTL implementation using cascaded second-order sections (SOS)
8. Testbench-based verification with CSV file logging
9. MATLAB comparison using logged simulation data

## Tools Used
- MATLAB – filter design and verification
- LTspice – analog circuit simulation
- Verilog HDL – RTL implementation
- CSV-based logging – waveform validation

## Repository Structure
- `matlab/` – design and verification scripts
- `verilog/` – RTL and testbench
- `ltspice/` – analog simulation files
- `simulation_data/` – logged simulation outputs
- `docs/` – supporting notes (optional)

## Author
Sam Daniel A
B.Tech – Electronics Engineering (VLSI Design and Technology)
# iiitb_rtc-Real Time Clock
This is a real time clock provides time to the microcontroller.

### To clone the repository, download the netlist files and simulate the results, Enter the following commands in your terminal:
```
$ git clone https://github.com/Bandaanusha/iiitb_rtc
$ cd iiitb_rtc
$ iverilog -o iiitb_rtc_out.out iiitb_rtc.v  iiitb_rtc_tb.v
$ vvp iiitb_rtc_out.out
$ iverilog iiitb_rtc.v  iiitb_rtc_tb.v
$ gtkwave iiitb_rtc_out.vcd
```
### Simulation Waveforms
![iiitb_rtc_output_waveform](https://user-images.githubusercontent.com/62790565/181303117-9da92814-20e7-4b28-b0ac-55b03bb8a11e.PNG)

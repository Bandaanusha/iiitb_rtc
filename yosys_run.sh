# read design

read_verilog iiitb_rtc.v

# generic synthesis
synth -top iiitb_rtc

# mapping to mycells.lib
dfflibmap -liberty /home/anusha/iiitb_rtc/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/anusha/iiitb_rtc/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
clean
flatten
# write synthesized design
write_verilog -assert iiitb_rtc_synth.v

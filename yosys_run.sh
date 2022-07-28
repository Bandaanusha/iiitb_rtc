# read design

read_verilog iiitb_rtc.v

# generic synthesis
synth -top real_time_clock

# mapping to mycells.lib
dfflibmap -liberty /usr/local/share/qflow/tech/osu018/osu018_stdcells.lib
abc -liberty /usr/local/share/qflow/tech/osu018/osu018_stdcells.lib
clean
flatten
# write synthesized design
write_verilog -assert synth_real_time_clock.v

# read design

read_verilog iiitb_rtc.v

# generic synthesis
synth -top iiitb_rtc

# mapping to mycells.lib
dfflibmap -liberty /usr/local/share/qflow/tech/osu018/osu018_stdcells.lib
abc -liberty /usr/local/share/qflow/tech/osu018/osu018_stdcells.lib
clean
flatten
# write synthesized design
write_verilog -assert iiitb_rtc_synth.v

# iiitb_rtc-Real Time Clock

### Introduction
This is a real time clock, an integrated circuit, provides time to the microcontroller.It consists of oscillatory circuit, counter, register. Oscillatory circuit made of quartz crystal generates clock signal with high level of stability. Prescaler also called as frequency divider scales the clock producing a clock of frequency 1Hz. Counter using generated 1Hz clock signal counts the seconds and apparently minutes, hours. The time values are stored in a register. Real-time circuit is interfaced with microcontroller by Advanced Peripheral Bus following Advanced Microcontroller Bus Architecture (AMBA) bus protocol there by communicating time with microcontroller.  Real-time clock provides accurate time track to the device so all the events take place at the right time. This system functions reliably with optimum CPU and memory space usage.

### Block diagram

![rtcbd](https://user-images.githubusercontent.com/62790565/184196172-5bb0eee9-9785-4821-b242-71568a29f803.PNG)

### RTL Simulation
#### Installation of Icarus Verilog (iVerilog) and GTKwave on ubuntu
Open terminal and type the following commands to install iverilog and GTKwave.
```
$ sudo add-apt-repository ppa:team-electronics/ppa 
$ sudo apt-get update 
$ sudo apt-get install iverilog gtkwave
```

#### To clone the repository,simulate the results, Enter the following commands in your terminal :
```
$ git clone https://github.com/Bandaanusha/iiitb_rtc
$ cd iiitb_rtc
$ iverilog -o iiitb_rtc_out.out iiitb_rtc.v  iiitb_rtc_tb.v
$ vvp iiitb_rtc_out.out
$ iverilog iiitb_rtc.v  iiitb_rtc_tb.v
$ gtkwave iiitb_rtc_out.vcd
```

#### Simulation Waveforms

![presyn](https://user-images.githubusercontent.com/62790565/185417571-75588e39-bbb1-4bf9-929b-20d38ed4f25f.png)

### Synthesis
Synthesis transforms the simple RTL design into a gate-level netlist with all the constraints as specified by the designer. In simple language, Synthesis is a process that converts the abstract form of design to a properly implemented chip in terms of logic gates. Yosys is a framework for Verilog RTL synthesis.

#### Installation of yosys on Ubuntu
Open the terminal and type the following commands to install yosys
```
$ sudo apt-get install build-essential clang bison flex \ libreadline-dev gawk tcl-dev libffi-dev git \ graphviz xdot pkg-config python3 libboost-system-dev \ libboost-python-dev libboost-filesystem-dev zlib1g-dev
$ make
$ sudo make install
```

#### To synthesize the design, Enter the following commands in your terminal
```
> read_liberty -lib /home/anusha/iiitb_rtc/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
> read_verilog iiitb_rtc.v
> synth -top iiitb_rtc
> dfflibmap -liberty /home/anusha/iiitb_rtc/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
> abc -liberty /home/anusha/iiitb_rtc/lib/sky130_fd_sc_hd__tt_025C_1v80.lib -script +strash;scorr;ifraig;retime,{D};strash;dch,-f;map,-M,1,{
> write_verilog iiitb_rtc_netlist.v
```

### Gate Level Simulation
GLS is generating the simulation output by running test bench with netlist file generated from synthesis as design under test. Netlist is logically same as RTL code, therefore, same test bench can be used for it.

#### To Simulate results, Enter the following commands in your terminal
```
$ iverilog /home/anusha/iiitb_rtc/verilog_model/primitives.v /home/anusha/iiitb_rtc/verilog_model/sky130_fd_sc_hd.v iiitb_rtc_netlist.v iiitb_rtc_tb.v
$ ./a.out
$ gtkwave iiitb_rtc_out.vcd
```

### Simulation Waveforms
Pre - synthesis simulation waveform:

![presyn](https://user-images.githubusercontent.com/62790565/185417571-75588e39-bbb1-4bf9-929b-20d38ed4f25f.png)

Post - synthesis simulation waveform:

![postsyn](https://user-images.githubusercontent.com/62790565/185417781-3eed70b0-5d92-44cd-92e6-99133e8887e7.png)

### Physical Design
#### Tool Installation
##### Installation of Python3
```
$ sudo apt install -y build-essential python3 python3-venv python3-pip
```
##### Installation of Docker
```
$ sudo apt-get remove docker docker-engine docker.io containerd runc (removes older version of docker if installed)
$ sudo apt-get update
$ sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release    
$ sudo mkdir -p /etc/apt/keyrings
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
$ echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null  
$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
$ apt-cache madison docker-ce (copy the version string you want to install)
$ sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io docker-compose-plugin (paste the version string copies in place of <VERSION_STRING>)
$ sudo docker run hello-world (If the docker is successfully installed u will get a success message here)
```
##### Installation of OpenLane on ubuntu
```
$ git clone https://github.com/The-OpenROAD-Project/OpenLane.git
$ cd OpenLane/
$ make
$ make test
```
##### Installation of magic on ubuntu
Additional packages to be installed as a part of system requirements to compile magic before magic installation.<br>
###### Installing M4 preprocessor
```
sudo apt-get install m4
```
###### Installing tcsh shell
```
$ sudo apt-get install tcsh
```
###### Installing csh shell
```
$ sudo apt-get install csh 
```
###### Installing Xlib.h
```
$ sudo apt-get install libx11-dev
```
###### Installing Tcl/Tk
```
$ sudo apt-get install tcl-dev tk-dev
```
###### Imstalling Cairo
```
$ sudo apt-get install libcairo2-dev
```
###### Installing OpenGL
```
$ sudo apt-get install mesa-common-dev libglu1-mesa-dev
```
###### Installing ncurses
```
$ sudo apt-get install libncurses-dev
```
###### Installing Magic
```
$ git clone https://github.com/RTimothyEdwards/magic
$ cd magic
$ ./configure
$ make
$ make install
```
##### Installing Klayout
```
$ sudo apt-get install klayout
```
#### Execution
```
$ cd OpenLane
$ cd designs
$ mkdir iiitb_rtc
$ mkdir src
$ cd src 
$ touch iiitb_rtc.v
$ cd ../
$ touch config.json
Creating Standard cell Layout and converting magic layout to standard cell lef and include new cell lef and library files to design
```
$ cd OpenLane
$ git clone https://github.com/nickson-jose/vsdstdcelldesign
$ cd vsdstdcelldesign
$ magic -T sky130A.tech sky130_inv.mag & 
```
sky130_inv Layout

![invmag](https://user-images.githubusercontent.com/62790565/187076922-0870f887-665d-4c0c-a8bb-4b9d8ad87e96.png)

Label and define ports

![portlabel](https://user-images.githubusercontent.com/62790565/187076851-4c7afd6d-07fe-4543-b95d-40d7a3f233d0.png)

![setports](https://user-images.githubusercontent.com/62790565/187076879-ab61b00e-6324-490a-91bf-65079918e676.png)

#### Final Layout
![Screenshot from 2022-08-25 15-09-40](https://user-images.githubusercontent.com/62790565/186632010-3d560626-15c9-40d9-8df4-679b5db0388e.png)

## Contributors
- Banda Anusha
- Kunal Ghosh

## Acknowledgements
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
- Dantu Nandini Devi, Postgraduate Student, International Institute of Information Technology, Bangalore.
- 
## Contact Information
- Banda Anusha, Postgraduate Student, International Institute of Information Technology, Bangalore Banda.Anusha@iiitb.ac.in
- Dantu Nandini Devi, Postgraduate Student, International Institute of Information Technology, Bangalore nandini.dantu@gmail.com
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com

## References
- Real-Time Clocks (RTCC) ,Microchip technology,  https://www.microchip.com/en-us/products/clock-and-timing/components/real-time-clocks.
- RTC Verilog Code - Elecdude, www.elecdude.com.


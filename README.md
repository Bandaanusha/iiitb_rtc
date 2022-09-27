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

#### Simulation Waveforms
Pre - synthesis simulation waveform:

![presyn](https://user-images.githubusercontent.com/62790565/185417571-75588e39-bbb1-4bf9-929b-20d38ed4f25f.png)

Post - synthesis simulation waveform:

![postsyn](https://user-images.githubusercontent.com/62790565/185417781-3eed70b0-5d92-44cd-92e6-99133e8887e7.png)

### Layout
#### OpenLane and Magic Tool Installation
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
$ sudo apt-get install m4
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
###### Installing Cairo
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
#### Design Preparation
Creating iiitb_rtc design file in openlane directory
```
$ cd OpenLane
$ cd designs
$ mkdir iiitb_rtc
$ mkdir src
$ cd src 
$ touch iiitb_rtc.v
$ cd ../
$ touch config.json
```

<b>Config.json File</b>
```
{
    "DESIGN_NAME": "iiitb_rtc",
    "VERILOG_FILES": "dir::src/iiitb_rtc.v",
    "CLOCK_PORT": "clkin",
    "CLOCK_NET": "clkin",
    "GLB_RESIZER_TIMING_OPTIMIZATIONS": true,
    "CLOCK_PERIOD": 10,
    "PL_TARGET_DENSITY": 0.7,
    "FP_SIZING" : "relative",
"LIB_SYNTH": "dir::src/sky130_fd_sc_hd__typical.lib",
"LIB_FASTEST": "dir::src/sky130_fd_sc_hd__fast.lib",
"LIB_SLOWEST": "dir::src/sky130_fd_sc_hd__slow.lib",
"LIB_TYPICAL": "dir::src/sky130_fd_sc_hd__typical.lib",  
"TEST_EXTERNAL_GLOB": "dir::../iiitb_rtc/src/*",
"SYNTH_DRIVING_CELL":"sky130_vsdinv",
    "pdk::sky130*": {
        "FP_CORE_UTIL": 30,
        "scl::sky130_fd_sc_hd": {
            "FP_CORE_UTIL": 20
        }
    }
   
}
```

Including sky130_vsdinv cell to the design
```
$ cd OpenLane
$ cd vsdstdcelldesign
$ cp sky130_vsdinv.lef /home/anusha/OpenLane/designs/iiitb_rtc/src
$ cd libs
$ cp sky130_fd_sc_hd__* /home/anusha/OpenLane/designs/iiitb_rtc/src
```
Invoking openlane tcl console
```
$ cd OpenLane
$ ./flow.tcl -interactive
```
In tcl console commnd to load openlane package
```
% package require openlane 0.9
```
Preparing design
```
% prep -design iiitb_rtc
``` 
The following commands are to merge external the lef files to the merged.nom.lef. In our case sky130_vsdinv is getting merged to the lef file
```
% set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
% add_lefs -src $lefs
```

#### Synthesis
Type the command on tickle after preparing design to synthesize design
```
% run_synthesis
```

![syncom](https://user-images.githubusercontent.com/62790565/187274902-3ba5a0a7-893e-4d47-adf9-56ecad53328e.png)

##### Synthesis Reports
<b>Statistics</b>

![statex](https://user-images.githubusercontent.com/62790565/192561956-e25ef64c-b9de-4ca6-8f91-30149db280f4.png)

Slack

![slack](https://user-images.githubusercontent.com/62790565/187275299-de39ba00-ef9c-40fa-89b0-376cc530eb35.png)

#### Floorplan
Command to run the floorplan
```
% run_floorplan
```

##### Floorplan Results
Command to view floorplan on magic
```
magic -T /home/anusha/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read iiitb_rtc.def
```
![flopco](https://user-images.githubusercontent.com/62790565/187276193-6dc21eff-6678-49dc-bc29-68607016a92b.png)

<b>Floorplan</b>

![floorplan](https://user-images.githubusercontent.com/62790565/187277542-efa1a902-77ce-448f-b609-9af603e54a8a.png)

![fpsky](https://user-images.githubusercontent.com/62790565/187277757-9cb43a1b-9e54-4deb-a073-868746971c5d.png)

##### Floorplan Reports
Core area

![fpca](https://user-images.githubusercontent.com/62790565/187275874-930b4c49-3dc4-4675-aea3-d90717e15ae8.png)

Die area

![fpda](https://user-images.githubusercontent.com/62790565/187275930-36b7c347-15a1-4671-b87e-4cdd3192fe03.png)

#### Placement
Command to run placement
```
% run_placement
```
##### Placement results
Command to view placement on magic
```
magic -T /home/anusha/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read iiitb_rtc.def
```
![placco](https://user-images.githubusercontent.com/62790565/187278366-76570ba9-1f95-4d9c-b92e-73b9931ac535.png)

<b>Placement</b>

![placement](https://user-images.githubusercontent.com/62790565/187278493-bf9799ec-0acd-4a74-85bb-fd90dd11d1d7.png)

<b>Placement of sky130_vsdinv cell</b>

![skyinvplac](https://user-images.githubusercontent.com/62790565/187278840-735dab7d-d975-4a7b-abd9-b45e8296db3b.png)

#### Clock-tree synthesis
Command to run clock-tree synthesis
```
run_cts
```
![ctsco](https://user-images.githubusercontent.com/62790565/187279140-583eedf4-70fa-45aa-8064-9837fa8e3d75.png)

#### Routing
Command to run routing
```
run_routing
```

![routingco](https://user-images.githubusercontent.com/62790565/187279411-d2b72951-6b70-43d0-8111-18379465004e.png)

##### Routing results

![routing](https://user-images.githubusercontent.com/62790565/187279891-4eaf0fcc-238e-44ca-9b87-3fe8333a8ba4.png)

![routingzoomed](https://user-images.githubusercontent.com/62790565/187279974-323b1b38-f4db-403e-84b9-465524f7133c.png)

Routing of sky130_vsdinv cell

![skyinvrouting](https://user-images.githubusercontent.com/62790565/187422212-b7edf108-50a8-4677-9062-d3177ce5aeb8.png)

#### Final Layout

![layout](https://user-images.githubusercontent.com/62790565/187280262-78517f4e-eae2-4bc0-a9e1-6fccaf9a977b.png)

## Area, Power and Performance results
### Post Synthesis statistics

![statflop](https://user-images.githubusercontent.com/62790565/192592334-30eaa4e1-f2fd-4dc5-bc0f-55c1bfd9613f.png)

```
Gate Count = 133
Flop Ratio = Ratio of total number of flip flops / Total number of cells present in the design = 24/133 = 0.1804
```

### Area

![area](https://user-images.githubusercontent.com/62790565/192561503-8d60e87f-c426-4b3a-9425-e1ecccd5bddc.png)

```
Area = 9941.292 um2

```

### Power

![power](https://user-images.githubusercontent.com/62790565/192561805-b07c0648-5c65-44ef-aa70-6214b7f78eb6.png)

```
Internal Power = 169 uW (73.8%)
Switching Power = 601 uW (26.2%)
Leakage Power = 0.934 nW (0.0%)
Total Power = 229 uW (100%)
```

### Performance

![sta](https://user-images.githubusercontent.com/62790565/192586476-57db3c3d-0747-4d1c-95e3-85ede6f46309.png)

```
Performance = 1/(clock period - slack) = 1/(10 - 2.71)ns = 137.17 Mhz 
```

## Contributors
- Banda Anusha
- Kunal Ghosh
- Madhav Rao, Professor
- Nanditha Rao, Professor


## Acknowledgements
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
- Madhav Rao, Professor, IIITB 
- Nanditha Rao, Professor, IIITB 

## Contact Information
- Banda Anusha, Postgraduate Student, International Institute of Information Technology, Bangalore Banda.Anusha@iiitb.ac.in
- Dantu Nandini Devi, Postgraduate Student, International Institute of Information Technology, Bangalore nandini.dantu@gmail.com
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com
- Nanditha Rao, nanditha.rao@iiitb.ac.in
- Madhav Rao, mr@iiitb.ac.in

## References
- Real-Time Clocks (RTCC) ,Microchip technology,  https://www.microchip.com/en-us/products/clock-and-timing/components/real-time-clocks.
- RTC Verilog Code - Elecdude, www.elecdude.com.

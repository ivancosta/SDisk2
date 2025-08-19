# SDisk2
SD card interface for Apple 2 computers

# My changes to the original

- Added headers to program the Atmega chip of the SDiskII directly on the board using an Arduino. Of course, you can also remove the chip and program it with an EPROM programmer.

- Created a Makefile that can compile the code for the OLED, Nokia, and LCD display versions. The beauty of the project is that you can use whichever display is available. The Makefile also uploads the .hex to the chip.

- Fixed compilation errors.

- Optimized a few parts of the C code — see below.

- -O1 flag in avr-gcc to optimize for speed instead of size. (-O2, which further optimizes the code, caused GCC errors in the compilers I tested).

- Added a reset button, so if the SDiskII freezes you don’t need to reboot the Apple II.

- Added an activity LED.

### Pins for programming the Atmega328p on the board using Arduino Uno as ISP:

| Arduino | Atmega    |
|---------|-----------|
| 13      |  19       |
| 12      |  18       |
| 11      |  17       |
| 10      |  1 (reset)|
| 5V      |  5V       |
| GND     |  GND      |


# Optimizations

In the original code, 8 comparisons are always performed, and there will be problems if the number of buffers is decreased or increased:
```c
if (((sectors[0]==sector)&&(tracks[0]==trk)) || ((sectors[1]==sector)&&(tracks[1]==trk)) ||
((sectors[2]==sector)&&(tracks[2]==trk)) || ((sectors[3]==sector)&&(tracks[3]==trk)) ||
((sectors[4]==sector)&&(tracks[4]==trk))
) writeBackSub();
```

With the modification below, in the best case only 2 comparisons are performed, with no risk of execution errors:

```c
for (int i = 0; i < BUF_NUM; i++) {
    if (sectors[i] == sector && tracks[i] == trk) {
        writeBackSub();
        break; // do once
    }
}
```
# To-do
Create a schematic that reflects these small modifications, and design a PCB layout suitable for home etching using the toner transfer + ferric chloride method.


# Authors
* (c) 2010 Koichi NISHIDA <tulip-house@msf.biglobe.ne.jp>
* (c) 2012 Victor Trucco
* (c) 2012 Fábio Belavenuto
* (c) 2015 Alexandre Suaide

# License
This work is released under the version 3 of the GNU General Public License.

'''NOTE:'''
The current legal status of this code is uncertain.

Fábio and Alexandre have published files with a header that references the version 3 of the GNU General Public License, but it is not clear yet what's the licensing chosen by the original author, Koichi Nishida.

This repository will be updated once the actual licensing info is clarified by the authors.

rem D:\programas standalone\avr_microchip\avr-device-packs\gcc\dev\atmega328p
rem -B "D:\programas standalone\avr_microchip\avr-device-packs\gcc\dev\atmega328p" -I "D:\programas standalone\avr_microchip\avr-device-packs\include"
rem -B "D:\programas standalone\avr_microchip\avr-device-packs\gcc\dev\atmega328p" -I "D:\programas standalone\avr_microchip\avr-device-packs\include"

rem para compilar tem que baixar o AVR-GCC toolchain + avr libc 
rem https://blog.zakkemble.net/avr-gcc-builds/
cls
avr-gcc -o "oled.o" "oled.c" -Wall -Os -Wno-deprecated-declarations -Wno-strict-aliasing -D__PROG_TYPES_COMPAT__ -D_SDISK_OLED_  -fpack-struct -fshort-enums -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=atmega328p -DF_CPU=25000000UL -MMD -MP -c 
avr-gcc -o "SPI_routines.o" "SPI_routines.c" -Wall -Os -Wno-deprecated-declarations -Wno-strict-aliasing -D__PROG_TYPES_COMPAT__ -D_SDISK_OLED_  -fpack-struct -fshort-enums -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=atmega328p -DF_CPU=25000000UL -MMD -MP -c 
avr-gcc -o "SD_routines.o" "SD_routines.c" -Wall -Os -Wno-deprecated-declarations -Wno-strict-aliasing -D__PROG_TYPES_COMPAT__ -D_SDISK_OLED_  -fpack-struct -fshort-enums -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=atmega328p -DF_CPU=25000000UL -MMD -MP -c 
avr-gcc -o "FAT32.o" "FAT32.c" -Wall -Os -Wno-deprecated-declarations -Wno-strict-aliasing -D__PROG_TYPES_COMPAT__ -D_SDISK_OLED_  -fpack-struct -fshort-enums -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=atmega328p -DF_CPU=25000000UL -MMD -MP -c 
avr-gcc -x assembler-with-cpp -mmcu=atmega328p -MMD -MP -D_SDISK_OLED_ -c -o "sub.o" "sub.S"
avr-gcc -o "main.o" "main.c" -Wall -Os -Wno-deprecated-declarations -Wno-strict-aliasing -D__PROG_TYPES_COMPAT__ -D_SDISK_OLED_ -fpack-struct -fshort-enums -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=atmega328p -DF_CPU=25000000UL -MMD -MP -c 
avr-gcc -Wl,-Map,sdisk2_oled.map -mmcu=atmega328p -D_SDISK_OLED_ -o "sdisk2_oled.elf" "main.o" "oled.o" "SPI_routines.o" "SD_routines.o" "FAT32.o" "sub.o"  
avr-objcopy -R .eeprom -O ihex "sdisk2_oled.elf" "sdisk2_oled.hex"

rem "substituido pelo avr-objdump" avr-size --format=avr --mcu=atmega328p "sdisk2_oled.elf"
avr-objdump -Pmem-usage "sdisk2_oled.elf"
rem del *.o
rem del *.map
rem del *.d
rem del *.elf
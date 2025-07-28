# set te path to the AVR-GCC toolchain before calling make 

MCU = atmega328p
F_CPU = 27000000UL

# Default values, will be overridden per target
SRC_DIR = src
BUILD_DIR = build
SRCS = main.c SPI_routines.c SD_routines.c FAT32.c sub.S

# Default values, will be overridden per target
DISPLAY = _SDISK_OLED_
BINARY = sdisk2_oled
SRCS += oled.c # add OLED source file 

ifeq ($(MAKECMDGOALS),lcd)
  DISPLAY = _LCD_
  BINARY = sdisk2_lcd
  SRCS += lcd.c # add LCD source file
endif
ifeq ($(MAKECMDGOALS),nokia)
  DISPLAY = _LCD_NOKIA_
  BINARY = sdisk2_nokia
  SRCS += nokia.c # add NOKIA source file
endif

# Generate object file list in build dir
OBJS = $(addprefix $(BUILD_DIR)/, $(SRCS:.c=.o))
OBJS := $(OBJS:.S=.o) # handle .S files

CFLAGS = -Wall -O1 -Wno-deprecated-declarations -Wno-strict-aliasing -D__PROG_TYPES_COMPAT__ -D$(DISPLAY) \
	-fpack-struct -fshort-enums -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=$(MCU) -DF_CPU=$(F_CPU) -MMD -MP 
ASFLAGS = -x assembler-with-cpp -mmcu=$(MCU) -MMD -MP -D$(DISPLAY) -I$(SRC_DIR)

all: oled lcd nokia

oled: hex
lcd: hex
nokia: hex

# Pattern rules for object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	avr-gcc -o $@ $< $(CFLAGS) -c

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.S | $(BUILD_DIR)
	avr-gcc $(ASFLAGS) -c -o $@ $<

# Ensure build directory exists
$(BUILD_DIR):
	mkdir $(BUILD_DIR) 

elf: $(OBJS)
	avr-gcc -Wl,-Map,$(BUILD_DIR)/$(BINARY).map -mmcu=$(MCU) -o $(BUILD_DIR)/$@ $(OBJS)

hex: elf
	avr-objcopy -j .text -j .data -O ihex $(BUILD_DIR)/elf $(BUILD_DIR)/$(BINARY).hex
	avr-objdump -Pmem-usage $(BUILD_DIR)/elf

upload:
	@echo "Use: make upload oled | lcd | nokia ; default is oled"
	avrdude -v -pm328p -cstk500v1 -PCOM8 -b19200 -Uflash:w:$(BUILD_DIR)/$(BINARY).hex:i

clean:
	del /Q $(BUILD_DIR)\* || rm -rf $(BUILD_DIR)

.PHONY: all clean oled lcd nokia
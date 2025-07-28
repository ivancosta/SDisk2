rem para compilar tem que baixar o AVR-GCC toolchain + avr libc 
rem https://blog.zakkemble.net/avr-gcc-builds/

set TOOLS_DIR=D:\programas standalone\avr-gcc-14.1.0-x64-windows
set Path=%Path%;%TOOLS_DIR%\bin
set Path=%Path%;%TOOLS_DIR%\avr\bin
start cmd

rem powershell
rem $env:Path += ";D:\programas standalone\avr-gcc-14.1.0-x64-windows\bin;D:\programas standalone\avr-gcc-14.1.0-x64-windows\avr\bin"
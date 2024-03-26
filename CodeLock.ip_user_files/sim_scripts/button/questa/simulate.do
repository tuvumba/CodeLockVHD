onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib button_opt

do {wave.do}

view wave
view structure
view signals

do {button.udo}

run -all

quit -force

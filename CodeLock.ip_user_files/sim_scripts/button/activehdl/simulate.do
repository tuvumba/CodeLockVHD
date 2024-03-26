onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+button -L xil_defaultlib -L secureip -O5 xil_defaultlib.button

do {wave.do}

view wave
view structure

do {button.udo}

run -all

endsim

quit -force

vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vcom -work xil_defaultlib -64 -93 \
"../../../bd/button/ipshared/ba21/dff.vhd" \
"../../../bd/button/ip/button_dff_0_0/sim/button_dff_0_0.vhd" \
"../../../bd/button/ipshared/8af0/inv.vhd" \
"../../../bd/button/ip/button_inv_0_0/sim/button_inv_0_0.vhd" \
"../../../bd/button/ipshared/2d02/and_gate.vhd" \
"../../../bd/button/ip/button_and_0_0/sim/button_and_0_0.vhd" \
"../../../bd/button/ipshared/609b/debounce.vhd" \
"../../../bd/button/ip/button_debounce_0_1/sim/button_debounce_0_1.vhd" \
"../../../bd/button/sim/button.vhd" \



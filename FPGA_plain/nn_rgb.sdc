# edupow_default.sdc
# 
# Timing constraints for EduPow-Board with 74.25 MHz 720p-signal
#
# FPGA Vision Remote Lab http://h-brs.de/fpga-vision-lab
# (c) Marco Winzker, Hochschule Bonn-Rhein-Sieg, 03.01.2018


# Clock constraints
create_clock -name input_clk -period 13.47ns [get_ports {clk}]
create_generated_clock -name output_clk -source [get_ports {clk}] -master_clock input_clk -add [get_ports {clk_o}]

# Define IO-paths
set_input_delay -clock input_clk -max 0.1 [get_ports {reset_n *_in*}]
set_output_delay -clock output_clk -max 0.1 [get_ports {*_out* led*}]

set_input_delay -add_delay -clock input_clk -fall -min 0.05 [get_ports {reset_n *_in*}]
set_output_delay -add_delay -clock output_clk -fall -min 0.05 [get_ports {*_out* led*}]

set_input_delay -add_delay -clock input_clk -rise -min 0.05 [get_ports {reset_n *_in*}]
set_output_delay -add_delay -clock output_clk -rise -min 0.05 [get_ports {*_out* led*}]

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty

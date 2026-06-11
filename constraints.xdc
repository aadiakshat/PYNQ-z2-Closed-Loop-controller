# System Clock (100 MHz)
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports sysclk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 4.000} -add [get_ports sysclk]

# Buttons
# Button 0 used for active-low reset via ~btn0
set_property -dict {PACKAGE_PIN D19 IOSTANDARD LVCMOS33} [get_ports btn0]

# Button 2 used for test mode override
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS33} [get_ports btn2]

# LEDs
set_property -dict {PACKAGE_PIN R14 IOSTANDARD LVCMOS33} [get_ports {led[0]}]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {led[1]}]
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports {led[2]}]
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {led[3]}]

# ==========================================
# PMODA Top Row
# ==========================================
# JA1 -> CS
set_property -dict {PACKAGE_PIN Y18 IOSTANDARD LVCMOS33} [get_ports pmoda_cs_n]
# JA2 -> MOSI
set_property -dict {PACKAGE_PIN Y19 IOSTANDARD LVCMOS33} [get_ports pmoda_mosi]
# JA3 -> MISO
set_property -dict {PACKAGE_PIN Y16 IOSTANDARD LVCMOS33} [get_ports pmoda_miso]
# JA4 -> SCLK
set_property -dict {PACKAGE_PIN Y17 IOSTANDARD LVCMOS33} [get_ports pmoda_sclk]

# ==========================================
# PMODB Interface (Pmod DA3 DACs)
# ==========================================
# DAC A (Top Row - PMODB Pins 1-4)
set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports pmodb_pin1]
set_property -dict {PACKAGE_PIN Y14 IOSTANDARD LVCMOS33} [get_ports pmodb_pin2]
set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports pmodb_pin3]
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports pmodb_pin4]

# DAC B (Bottom Row - PMODB Pins 7-10)
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports pmodb_pin7]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports pmodb_pin8]
set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports pmodb_pin9]
set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports pmodb_pin10]


# ==========================================
# ILA Debug Core
# ==========================================


connect_debug_port u_ila_0/probe13 [get_nets [list dbg_dac1_cs]]
connect_debug_port u_ila_0/probe14 [get_nets [list dbg_dac1_din]]
connect_debug_port u_ila_0/probe15 [get_nets [list dbg_dac1_ldac]]
connect_debug_port u_ila_0/probe16 [get_nets [list dbg_dac1_sclk]]


connect_debug_port u_ila_0/probe2 [get_nets [list {pid_inst/ex_q16[0]} {pid_inst/ex_q16[1]} {pid_inst/ex_q16[2]} {pid_inst/ex_q16[3]} {pid_inst/ex_q16[4]} {pid_inst/ex_q16[5]} {pid_inst/ex_q16[6]} {pid_inst/ex_q16[7]} {pid_inst/ex_q16[8]} {pid_inst/ex_q16[9]} {pid_inst/ex_q16[10]} {pid_inst/ex_q16[11]} {pid_inst/ex_q16[12]} {pid_inst/ex_q16[13]} {pid_inst/ex_q16[14]} {pid_inst/ex_q16[15]} {pid_inst/ex_q16[16]} {pid_inst/ex_q16[17]} {pid_inst/ex_q16[18]} {pid_inst/ex_q16[19]} {pid_inst/ex_q16[20]} {pid_inst/ex_q16[21]} {pid_inst/ex_q16[22]} {pid_inst/ex_q16[23]} {pid_inst/ex_q16[24]} {pid_inst/ex_q16[25]} {pid_inst/ex_q16[26]} {pid_inst/ex_q16[27]} {pid_inst/ex_q16[28]} {pid_inst/ex_q16[29]} {pid_inst/ex_q16[30]} {pid_inst/ex_q16[31]}]]
connect_debug_port u_ila_0/probe3 [get_nets [list {pid_inst/ux_q16[0]} {pid_inst/ux_q16[1]} {pid_inst/ux_q16[2]} {pid_inst/ux_q16[3]} {pid_inst/ux_q16[4]} {pid_inst/ux_q16[5]} {pid_inst/ux_q16[6]} {pid_inst/ux_q16[7]} {pid_inst/ux_q16[8]} {pid_inst/ux_q16[9]} {pid_inst/ux_q16[10]} {pid_inst/ux_q16[11]} {pid_inst/ux_q16[12]} {pid_inst/ux_q16[13]} {pid_inst/ux_q16[14]} {pid_inst/ux_q16[15]} {pid_inst/ux_q16[16]} {pid_inst/ux_q16[17]} {pid_inst/ux_q16[18]} {pid_inst/ux_q16[19]} {pid_inst/ux_q16[20]} {pid_inst/ux_q16[21]} {pid_inst/ux_q16[22]} {pid_inst/ux_q16[23]} {pid_inst/ux_q16[24]} {pid_inst/ux_q16[25]} {pid_inst/ux_q16[26]} {pid_inst/ux_q16[27]} {pid_inst/ux_q16[28]} {pid_inst/ux_q16[29]} {pid_inst/ux_q16[30]} {pid_inst/ux_q16[31]} {pid_inst/ux_q16[32]} {pid_inst/ux_q16[33]} {pid_inst/ux_q16[34]} {pid_inst/ux_q16[35]} {pid_inst/ux_q16[36]} {pid_inst/ux_q16[37]} {pid_inst/ux_q16[38]} {pid_inst/ux_q16[39]} {pid_inst/ux_q16[40]} {pid_inst/ux_q16[41]} {pid_inst/ux_q16[42]} {pid_inst/ux_q16[43]} {pid_inst/ux_q16[44]} {pid_inst/ux_q16[45]} {pid_inst/ux_q16[46]} {pid_inst/ux_q16[47]}]]
connect_debug_port u_ila_0/probe4 [get_nets [list {pid_inst/ey_q16[0]} {pid_inst/ey_q16[1]} {pid_inst/ey_q16[2]} {pid_inst/ey_q16[3]} {pid_inst/ey_q16[4]} {pid_inst/ey_q16[5]} {pid_inst/ey_q16[6]} {pid_inst/ey_q16[7]} {pid_inst/ey_q16[8]} {pid_inst/ey_q16[9]} {pid_inst/ey_q16[10]} {pid_inst/ey_q16[11]} {pid_inst/ey_q16[12]} {pid_inst/ey_q16[13]} {pid_inst/ey_q16[14]} {pid_inst/ey_q16[15]} {pid_inst/ey_q16[16]} {pid_inst/ey_q16[17]} {pid_inst/ey_q16[18]} {pid_inst/ey_q16[19]} {pid_inst/ey_q16[20]} {pid_inst/ey_q16[21]} {pid_inst/ey_q16[22]} {pid_inst/ey_q16[23]} {pid_inst/ey_q16[24]} {pid_inst/ey_q16[25]} {pid_inst/ey_q16[26]} {pid_inst/ey_q16[27]} {pid_inst/ey_q16[28]} {pid_inst/ey_q16[29]} {pid_inst/ey_q16[30]} {pid_inst/ey_q16[31]}]]
connect_debug_port u_ila_0/probe8 [get_nets [list {pid_inst/vy_raw[0]} {pid_inst/vy_raw[1]} {pid_inst/vy_raw[2]} {pid_inst/vy_raw[3]} {pid_inst/vy_raw[4]} {pid_inst/vy_raw[5]} {pid_inst/vy_raw[6]} {pid_inst/vy_raw[7]} {pid_inst/vy_raw[8]} {pid_inst/vy_raw[9]} {pid_inst/vy_raw[10]} {pid_inst/vy_raw[11]} {pid_inst/vy_raw[12]} {pid_inst/vy_raw[13]} {pid_inst/vy_raw[14]} {pid_inst/vy_raw[15]} {pid_inst/vy_raw[16]} {pid_inst/vy_raw[17]} {pid_inst/vy_raw[18]} {pid_inst/vy_raw[19]} {pid_inst/vy_raw[20]} {pid_inst/vy_raw[21]} {pid_inst/vy_raw[22]} {pid_inst/vy_raw[23]} {pid_inst/vy_raw[24]}]]
connect_debug_port u_ila_0/probe9 [get_nets [list {dac_ctrl_b/dac_2_muxed[0]} {dac_ctrl_b/dac_2_muxed[1]} {dac_ctrl_b/dac_2_muxed[2]} {dac_ctrl_b/dac_2_muxed[3]} {dac_ctrl_b/dac_2_muxed[4]} {dac_ctrl_b/dac_2_muxed[5]} {dac_ctrl_b/dac_2_muxed[6]} {dac_ctrl_b/dac_2_muxed[7]} {dac_ctrl_b/dac_2_muxed[8]} {dac_ctrl_b/dac_2_muxed[9]} {dac_ctrl_b/dac_2_muxed[10]} {dac_ctrl_b/dac_2_muxed[11]} {dac_ctrl_b/dac_2_muxed[12]} {dac_ctrl_b/dac_2_muxed[13]} {dac_ctrl_b/dac_2_muxed[14]} {dac_ctrl_b/dac_2_muxed[15]}]]
connect_debug_port u_ila_0/probe10 [get_nets [list {dac_ctrl_a/dac_1_muxed[0]} {dac_ctrl_a/dac_1_muxed[1]} {dac_ctrl_a/dac_1_muxed[2]} {dac_ctrl_a/dac_1_muxed[3]} {dac_ctrl_a/dac_1_muxed[4]} {dac_ctrl_a/dac_1_muxed[5]} {dac_ctrl_a/dac_1_muxed[6]} {dac_ctrl_a/dac_1_muxed[7]} {dac_ctrl_a/dac_1_muxed[8]} {dac_ctrl_a/dac_1_muxed[9]} {dac_ctrl_a/dac_1_muxed[10]} {dac_ctrl_a/dac_1_muxed[11]} {dac_ctrl_a/dac_1_muxed[12]} {dac_ctrl_a/dac_1_muxed[13]} {dac_ctrl_a/dac_1_muxed[14]} {dac_ctrl_a/dac_1_muxed[15]}]]
connect_debug_port u_ila_0/probe11 [get_nets [list {pid_inst/vsum_raw[0]} {pid_inst/vsum_raw[1]} {pid_inst/vsum_raw[2]} {pid_inst/vsum_raw[3]} {pid_inst/vsum_raw[4]} {pid_inst/vsum_raw[5]} {pid_inst/vsum_raw[6]} {pid_inst/vsum_raw[7]} {pid_inst/vsum_raw[8]} {pid_inst/vsum_raw[9]} {pid_inst/vsum_raw[10]} {pid_inst/vsum_raw[11]} {pid_inst/vsum_raw[12]} {pid_inst/vsum_raw[13]} {pid_inst/vsum_raw[14]} {pid_inst/vsum_raw[15]} {pid_inst/vsum_raw[16]} {pid_inst/vsum_raw[17]} {pid_inst/vsum_raw[18]} {pid_inst/vsum_raw[19]} {pid_inst/vsum_raw[20]} {pid_inst/vsum_raw[21]} {pid_inst/vsum_raw[22]} {pid_inst/vsum_raw[23]} {pid_inst/vsum_raw[24]}]]
connect_debug_port u_ila_0/probe12 [get_nets [list {pid_inst/vx_raw[0]} {pid_inst/vx_raw[1]} {pid_inst/vx_raw[2]} {pid_inst/vx_raw[3]} {pid_inst/vx_raw[4]} {pid_inst/vx_raw[5]} {pid_inst/vx_raw[6]} {pid_inst/vx_raw[7]} {pid_inst/vx_raw[8]} {pid_inst/vx_raw[9]} {pid_inst/vx_raw[10]} {pid_inst/vx_raw[11]} {pid_inst/vx_raw[12]} {pid_inst/vx_raw[13]} {pid_inst/vx_raw[14]} {pid_inst/vx_raw[15]} {pid_inst/vx_raw[16]} {pid_inst/vx_raw[17]} {pid_inst/vx_raw[18]} {pid_inst/vx_raw[19]} {pid_inst/vx_raw[20]} {pid_inst/vx_raw[21]} {pid_inst/vx_raw[22]} {pid_inst/vx_raw[23]} {pid_inst/vx_raw[24]}]]
connect_debug_port u_ila_0/probe13 [get_nets [list {current_channel[0]} {current_channel[1]}]]
connect_debug_port u_ila_0/probe15 [get_nets [list {controller_state[0]} {controller_state[1]} {controller_state[2]} {controller_state[3]} {controller_state[4]}]]
connect_debug_port u_ila_0/probe16 [get_nets [list {dbg_bit_count[0]} {dbg_bit_count[1]} {dbg_bit_count[2]} {dbg_bit_count[3]} {dbg_bit_count[4]} {dbg_bit_count[5]}]]
connect_debug_port u_ila_0/probe17 [get_nets [list {dbg_shift_reg_tx[0]} {dbg_shift_reg_tx[1]} {dbg_shift_reg_tx[2]} {dbg_shift_reg_tx[3]} {dbg_shift_reg_tx[4]} {dbg_shift_reg_tx[5]} {dbg_shift_reg_tx[6]} {dbg_shift_reg_tx[7]} {dbg_shift_reg_tx[8]} {dbg_shift_reg_tx[9]} {dbg_shift_reg_tx[10]} {dbg_shift_reg_tx[11]} {dbg_shift_reg_tx[12]} {dbg_shift_reg_tx[13]} {dbg_shift_reg_tx[14]} {dbg_shift_reg_tx[15]} {dbg_shift_reg_tx[16]} {dbg_shift_reg_tx[17]} {dbg_shift_reg_tx[18]} {dbg_shift_reg_tx[19]} {dbg_shift_reg_tx[20]} {dbg_shift_reg_tx[21]} {dbg_shift_reg_tx[22]} {dbg_shift_reg_tx[23]} {dbg_shift_reg_tx[24]} {dbg_shift_reg_tx[25]} {dbg_shift_reg_tx[26]} {dbg_shift_reg_tx[27]} {dbg_shift_reg_tx[28]} {dbg_shift_reg_tx[29]} {dbg_shift_reg_tx[30]} {dbg_shift_reg_tx[31]} {dbg_shift_reg_tx[32]} {dbg_shift_reg_tx[33]} {dbg_shift_reg_tx[34]} {dbg_shift_reg_tx[35]} {dbg_shift_reg_tx[36]} {dbg_shift_reg_tx[37]} {dbg_shift_reg_tx[38]} {dbg_shift_reg_tx[39]} {dbg_shift_reg_tx[40]} {dbg_shift_reg_tx[41]} {dbg_shift_reg_tx[42]} {dbg_shift_reg_tx[43]} {dbg_shift_reg_tx[44]} {dbg_shift_reg_tx[45]} {dbg_shift_reg_tx[46]} {dbg_shift_reg_tx[47]}]]
connect_debug_port u_ila_0/probe18 [get_nets [list {dbg_shift_reg_rx[0]} {dbg_shift_reg_rx[1]} {dbg_shift_reg_rx[2]} {dbg_shift_reg_rx[3]} {dbg_shift_reg_rx[4]} {dbg_shift_reg_rx[5]} {dbg_shift_reg_rx[6]} {dbg_shift_reg_rx[7]} {dbg_shift_reg_rx[8]} {dbg_shift_reg_rx[9]} {dbg_shift_reg_rx[10]} {dbg_shift_reg_rx[11]} {dbg_shift_reg_rx[12]} {dbg_shift_reg_rx[13]} {dbg_shift_reg_rx[14]} {dbg_shift_reg_rx[15]} {dbg_shift_reg_rx[16]} {dbg_shift_reg_rx[17]} {dbg_shift_reg_rx[18]} {dbg_shift_reg_rx[19]} {dbg_shift_reg_rx[20]} {dbg_shift_reg_rx[21]} {dbg_shift_reg_rx[22]} {dbg_shift_reg_rx[23]} {dbg_shift_reg_rx[24]} {dbg_shift_reg_rx[25]} {dbg_shift_reg_rx[26]} {dbg_shift_reg_rx[27]} {dbg_shift_reg_rx[28]} {dbg_shift_reg_rx[29]} {dbg_shift_reg_rx[30]} {dbg_shift_reg_rx[31]} {dbg_shift_reg_rx[32]} {dbg_shift_reg_rx[33]} {dbg_shift_reg_rx[34]} {dbg_shift_reg_rx[35]} {dbg_shift_reg_rx[36]} {dbg_shift_reg_rx[37]} {dbg_shift_reg_rx[38]} {dbg_shift_reg_rx[39]} {dbg_shift_reg_rx[40]} {dbg_shift_reg_rx[41]} {dbg_shift_reg_rx[42]} {dbg_shift_reg_rx[43]} {dbg_shift_reg_rx[44]} {dbg_shift_reg_rx[45]} {dbg_shift_reg_rx[46]} {dbg_shift_reg_rx[47]}]]
connect_debug_port u_ila_0/probe22 [get_nets [list adc_ch1_valid]]
connect_debug_port u_ila_0/probe23 [get_nets [list adc_ch2_valid]]
connect_debug_port u_ila_0/probe26 [get_nets [list dbg_spi_clk]]
connect_debug_port u_ila_0/probe27 [get_nets [list dbg_spi_cs_n]]
connect_debug_port u_ila_0/probe28 [get_nets [list dbg_spi_miso]]
connect_debug_port u_ila_0/probe29 [get_nets [list dbg_spi_mosi]]
connect_debug_port u_ila_0/probe30 [get_nets [list pid_inst/sum_ok]]


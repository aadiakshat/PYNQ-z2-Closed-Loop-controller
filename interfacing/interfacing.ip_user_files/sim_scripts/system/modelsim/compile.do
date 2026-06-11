vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xilinx_vip
vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/axi_infrastructure_v1_1_0
vlib modelsim_lib/msim/axi_vip_v1_1_21
vlib modelsim_lib/msim/processing_system7_vip_v1_0_23
vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xlconstant_v1_1_10
vlib modelsim_lib/msim/proc_sys_reset_v5_0_17
vlib modelsim_lib/msim/smartconnect_v1_0
vlib modelsim_lib/msim/axi_register_slice_v2_1_35
vlib modelsim_lib/msim/axi_lite_ipif_v3_0_4
vlib modelsim_lib/msim/interrupt_control_v3_1_5
vlib modelsim_lib/msim/axi_gpio_v2_0_37

vmap xilinx_vip modelsim_lib/msim/xilinx_vip
vmap xpm modelsim_lib/msim/xpm
vmap axi_infrastructure_v1_1_0 modelsim_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_21 modelsim_lib/msim/axi_vip_v1_1_21
vmap processing_system7_vip_v1_0_23 modelsim_lib/msim/processing_system7_vip_v1_0_23
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xlconstant_v1_1_10 modelsim_lib/msim/xlconstant_v1_1_10
vmap proc_sys_reset_v5_0_17 modelsim_lib/msim/proc_sys_reset_v5_0_17
vmap smartconnect_v1_0 modelsim_lib/msim/smartconnect_v1_0
vmap axi_register_slice_v2_1_35 modelsim_lib/msim/axi_register_slice_v2_1_35
vmap axi_lite_ipif_v3_0_4 modelsim_lib/msim/axi_lite_ipif_v3_0_4
vmap interrupt_control_v3_1_5 modelsim_lib/msim/interrupt_control_v3_1_5
vmap axi_gpio_v2_0_37 modelsim_lib/msim/axi_gpio_v2_0_37

vlog -work xilinx_vip  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_if.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/clk_vip_if.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"C:/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"C:/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93  \
"C:/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -incr -mfcu  "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_21  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/f16f/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_23  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/system/ip/system_processing_system7_0_0/sim/system_processing_system7_0_0.v" \

vlog -work xlconstant_v1_1_10  -incr -mfcu  "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/a165/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_0/sim/bd_44e3_one_0.v" \

vcom -work proc_sys_reset_v5_0_17  -93  \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/9438/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93  \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_1/sim/bd_44e3_psr_aclk_0.vhd" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/sc_util_v1_0_vl_rfs.sv" \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/3718/hdl/sc_switchboard_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_2/sim/bd_44e3_arinsw_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_3/sim/bd_44e3_rinsw_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_4/sim/bd_44e3_awinsw_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_5/sim/bd_44e3_winsw_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_6/sim/bd_44e3_binsw_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_7/sim/bd_44e3_aroutsw_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_8/sim/bd_44e3_routsw_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_9/sim/bd_44e3_awoutsw_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_10/sim/bd_44e3_woutsw_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_11/sim/bd_44e3_boutsw_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/sc_node_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_12/sim/bd_44e3_arni_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_13/sim/bd_44e3_rni_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_14/sim/bd_44e3_awni_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_15/sim/bd_44e3_wni_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_16/sim/bd_44e3_bni_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/d800/hdl/sc_mmu_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_17/sim/bd_44e3_s00mmu_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/2da8/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_18/sim/bd_44e3_s00tr_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/dce3/hdl/sc_si_converter_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_19/sim/bd_44e3_s00sic_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/cef3/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_20/sim/bd_44e3_s00a2s_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_21/sim/bd_44e3_sarn_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_22/sim/bd_44e3_srn_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_23/sim/bd_44e3_sawn_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_24/sim/bd_44e3_swn_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_25/sim/bd_44e3_sbn_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/7f4f/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_26/sim/bd_44e3_m00s2a_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_27/sim/bd_44e3_m00arn_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_28/sim/bd_44e3_m00rn_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_29/sim/bd_44e3_m00awn_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_30/sim/bd_44e3_m00wn_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_31/sim/bd_44e3_m00bn_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/0133/hdl/sc_exit_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_32/sim/bd_44e3_m00e_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_33/sim/bd_44e3_m01s2a_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_34/sim/bd_44e3_m01arn_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_35/sim/bd_44e3_m01rn_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_36/sim/bd_44e3_m01awn_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_37/sim/bd_44e3_m01wn_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_38/sim/bd_44e3_m01bn_0.sv" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/ip/ip_39/sim/bd_44e3_m01e_0.sv" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/system/ip/system_axi_smc_0/bd_0/sim/bd_44e3.v" \

vlog -work axi_register_slice_v2_1_35  -incr -mfcu  "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/c5b7/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/system/ip/system_axi_smc_0/sim/system_axi_smc_0.sv" \

vcom -work xil_defaultlib  -93  \
"../../../bd/system/ip/system_rst_ps7_0_100M_0/sim/system_rst_ps7_0_100M_0.vhd" \

vcom -work axi_lite_ipif_v3_0_4  -93  \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work interrupt_control_v3_1_5  -93  \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/d8cc/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_37  -93  \
"../../../../interfacing.gen/sources_1/bd/system/ipshared/0271/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93  \
"../../../bd/system/ip/system_axi_gpio_0_1/sim/system_axi_gpio_0_1.vhd" \
"../../../bd/system/ip/system_axi_gpio_1_1/sim/system_axi_gpio_1_1.vhd" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/6cfa/hdl" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/f0b6/hdl/verilog" "+incdir+../../../../interfacing.gen/sources_1/bd/system/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/system/sim/system.v" \

vlog -work xil_defaultlib \
"glbl.v"


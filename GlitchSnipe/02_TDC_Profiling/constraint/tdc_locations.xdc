
# ---------------- TDC 0 ----------------
create_pblock pblock_SENSOR_0
resize_pblock [get_pblocks pblock_SENSOR_0] -add {SLICE_X0Y0:SLICE_X0Y24}
add_cells_to_pblock [get_pblocks pblock_SENSOR_0] [get_cells {TDC_UART_module/TDC_sensor_instances[0].TDC/*}]
set_property LOC SLICE_X0Y0 [get_cells {TDC_UART_module/TDC_sensor_instances[0].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[0].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_0]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[0].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 1 ----------------
create_pblock pblock_SENSOR_1
resize_pblock [get_pblocks pblock_SENSOR_1] -add {SLICE_X0Y25:SLICE_X0Y49}
add_cells_to_pblock [get_pblocks pblock_SENSOR_1] [get_cells {TDC_UART_module/TDC_sensor_instances[1].TDC/*}]
set_property LOC SLICE_X0Y25 [get_cells {TDC_UART_module/TDC_sensor_instances[1].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[1].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_1]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[1].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 2 ----------------
create_pblock pblock_SENSOR_2
resize_pblock [get_pblocks pblock_SENSOR_2] -add {SLICE_X0Y50:SLICE_X0Y74}
add_cells_to_pblock [get_pblocks pblock_SENSOR_2] [get_cells {TDC_UART_module/TDC_sensor_instances[2].TDC/*}]
set_property LOC SLICE_X0Y50 [get_cells {TDC_UART_module/TDC_sensor_instances[2].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[2].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_2]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[2].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 3 ----------------
create_pblock pblock_SENSOR_3
resize_pblock [get_pblocks pblock_SENSOR_3] -add {SLICE_X0Y75:SLICE_X0Y99}
add_cells_to_pblock [get_pblocks pblock_SENSOR_3] [get_cells {TDC_UART_module/TDC_sensor_instances[3].TDC/*}]
set_property LOC SLICE_X0Y75 [get_cells {TDC_UART_module/TDC_sensor_instances[3].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[3].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_3]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[3].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 4 ----------------
create_pblock pblock_SENSOR_4
resize_pblock [get_pblocks pblock_SENSOR_4] -add {SLICE_X0Y100:SLICE_X0Y124}
add_cells_to_pblock [get_pblocks pblock_SENSOR_4] [get_cells {TDC_UART_module/TDC_sensor_instances[4].TDC/*}]
set_property LOC SLICE_X0Y100 [get_cells {TDC_UART_module/TDC_sensor_instances[4].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[4].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_4]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[4].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 5 ----------------
create_pblock pblock_SENSOR_5
resize_pblock [get_pblocks pblock_SENSOR_5] -add {SLICE_X0Y125:SLICE_X0Y149}
add_cells_to_pblock [get_pblocks pblock_SENSOR_5] [get_cells {TDC_UART_module/TDC_sensor_instances[5].TDC/*}]
set_property LOC SLICE_X0Y125 [get_cells {TDC_UART_module/TDC_sensor_instances[5].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[5].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_5]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[5].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 6 ----------------
create_pblock pblock_SENSOR_6
resize_pblock [get_pblocks pblock_SENSOR_6] -add {SLICE_X4Y0:SLICE_X4Y24}
add_cells_to_pblock [get_pblocks pblock_SENSOR_6] [get_cells {TDC_UART_module/TDC_sensor_instances[6].TDC/*}]
set_property LOC SLICE_X4Y0 [get_cells {TDC_UART_module/TDC_sensor_instances[6].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[6].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_6]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[6].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 7 ----------------
create_pblock pblock_SENSOR_7
resize_pblock [get_pblocks pblock_SENSOR_7] -add {SLICE_X4Y25:SLICE_X4Y49}
add_cells_to_pblock [get_pblocks pblock_SENSOR_7] [get_cells {TDC_UART_module/TDC_sensor_instances[7].TDC/*}]
set_property LOC SLICE_X4Y25 [get_cells {TDC_UART_module/TDC_sensor_instances[7].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[7].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_7]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[7].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 8 ----------------
create_pblock pblock_SENSOR_8
resize_pblock [get_pblocks pblock_SENSOR_8] -add {SLICE_X4Y50:SLICE_X4Y74}
add_cells_to_pblock [get_pblocks pblock_SENSOR_8] [get_cells {TDC_UART_module/TDC_sensor_instances[8].TDC/*}]
set_property LOC SLICE_X4Y50 [get_cells {TDC_UART_module/TDC_sensor_instances[8].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[8].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_8]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[8].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 9 ----------------
create_pblock pblock_SENSOR_9
resize_pblock [get_pblocks pblock_SENSOR_9] -add {SLICE_X4Y75:SLICE_X4Y99}
add_cells_to_pblock [get_pblocks pblock_SENSOR_9] [get_cells {TDC_UART_module/TDC_sensor_instances[9].TDC/*}]
set_property LOC SLICE_X4Y75 [get_cells {TDC_UART_module/TDC_sensor_instances[9].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[9].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_9]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[9].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 10 ----------------
create_pblock pblock_SENSOR_10
resize_pblock [get_pblocks pblock_SENSOR_10] -add {SLICE_X4Y100:SLICE_X4Y124}
add_cells_to_pblock [get_pblocks pblock_SENSOR_10] [get_cells {TDC_UART_module/TDC_sensor_instances[10].TDC/*}]
set_property LOC SLICE_X4Y100 [get_cells {TDC_UART_module/TDC_sensor_instances[10].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[10].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_10]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[10].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 11 ----------------
create_pblock pblock_SENSOR_11
resize_pblock [get_pblocks pblock_SENSOR_11] -add {SLICE_X4Y125:SLICE_X4Y149}
add_cells_to_pblock [get_pblocks pblock_SENSOR_11] [get_cells {TDC_UART_module/TDC_sensor_instances[11].TDC/*}]
set_property LOC SLICE_X4Y125 [get_cells {TDC_UART_module/TDC_sensor_instances[11].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[11].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_11]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[11].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 12 ----------------
create_pblock pblock_SENSOR_12
resize_pblock [get_pblocks pblock_SENSOR_12] -add {SLICE_X8Y0:SLICE_X8Y24}
add_cells_to_pblock [get_pblocks pblock_SENSOR_12] [get_cells {TDC_UART_module/TDC_sensor_instances[12].TDC/*}]
set_property LOC SLICE_X8Y0 [get_cells {TDC_UART_module/TDC_sensor_instances[12].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[12].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_12]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[12].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 13 ----------------
create_pblock pblock_SENSOR_13
resize_pblock [get_pblocks pblock_SENSOR_13] -add {SLICE_X8Y25:SLICE_X8Y49}
add_cells_to_pblock [get_pblocks pblock_SENSOR_13] [get_cells {TDC_UART_module/TDC_sensor_instances[13].TDC/*}]
set_property LOC SLICE_X8Y25 [get_cells {TDC_UART_module/TDC_sensor_instances[13].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[13].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_13]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[13].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 14 ----------------
create_pblock pblock_SENSOR_14
resize_pblock [get_pblocks pblock_SENSOR_14] -add {SLICE_X8Y50:SLICE_X8Y74}
add_cells_to_pblock [get_pblocks pblock_SENSOR_14] [get_cells {TDC_UART_module/TDC_sensor_instances[14].TDC/*}]
set_property LOC SLICE_X8Y50 [get_cells {TDC_UART_module/TDC_sensor_instances[14].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[14].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_14]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[14].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 15 ----------------
create_pblock pblock_SENSOR_15
resize_pblock [get_pblocks pblock_SENSOR_15] -add {SLICE_X8Y75:SLICE_X8Y99}
add_cells_to_pblock [get_pblocks pblock_SENSOR_15] [get_cells {TDC_UART_module/TDC_sensor_instances[15].TDC/*}]
set_property LOC SLICE_X8Y75 [get_cells {TDC_UART_module/TDC_sensor_instances[15].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[15].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_15]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[15].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 16 ----------------
create_pblock pblock_SENSOR_16
resize_pblock [get_pblocks pblock_SENSOR_16] -add {SLICE_X8Y100:SLICE_X8Y124}
add_cells_to_pblock [get_pblocks pblock_SENSOR_16] [get_cells {TDC_UART_module/TDC_sensor_instances[16].TDC/*}]
set_property LOC SLICE_X8Y100 [get_cells {TDC_UART_module/TDC_sensor_instances[16].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[16].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_16]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[16].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 17 ----------------
create_pblock pblock_SENSOR_17
resize_pblock [get_pblocks pblock_SENSOR_17] -add {SLICE_X8Y125:SLICE_X8Y149}
add_cells_to_pblock [get_pblocks pblock_SENSOR_17] [get_cells {TDC_UART_module/TDC_sensor_instances[17].TDC/*}]
set_property LOC SLICE_X8Y125 [get_cells {TDC_UART_module/TDC_sensor_instances[17].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[17].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_17]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[17].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 18 ----------------
create_pblock pblock_SENSOR_18
resize_pblock [get_pblocks pblock_SENSOR_18] -add {SLICE_X12Y0:SLICE_X12Y24}
add_cells_to_pblock [get_pblocks pblock_SENSOR_18] [get_cells {TDC_UART_module/TDC_sensor_instances[18].TDC/*}]
set_property LOC SLICE_X12Y0 [get_cells {TDC_UART_module/TDC_sensor_instances[18].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[18].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_18]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[18].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 19 ----------------
create_pblock pblock_SENSOR_19
resize_pblock [get_pblocks pblock_SENSOR_19] -add {SLICE_X12Y25:SLICE_X12Y49}
add_cells_to_pblock [get_pblocks pblock_SENSOR_19] [get_cells {TDC_UART_module/TDC_sensor_instances[19].TDC/*}]
set_property LOC SLICE_X12Y25 [get_cells {TDC_UART_module/TDC_sensor_instances[19].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[19].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_19]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[19].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 20 ----------------
create_pblock pblock_SENSOR_20
resize_pblock [get_pblocks pblock_SENSOR_20] -add {SLICE_X12Y50:SLICE_X12Y74}
add_cells_to_pblock [get_pblocks pblock_SENSOR_20] [get_cells {TDC_UART_module/TDC_sensor_instances[20].TDC/*}]
set_property LOC SLICE_X12Y50 [get_cells {TDC_UART_module/TDC_sensor_instances[20].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[20].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_20]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[20].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 21 ----------------
create_pblock pblock_SENSOR_21
resize_pblock [get_pblocks pblock_SENSOR_21] -add {SLICE_X12Y75:SLICE_X12Y99}
add_cells_to_pblock [get_pblocks pblock_SENSOR_21] [get_cells {TDC_UART_module/TDC_sensor_instances[21].TDC/*}]
set_property LOC SLICE_X12Y75 [get_cells {TDC_UART_module/TDC_sensor_instances[21].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[21].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_21]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[21].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 22 ----------------
create_pblock pblock_SENSOR_22
resize_pblock [get_pblocks pblock_SENSOR_22] -add {SLICE_X12Y100:SLICE_X12Y124}
add_cells_to_pblock [get_pblocks pblock_SENSOR_22] [get_cells {TDC_UART_module/TDC_sensor_instances[22].TDC/*}]
set_property LOC SLICE_X12Y100 [get_cells {TDC_UART_module/TDC_sensor_instances[22].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[22].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_22]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[22].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 23 ----------------
create_pblock pblock_SENSOR_23
resize_pblock [get_pblocks pblock_SENSOR_23] -add {SLICE_X12Y125:SLICE_X12Y149}
add_cells_to_pblock [get_pblocks pblock_SENSOR_23] [get_cells {TDC_UART_module/TDC_sensor_instances[23].TDC/*}]
set_property LOC SLICE_X12Y125 [get_cells {TDC_UART_module/TDC_sensor_instances[23].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[23].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_23]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[23].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 24 ----------------
create_pblock pblock_SENSOR_24
resize_pblock [get_pblocks pblock_SENSOR_24] -add {SLICE_X16Y100:SLICE_X16Y124}
add_cells_to_pblock [get_pblocks pblock_SENSOR_24] [get_cells {TDC_UART_module/TDC_sensor_instances[24].TDC/*}]
set_property LOC SLICE_X16Y100 [get_cells {TDC_UART_module/TDC_sensor_instances[24].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[24].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_24]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[24].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 25 ----------------
create_pblock pblock_SENSOR_25
resize_pblock [get_pblocks pblock_SENSOR_25] -add {SLICE_X16Y125:SLICE_X16Y149}
add_cells_to_pblock [get_pblocks pblock_SENSOR_25] [get_cells {TDC_UART_module/TDC_sensor_instances[25].TDC/*}]
set_property LOC SLICE_X16Y125 [get_cells {TDC_UART_module/TDC_sensor_instances[25].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[25].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_25]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[25].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 26 ----------------
create_pblock pblock_SENSOR_26
resize_pblock [get_pblocks pblock_SENSOR_26] -add {SLICE_X20Y100:SLICE_X20Y124}
add_cells_to_pblock [get_pblocks pblock_SENSOR_26] [get_cells {TDC_UART_module/TDC_sensor_instances[26].TDC/*}]
set_property LOC SLICE_X20Y100 [get_cells {TDC_UART_module/TDC_sensor_instances[26].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[26].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_26]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[26].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 27 ----------------
create_pblock pblock_SENSOR_27
resize_pblock [get_pblocks pblock_SENSOR_27] -add {SLICE_X20Y125:SLICE_X20Y149}
add_cells_to_pblock [get_pblocks pblock_SENSOR_27] [get_cells {TDC_UART_module/TDC_sensor_instances[27].TDC/*}]
set_property LOC SLICE_X20Y125 [get_cells {TDC_UART_module/TDC_sensor_instances[27].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[27].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_27]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[27].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 28 ----------------
create_pblock pblock_SENSOR_28
resize_pblock [get_pblocks pblock_SENSOR_28] -add {SLICE_X24Y100:SLICE_X24Y124}
add_cells_to_pblock [get_pblocks pblock_SENSOR_28] [get_cells {TDC_UART_module/TDC_sensor_instances[28].TDC/*}]
set_property LOC SLICE_X24Y100 [get_cells {TDC_UART_module/TDC_sensor_instances[28].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[28].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_28]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[28].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 29 ----------------
create_pblock pblock_SENSOR_29
resize_pblock [get_pblocks pblock_SENSOR_29] -add {SLICE_X24Y125:SLICE_X24Y149}
add_cells_to_pblock [get_pblocks pblock_SENSOR_29] [get_cells {TDC_UART_module/TDC_sensor_instances[29].TDC/*}]
set_property LOC SLICE_X24Y125 [get_cells {TDC_UART_module/TDC_sensor_instances[29].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[29].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_29]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[29].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 30 ----------------
create_pblock pblock_SENSOR_30
resize_pblock [get_pblocks pblock_SENSOR_30] -add {SLICE_X28Y0:SLICE_X28Y24}
add_cells_to_pblock [get_pblocks pblock_SENSOR_30] [get_cells {TDC_UART_module/TDC_sensor_instances[30].TDC/*}]
set_property LOC SLICE_X28Y0 [get_cells {TDC_UART_module/TDC_sensor_instances[30].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[30].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_30]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[30].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 31 ----------------
create_pblock pblock_SENSOR_31
resize_pblock [get_pblocks pblock_SENSOR_31] -add {SLICE_X28Y25:SLICE_X28Y49}
add_cells_to_pblock [get_pblocks pblock_SENSOR_31] [get_cells {TDC_UART_module/TDC_sensor_instances[31].TDC/*}]
set_property LOC SLICE_X28Y25 [get_cells {TDC_UART_module/TDC_sensor_instances[31].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[31].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_31]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[31].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 32 ----------------
create_pblock pblock_SENSOR_32
resize_pblock [get_pblocks pblock_SENSOR_32] -add {SLICE_X28Y50:SLICE_X28Y74}
add_cells_to_pblock [get_pblocks pblock_SENSOR_32] [get_cells {TDC_UART_module/TDC_sensor_instances[32].TDC/*}]
set_property LOC SLICE_X28Y50 [get_cells {TDC_UART_module/TDC_sensor_instances[32].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[32].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_32]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[32].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 33 ----------------
create_pblock pblock_SENSOR_33
resize_pblock [get_pblocks pblock_SENSOR_33] -add {SLICE_X28Y75:SLICE_X28Y99}
add_cells_to_pblock [get_pblocks pblock_SENSOR_33] [get_cells {TDC_UART_module/TDC_sensor_instances[33].TDC/*}]
set_property LOC SLICE_X28Y75 [get_cells {TDC_UART_module/TDC_sensor_instances[33].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[33].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_33]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[33].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 34 ----------------
create_pblock pblock_SENSOR_34
resize_pblock [get_pblocks pblock_SENSOR_34] -add {SLICE_X28Y100:SLICE_X28Y124}
add_cells_to_pblock [get_pblocks pblock_SENSOR_34] [get_cells {TDC_UART_module/TDC_sensor_instances[34].TDC/*}]
set_property LOC SLICE_X28Y100 [get_cells {TDC_UART_module/TDC_sensor_instances[34].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[34].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_34]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[34].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 35 ----------------
create_pblock pblock_SENSOR_35
resize_pblock [get_pblocks pblock_SENSOR_35] -add {SLICE_X28Y125:SLICE_X28Y149}
add_cells_to_pblock [get_pblocks pblock_SENSOR_35] [get_cells {TDC_UART_module/TDC_sensor_instances[35].TDC/*}]
set_property LOC SLICE_X28Y125 [get_cells {TDC_UART_module/TDC_sensor_instances[35].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[35].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_35]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[35].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 36 ----------------
create_pblock pblock_SENSOR_36
resize_pblock [get_pblocks pblock_SENSOR_36] -add {SLICE_X32Y0:SLICE_X32Y24}
add_cells_to_pblock [get_pblocks pblock_SENSOR_36] [get_cells {TDC_UART_module/TDC_sensor_instances[36].TDC/*}]
set_property LOC SLICE_X32Y0 [get_cells {TDC_UART_module/TDC_sensor_instances[36].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[36].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_36]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[36].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 37 ----------------
create_pblock pblock_SENSOR_37
resize_pblock [get_pblocks pblock_SENSOR_37] -add {SLICE_X32Y25:SLICE_X32Y49}
add_cells_to_pblock [get_pblocks pblock_SENSOR_37] [get_cells {TDC_UART_module/TDC_sensor_instances[37].TDC/*}]
set_property LOC SLICE_X32Y25 [get_cells {TDC_UART_module/TDC_sensor_instances[37].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[37].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_37]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[37].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 38 ----------------
create_pblock pblock_SENSOR_38
resize_pblock [get_pblocks pblock_SENSOR_38] -add {SLICE_X32Y50:SLICE_X32Y74}
add_cells_to_pblock [get_pblocks pblock_SENSOR_38] [get_cells {TDC_UART_module/TDC_sensor_instances[38].TDC/*}]
set_property LOC SLICE_X32Y50 [get_cells {TDC_UART_module/TDC_sensor_instances[38].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[38].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_38]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[38].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 39 ----------------
create_pblock pblock_SENSOR_39
resize_pblock [get_pblocks pblock_SENSOR_39] -add {SLICE_X32Y75:SLICE_X32Y99}
add_cells_to_pblock [get_pblocks pblock_SENSOR_39] [get_cells {TDC_UART_module/TDC_sensor_instances[39].TDC/*}]
set_property LOC SLICE_X32Y75 [get_cells {TDC_UART_module/TDC_sensor_instances[39].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[39].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_39]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[39].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 40 ----------------
create_pblock pblock_SENSOR_40
resize_pblock [get_pblocks pblock_SENSOR_40] -add {SLICE_X32Y100:SLICE_X32Y124}
add_cells_to_pblock [get_pblocks pblock_SENSOR_40] [get_cells {TDC_UART_module/TDC_sensor_instances[40].TDC/*}]
set_property LOC SLICE_X32Y100 [get_cells {TDC_UART_module/TDC_sensor_instances[40].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[40].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_40]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[40].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 41 ----------------
create_pblock pblock_SENSOR_41
resize_pblock [get_pblocks pblock_SENSOR_41] -add {SLICE_X32Y125:SLICE_X32Y149}
add_cells_to_pblock [get_pblocks pblock_SENSOR_41] [get_cells {TDC_UART_module/TDC_sensor_instances[41].TDC/*}]
set_property LOC SLICE_X32Y125 [get_cells {TDC_UART_module/TDC_sensor_instances[41].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[41].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_41]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[41].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 42 ----------------
create_pblock pblock_SENSOR_42
resize_pblock [get_pblocks pblock_SENSOR_42] -add {SLICE_X36Y0:SLICE_X36Y24}
add_cells_to_pblock [get_pblocks pblock_SENSOR_42] [get_cells {TDC_UART_module/TDC_sensor_instances[42].TDC/*}]
set_property LOC SLICE_X36Y0 [get_cells {TDC_UART_module/TDC_sensor_instances[42].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[42].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_42]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[42].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 43 ----------------
create_pblock pblock_SENSOR_43
resize_pblock [get_pblocks pblock_SENSOR_43] -add {SLICE_X36Y25:SLICE_X36Y49}
add_cells_to_pblock [get_pblocks pblock_SENSOR_43] [get_cells {TDC_UART_module/TDC_sensor_instances[43].TDC/*}]
set_property LOC SLICE_X36Y25 [get_cells {TDC_UART_module/TDC_sensor_instances[43].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[43].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_43]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[43].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 44 ----------------
create_pblock pblock_SENSOR_44
resize_pblock [get_pblocks pblock_SENSOR_44] -add {SLICE_X36Y50:SLICE_X36Y74}
add_cells_to_pblock [get_pblocks pblock_SENSOR_44] [get_cells {TDC_UART_module/TDC_sensor_instances[44].TDC/*}]
set_property LOC SLICE_X36Y50 [get_cells {TDC_UART_module/TDC_sensor_instances[44].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[44].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_44]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[44].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 45 ----------------
create_pblock pblock_SENSOR_45
resize_pblock [get_pblocks pblock_SENSOR_45] -add {SLICE_X36Y75:SLICE_X36Y99}
add_cells_to_pblock [get_pblocks pblock_SENSOR_45] [get_cells {TDC_UART_module/TDC_sensor_instances[45].TDC/*}]
set_property LOC SLICE_X36Y75 [get_cells {TDC_UART_module/TDC_sensor_instances[45].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[45].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_45]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[45].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 46 ----------------
create_pblock pblock_SENSOR_46
resize_pblock [get_pblocks pblock_SENSOR_46] -add {SLICE_X36Y100:SLICE_X36Y124}
add_cells_to_pblock [get_pblocks pblock_SENSOR_46] [get_cells {TDC_UART_module/TDC_sensor_instances[46].TDC/*}]
set_property LOC SLICE_X36Y100 [get_cells {TDC_UART_module/TDC_sensor_instances[46].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[46].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_46]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[46].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 47 ----------------
create_pblock pblock_SENSOR_47
resize_pblock [get_pblocks pblock_SENSOR_47] -add {SLICE_X36Y125:SLICE_X36Y149}
add_cells_to_pblock [get_pblocks pblock_SENSOR_47] [get_cells {TDC_UART_module/TDC_sensor_instances[47].TDC/*}]
set_property LOC SLICE_X36Y125 [get_cells {TDC_UART_module/TDC_sensor_instances[47].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[47].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_47]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[47].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 48 ----------------
create_pblock pblock_SENSOR_48
resize_pblock [get_pblocks pblock_SENSOR_48] -add {SLICE_X40Y0:SLICE_X40Y24}
add_cells_to_pblock [get_pblocks pblock_SENSOR_48] [get_cells {TDC_UART_module/TDC_sensor_instances[48].TDC/*}]
set_property LOC SLICE_X40Y0 [get_cells {TDC_UART_module/TDC_sensor_instances[48].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[48].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_48]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[48].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 49 ----------------
create_pblock pblock_SENSOR_49
resize_pblock [get_pblocks pblock_SENSOR_49] -add {SLICE_X40Y25:SLICE_X40Y49}
add_cells_to_pblock [get_pblocks pblock_SENSOR_49] [get_cells {TDC_UART_module/TDC_sensor_instances[49].TDC/*}]
set_property LOC SLICE_X40Y25 [get_cells {TDC_UART_module/TDC_sensor_instances[49].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[49].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_49]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[49].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 50 ----------------
create_pblock pblock_SENSOR_50
resize_pblock [get_pblocks pblock_SENSOR_50] -add {SLICE_X40Y50:SLICE_X40Y74}
add_cells_to_pblock [get_pblocks pblock_SENSOR_50] [get_cells {TDC_UART_module/TDC_sensor_instances[50].TDC/*}]
set_property LOC SLICE_X40Y50 [get_cells {TDC_UART_module/TDC_sensor_instances[50].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[50].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_50]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[50].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 51 ----------------
create_pblock pblock_SENSOR_51
resize_pblock [get_pblocks pblock_SENSOR_51] -add {SLICE_X40Y75:SLICE_X40Y99}
add_cells_to_pblock [get_pblocks pblock_SENSOR_51] [get_cells {TDC_UART_module/TDC_sensor_instances[51].TDC/*}]
set_property LOC SLICE_X40Y75 [get_cells {TDC_UART_module/TDC_sensor_instances[51].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[51].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_51]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[51].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 52 ----------------
create_pblock pblock_SENSOR_52
resize_pblock [get_pblocks pblock_SENSOR_52] -add {SLICE_X40Y100:SLICE_X40Y124}
add_cells_to_pblock [get_pblocks pblock_SENSOR_52] [get_cells {TDC_UART_module/TDC_sensor_instances[52].TDC/*}]
set_property LOC SLICE_X40Y100 [get_cells {TDC_UART_module/TDC_sensor_instances[52].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[52].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_52]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[52].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 53 ----------------
create_pblock pblock_SENSOR_53
resize_pblock [get_pblocks pblock_SENSOR_53] -add {SLICE_X40Y125:SLICE_X40Y149}
add_cells_to_pblock [get_pblocks pblock_SENSOR_53] [get_cells {TDC_UART_module/TDC_sensor_instances[53].TDC/*}]
set_property LOC SLICE_X40Y125 [get_cells {TDC_UART_module/TDC_sensor_instances[53].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[53].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_53]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[53].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 54 ----------------
create_pblock pblock_SENSOR_54
resize_pblock [get_pblocks pblock_SENSOR_54] -add {SLICE_X44Y0:SLICE_X44Y24}
add_cells_to_pblock [get_pblocks pblock_SENSOR_54] [get_cells {TDC_UART_module/TDC_sensor_instances[54].TDC/*}]
set_property LOC SLICE_X44Y0 [get_cells {TDC_UART_module/TDC_sensor_instances[54].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[54].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_54]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[54].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 55 ----------------
create_pblock pblock_SENSOR_55
resize_pblock [get_pblocks pblock_SENSOR_55] -add {SLICE_X44Y25:SLICE_X44Y49}
add_cells_to_pblock [get_pblocks pblock_SENSOR_55] [get_cells {TDC_UART_module/TDC_sensor_instances[55].TDC/*}]
set_property LOC SLICE_X44Y25 [get_cells {TDC_UART_module/TDC_sensor_instances[55].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[55].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_55]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[55].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 56 ----------------
create_pblock pblock_SENSOR_56
resize_pblock [get_pblocks pblock_SENSOR_56] -add {SLICE_X44Y50:SLICE_X44Y74}
add_cells_to_pblock [get_pblocks pblock_SENSOR_56] [get_cells {TDC_UART_module/TDC_sensor_instances[56].TDC/*}]
set_property LOC SLICE_X44Y50 [get_cells {TDC_UART_module/TDC_sensor_instances[56].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[56].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_56]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[56].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 57 ----------------
create_pblock pblock_SENSOR_57
resize_pblock [get_pblocks pblock_SENSOR_57] -add {SLICE_X44Y75:SLICE_X44Y99}
add_cells_to_pblock [get_pblocks pblock_SENSOR_57] [get_cells {TDC_UART_module/TDC_sensor_instances[57].TDC/*}]
set_property LOC SLICE_X44Y75 [get_cells {TDC_UART_module/TDC_sensor_instances[57].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[57].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_57]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[57].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 58 ----------------
create_pblock pblock_SENSOR_58
resize_pblock [get_pblocks pblock_SENSOR_58] -add {SLICE_X44Y125:SLICE_X44Y149}
add_cells_to_pblock [get_pblocks pblock_SENSOR_58] [get_cells {TDC_UART_module/TDC_sensor_instances[58].TDC/*}]
set_property LOC SLICE_X44Y125 [get_cells {TDC_UART_module/TDC_sensor_instances[58].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[58].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_58]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[58].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 59 ----------------
create_pblock pblock_SENSOR_59
resize_pblock [get_pblocks pblock_SENSOR_59] -add {SLICE_X48Y0:SLICE_X48Y24}
add_cells_to_pblock [get_pblocks pblock_SENSOR_59] [get_cells {TDC_UART_module/TDC_sensor_instances[59].TDC/*}]
set_property LOC SLICE_X48Y0 [get_cells {TDC_UART_module/TDC_sensor_instances[59].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[59].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_59]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[59].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 60 ----------------
create_pblock pblock_SENSOR_60
resize_pblock [get_pblocks pblock_SENSOR_60] -add {SLICE_X48Y25:SLICE_X48Y49}
add_cells_to_pblock [get_pblocks pblock_SENSOR_60] [get_cells {TDC_UART_module/TDC_sensor_instances[60].TDC/*}]
set_property LOC SLICE_X48Y25 [get_cells {TDC_UART_module/TDC_sensor_instances[60].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[60].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_60]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[60].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 61 ----------------
create_pblock pblock_SENSOR_61
resize_pblock [get_pblocks pblock_SENSOR_61] -add {SLICE_X48Y50:SLICE_X48Y74}
add_cells_to_pblock [get_pblocks pblock_SENSOR_61] [get_cells {TDC_UART_module/TDC_sensor_instances[61].TDC/*}]
set_property LOC SLICE_X48Y50 [get_cells {TDC_UART_module/TDC_sensor_instances[61].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[61].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_61]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[61].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 62 ----------------
create_pblock pblock_SENSOR_62
resize_pblock [get_pblocks pblock_SENSOR_62] -add {SLICE_X48Y75:SLICE_X48Y99}
add_cells_to_pblock [get_pblocks pblock_SENSOR_62] [get_cells {TDC_UART_module/TDC_sensor_instances[62].TDC/*}]
set_property LOC SLICE_X48Y75 [get_cells {TDC_UART_module/TDC_sensor_instances[62].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[62].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_62]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[62].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 63 ----------------
create_pblock pblock_SENSOR_63
resize_pblock [get_pblocks pblock_SENSOR_63] -add {SLICE_X48Y100:SLICE_X48Y124}
add_cells_to_pblock [get_pblocks pblock_SENSOR_63] [get_cells {TDC_UART_module/TDC_sensor_instances[63].TDC/*}]
set_property LOC SLICE_X48Y100 [get_cells {TDC_UART_module/TDC_sensor_instances[63].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[63].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_63]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[63].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 64 ----------------
create_pblock pblock_SENSOR_64
resize_pblock [get_pblocks pblock_SENSOR_64] -add {SLICE_X48Y125:SLICE_X48Y149}
add_cells_to_pblock [get_pblocks pblock_SENSOR_64] [get_cells {TDC_UART_module/TDC_sensor_instances[64].TDC/*}]
set_property LOC SLICE_X48Y125 [get_cells {TDC_UART_module/TDC_sensor_instances[64].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[64].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_64]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[64].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 65 ----------------
create_pblock pblock_SENSOR_65
resize_pblock [get_pblocks pblock_SENSOR_65] -add {SLICE_X52Y0:SLICE_X52Y24}
add_cells_to_pblock [get_pblocks pblock_SENSOR_65] [get_cells {TDC_UART_module/TDC_sensor_instances[65].TDC/*}]
set_property LOC SLICE_X52Y0 [get_cells {TDC_UART_module/TDC_sensor_instances[65].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[65].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_65]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[65].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 66 ----------------
create_pblock pblock_SENSOR_66
resize_pblock [get_pblocks pblock_SENSOR_66] -add {SLICE_X52Y25:SLICE_X52Y49}
add_cells_to_pblock [get_pblocks pblock_SENSOR_66] [get_cells {TDC_UART_module/TDC_sensor_instances[66].TDC/*}]
set_property LOC SLICE_X52Y25 [get_cells {TDC_UART_module/TDC_sensor_instances[66].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[66].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_66]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[66].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 67 ----------------
create_pblock pblock_SENSOR_67
resize_pblock [get_pblocks pblock_SENSOR_67] -add {SLICE_X52Y50:SLICE_X52Y74}
add_cells_to_pblock [get_pblocks pblock_SENSOR_67] [get_cells {TDC_UART_module/TDC_sensor_instances[67].TDC/*}]
set_property LOC SLICE_X52Y50 [get_cells {TDC_UART_module/TDC_sensor_instances[67].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[67].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_67]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[67].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 68 ----------------
create_pblock pblock_SENSOR_68
resize_pblock [get_pblocks pblock_SENSOR_68] -add {SLICE_X52Y75:SLICE_X52Y99}
add_cells_to_pblock [get_pblocks pblock_SENSOR_68] [get_cells {TDC_UART_module/TDC_sensor_instances[68].TDC/*}]
set_property LOC SLICE_X52Y75 [get_cells {TDC_UART_module/TDC_sensor_instances[68].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[68].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_68]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[68].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 69 ----------------
create_pblock pblock_SENSOR_69
resize_pblock [get_pblocks pblock_SENSOR_69] -add {SLICE_X52Y100:SLICE_X52Y124}
add_cells_to_pblock [get_pblocks pblock_SENSOR_69] [get_cells {TDC_UART_module/TDC_sensor_instances[69].TDC/*}]
set_property LOC SLICE_X52Y100 [get_cells {TDC_UART_module/TDC_sensor_instances[69].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[69].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_69]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[69].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 70 ----------------
create_pblock pblock_SENSOR_70
resize_pblock [get_pblocks pblock_SENSOR_70] -add {SLICE_X52Y125:SLICE_X52Y149}
add_cells_to_pblock [get_pblocks pblock_SENSOR_70] [get_cells {TDC_UART_module/TDC_sensor_instances[70].TDC/*}]
set_property LOC SLICE_X52Y125 [get_cells {TDC_UART_module/TDC_sensor_instances[70].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[70].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_70]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[70].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 71 ----------------
create_pblock pblock_SENSOR_71
resize_pblock [get_pblocks pblock_SENSOR_71] -add {SLICE_X56Y0:SLICE_X56Y24}
add_cells_to_pblock [get_pblocks pblock_SENSOR_71] [get_cells {TDC_UART_module/TDC_sensor_instances[71].TDC/*}]
set_property LOC SLICE_X56Y0 [get_cells {TDC_UART_module/TDC_sensor_instances[71].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[71].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_71]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[71].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 72 ----------------
create_pblock pblock_SENSOR_72
resize_pblock [get_pblocks pblock_SENSOR_72] -add {SLICE_X56Y25:SLICE_X56Y49}
add_cells_to_pblock [get_pblocks pblock_SENSOR_72] [get_cells {TDC_UART_module/TDC_sensor_instances[72].TDC/*}]
set_property LOC SLICE_X56Y25 [get_cells {TDC_UART_module/TDC_sensor_instances[72].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[72].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_72]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[72].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 73 ----------------
create_pblock pblock_SENSOR_73
resize_pblock [get_pblocks pblock_SENSOR_73] -add {SLICE_X56Y50:SLICE_X56Y74}
add_cells_to_pblock [get_pblocks pblock_SENSOR_73] [get_cells {TDC_UART_module/TDC_sensor_instances[73].TDC/*}]
set_property LOC SLICE_X56Y50 [get_cells {TDC_UART_module/TDC_sensor_instances[73].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[73].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_73]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[73].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 74 ----------------
create_pblock pblock_SENSOR_74
resize_pblock [get_pblocks pblock_SENSOR_74] -add {SLICE_X56Y75:SLICE_X56Y99}
add_cells_to_pblock [get_pblocks pblock_SENSOR_74] [get_cells {TDC_UART_module/TDC_sensor_instances[74].TDC/*}]
set_property LOC SLICE_X56Y75 [get_cells {TDC_UART_module/TDC_sensor_instances[74].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[74].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_74]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[74].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 75 ----------------
create_pblock pblock_SENSOR_75
resize_pblock [get_pblocks pblock_SENSOR_75] -add {SLICE_X60Y0:SLICE_X60Y24}
add_cells_to_pblock [get_pblocks pblock_SENSOR_75] [get_cells {TDC_UART_module/TDC_sensor_instances[75].TDC/*}]
set_property LOC SLICE_X60Y0 [get_cells {TDC_UART_module/TDC_sensor_instances[75].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[75].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_75]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[75].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 76 ----------------
create_pblock pblock_SENSOR_76
resize_pblock [get_pblocks pblock_SENSOR_76] -add {SLICE_X60Y25:SLICE_X60Y49}
add_cells_to_pblock [get_pblocks pblock_SENSOR_76] [get_cells {TDC_UART_module/TDC_sensor_instances[76].TDC/*}]
set_property LOC SLICE_X60Y25 [get_cells {TDC_UART_module/TDC_sensor_instances[76].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[76].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_76]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[76].TDC/sensor_o_regs[*].obs_regs/D}]


# ---------------- TDC 77 ----------------
create_pblock pblock_SENSOR_77
resize_pblock [get_pblocks pblock_SENSOR_77] -add {SLICE_X60Y50:SLICE_X60Y74}
add_cells_to_pblock [get_pblocks pblock_SENSOR_77] [get_cells {TDC_UART_module/TDC_sensor_instances[77].TDC/*}]
set_property LOC SLICE_X60Y50 [get_cells {TDC_UART_module/TDC_sensor_instances[77].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[77].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_77]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[77].TDC/sensor_o_regs[*].obs_regs/D}]

# ---------------- TDC 78 ----------------
create_pblock pblock_SENSOR_78
resize_pblock [get_pblocks pblock_SENSOR_78] -add {SLICE_X60Y75:SLICE_X60Y99}
add_cells_to_pblock [get_pblocks pblock_SENSOR_78] [get_cells {TDC_UART_module/TDC_sensor_instances[78].TDC/*}]
set_property LOC SLICE_X60Y75 [get_cells {TDC_UART_module/TDC_sensor_instances[78].TDC/coarse_init}]
set_property DONT_TOUCH true [get_cells {TDC_UART_module/TDC_sensor_instances[78].TDC/*}]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_SENSOR_78]
set_false_path -from [get_clocks *] -to [get_pins {TDC_UART_module/TDC_sensor_instances[78].TDC/sensor_o_regs[*].obs_regs/D}]


#################################################
# THIS CODE HAS BEEN GENERATED BY RRAM COMPILER #
#################################################

# AUTHOR:		DIMITRIS ANTONIADIS
# ORGANISATION:	IMPERIAL COLLEGE LONDON


set topcellname "SIGNALS_VDDL_128_64_16"
#################################################
#            STEP 1: SET UP DESIGN              #
#################################################

# Set Power/Ground
set_db init_power_nets {VDD}
set_db init_ground_nets {VSS}
# Source Design Configurations/ Set MMMC flow 
source ../innovus/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16.invs_setup.tcl
set_db design_process_node 180
set_multi_cpu_usage -local_cpu 4
#################################################

#################################################
#            STEP 2: FLOORPLAN                  #
#################################################

setPreference EnableRectilinearDesign 1
create_floorplan -site core7T -core_size 393.750000 79.960000 10.000000 10.000000 10.000000 10.000000
#Create L shape floorplan, able to snap to grid
# It has to be multiple of 0.005
# Floorplan has already been snapped to grid so new coordinates have to be fetched.
set urx [get_db current_design .bbox.ur.x]
set ury [get_db current_design .bbox.ur.y]
set mid_x [expr $urx-318.295000]
set mid_x [expr int($mid_x /0.56)*0.56]
set mid_y [expr $ury-26.905000]
set mid_y [expr int($mid_y /0.56)*0.56]
set str_co "$mid_x $mid_y $urx $ury"
update_obj_floorplan_cut_box -box_list $str_co -name SIGNALS_VDDL_128_64_16 -type cell
snap_floorplan -all
check_floorplan
write_floorplan ../innovus/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16_floorplan.fp
write_db ../db/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16_innovus_floorplan.db

#################################################
#            STEP 3: POWER PLAN                 #
#################################################

# Create Core Ring
set_db add_rings_target default
set_db add_rings_extend_over_row 0
set_db add_rings_ignore_rows 0
set_db add_rings_avoid_short 0
set_db add_rings_skip_shared_inner_ring none
set_db add_rings_stacked_via_top_layer METAL5
set_db add_rings_stacked_via_bottom_layer METAL1
set_db add_rings_via_using_exact_crossover_size 1
set_db add_rings_orthogonal_only true
set_db add_rings_skip_via_on_pin {  standardcell }
set_db add_rings_skip_via_on_wire_shape {  noshape }
add_rings -nets {VDD VSS} -type core_rings -follow core -layer {top METAL5 bottom METAL5 left METAL4 right METAL4} -width {top 1.8 bottom 1.8 left 1.8 right 1.8} -spacing {top 0.46 bottom 0.46 left 0.28 right 0.28} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid none

# Add stripes
set_db add_stripes_ignore_block_check false
set_db add_stripes_break_at none
set_db add_stripes_route_over_rows_only false
set_db add_stripes_rows_without_stripes_only false
set_db add_stripes_extend_to_closest_target none
set_db add_stripes_stop_at_last_wire_for_area false
set_db add_stripes_partial_set_through_domain false
set_db add_stripes_ignore_non_default_domains false
set_db add_stripes_trim_antenna_back_to_shape none
set_db add_stripes_spacing_type edge_to_edge
set_db add_stripes_spacing_from_block 0
set_db add_stripes_stripe_min_length stripe_width
set_db add_stripes_stacked_via_top_layer METAL5
set_db add_stripes_stacked_via_bottom_layer METAL1
set_db add_stripes_via_using_exact_crossover_size false
set_db add_stripes_split_vias false
set_db add_stripes_orthogonal_only true
set_db add_stripes_allow_jog { padcore_ring  block_ring }
set_db add_stripes_skip_via_on_pin {  standardcell }
set_db add_stripes_skip_via_on_wire_shape {  noshape   }
add_stripes -nets {VDD VSS} -layer METAL4 -direction vertical -width 1.8 -spacing 1.8 -set_to_set_distance 36 -start_from left -start_offset 4.5 -stop_offset 4.5 -switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit METAL5 -pad_core_ring_bottom_layer_limit METAL1 -block_ring_top_layer_limit METAL5 -block_ring_bottom_layer_limit METAL1 -use_wire_group 0 -snap_wire_center_to_grid none
#Create Physical PG Pins
create_pg_pin -name VDD -net VDD -geometry METAL1 1.8 0 3.6 1.8
create_pg_pin -name VSS -net VSS -geometry METAL1 7.2 0 9 1.8

# Global Connect Power
connect_global_net VSS -type pg_pin -pin_base_name VSS
connect_global_net VDD -type pg_pin -pin_base_name VDD
connect_global_net VSS -type tie_lo -all
connect_global_net VDD -type tie_hi -all
write_db ../db/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16_innovus_pg.db

# Place Pins
read_io_file ../innovus/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16_pins.io
write_db ../db/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16_innovus_io.db
# Special Route
route_special -connect {block_pin pad_pin pad_ring core_pin floating_stripe} -layer_change_range { METAL1(1) METAL5(5) } -block_pin_target {nearest_target} -pad_pin_port_connect {all_port one_geom} -pad_pin_target {nearest_target} -core_pin_target {first_after_row_end} -floating_stripe_target {block_ring pad_ring ring stripe ring_pin block_pin followpin} -allow_jogging 1 -crossover_via_layer_range { METAL1(1) METAL5(5) } -nets { VDD VSS } -allow_layer_change 1 -block_pin use_lef -target_via_layer_range { METAL1(1) METAL5(5) }
write_db ../db/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16_innovus_sroute.db
write_floorplan ../innovus/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16_floorplan_after_sroute.fp


#################################################
#   STEP 4: Pre CTS Placement and Optimization  #
#################################################

set_db timing_analysis_type ocv
set_db timing_analysis_cppr both
# GigaPlace engine performs standard cell placement and IO pin assignment while GigaOpt
# engine performs preCTS, postCTS, and postRoute optimization.
# Command place_opt_design executes pre-CTS flow by running both placement and 
# pre-CTS optimization. Optimization at this stage is performed with ideal clocks because 
# the clock tree has not been inserted yet.
enable_metrics -on
push_snapshot_stack
place_opt_design


#################################################
#   STEP 5: Extract Parasitics				 #
#################################################

reset_parasitics
extract_rc
write_parasitics -spef_file ../innovus/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16.spef -rc_corner default_emulate_rc_corner

#################################################
#   STEP 6: Calculate Ideal Delays              #
#################################################

# delay = 0.1ps
write_sdf ../innovus/SIGNALS_VDDL_128_64_16/outputs/SIGNALS_VDDL_128_64_16_innovus_ideal.sdf -ideal_clock_network


#################################################
#   STEP 7: Timing Analysis preCTS              #
#################################################

time_design -pre_cts -path_report -drv_report -slack_report -num_paths 50 -report_prefix SIGNALS_VDDL_128_64_16_preCTS -report_dir ../innovus/SIGNALS_VDDL_128_64_16/timingReports
pop_snapshot_stack
create_snapshot -name pre_CTS


#################################################
#   STEP 8: CTS                                 #
#################################################


# COMMENTED OUT THERE ARE NO CLOCKS 
if 0 {
# Double Width Double Spacing for clock paths
create_route_rule -width {METAL1 0.46 METAL2 0.56 METAL3 0.56 METAL4 0.56 METAL5 0.88 } -spacing {METAL1 0.46 METAL2 0.56 METAL3 0.56 METAL4 0.56 METAL5 0.92 } -name 2w2s
create_route_type -name clkroute -route_rule 2w2s -bottom_preferred_layer METAL2 -top_preferred_layer METAL5
set_db cts_route_type_trunk clkroute
set_db cts_route_type_leaf clkroute
set_db cts_buffer_cells {CKBD0 CKBD1 CKBD2 CKBD3 CKBD4 CKBD6 CKBD8}
set_db cts_inverter_cells {CKND0 CKND1 CKND2 CKND3 CKND4 CKND6 CKND8}
create_clock_tree_spec -out_file ../innovus/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16_ccopt.spec
source ../innovus/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16_ccopt.spec
ccopt_design
push_snapshot_stack
write_db ../db/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16_innovus_cts.db


#################################################
#   STEP 9: Post-CTS Timing Optimization        #
#################################################

time_design -post_cts
opt_design -post_cts -drv
time_design -post_cts -hold
opt_design -post_cts -hold
pop_snapshot_stack
create_snapshot -name post_CTS
write_db ../db/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16_innovus_post_cts.db
}
# END OF COMMENT


#################################################
#   STEP 10: Routing                             #
#################################################

push_snapshot_stack
set_route_attributes -net clk -preferred_extra_space_tracks 2
set_db route_design_detail_use_multi_cut_via_effort high
set_db route_design_antenna_diode_insertion 1
set_db route_design_antenna_cell_name ANTENNA
eval_legacy { setNanoRouteMode -quiet -timingEngine {} }
set_db route_design_with_timing_driven 1
set_db route_design_with_si_driven 1
set_db route_design_with_timing_driven true
set_db route_design_with_si_driven true
route_design -global_detail
write_db ../db/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16_innovus_route.db


#################################################
#   STEP 11: Post Routing                        #
#################################################

set_db extract_rc_engine post_route
set_db extract_rc_effort_level low
set_db timing_analysis_type ocv
set_db timing_analysis_cppr both
time_design -post_route
time_design -post_route -hold
opt_design -post_route -setup -hold
write_db ../db/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16_innovus_post_route.db
eval_legacy { addFiller -cell FILL8BWP7T FILL64BWP7T FILL4BWP7T FILL2BWP7T FILL1BWP7T FILL16BWP7T FILL32BWP7T -prefix FILLER -doDRC -fitGap }
pop_snapshot_stack
create_snapshot -name post_route
write_db ../db/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16_innovus_post_route_fillers.db

# COMMENTED OUT UNTIL VERIFIED
if 0 {


#################################################
#   STEP 12: FIX DRC		                    #
#################################################

push_snapshot_stack
check_drc
delete_routes -regular_wire_with_drc
route_design
pop_snapshot_stack
create_snapshot -name fix_drc
}
# END OF COMMENT


#################################################
#   STEP 13: Generate Outputs                   #
#################################################

write_netlist ../innovus/SIGNALS_VDDL_128_64_16/outputs/SIGNALS_VDDL_128_64_16_final.v
write_netlist -phys ../innovus/SIGNALS_VDDL_128_64_16/outputs/SIGNALS_VDDL_128_64_16_final_phys.v
write_netlist -include_pg_ports -include_phys_insts ../innovus/SIGNALS_VDDL_128_64_16/outputs/SIGNALS_VDDL_128_64_16_final_pg.v
write_netlist  -include_pg_ports -include_phys_insts -exclude_leaf_cells ../innovus/SIGNALS_VDDL_128_64_16/outputs/SIGNALS_VDDL_128_64_16_final_pg_top.v
write_sdf ../innovus/SIGNALS_VDDL_128_64_16/outputs/SIGNALS_VDDL_128_64_16_final.sdf -edges check_edge
write_def ../innovus/SIGNALS_VDDL_128_64_16/outputs/SIGNALS_VDDL_128_64_16_final.def -floorplan -netlist -routing
set_db write_stream_label_all_pin_shape true
write_stream ../innovus/SIGNALS_VDDL_128_64_16/outputs/SIGNALS_VDDL_128_64_16_final.gds -map_file gds2.map  -unit 1000 -mode ALL
reset_parasitics
set_db extract_rc_engine post_route
set_db extract_rc_coupled true
extract_rc
write_parasitics -spef_file ../innovus/SIGNALS_VDDL_128_64_16/outputs/SIGNALS_VDDL_128_64_16_final_low_effort.spef -rc_corner default_emulate_rc_corner
report_power -out_file ../reports/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16_innovus_power.rep 

# COMMENTED OUT UNTIL VERIFIED
if 0 {
# High Effort Requires qrcMap.layermap
# I strongly believe this file is wrong
This extract_rc will execute with no errors but probably with wrong results
reset_parasitics
set_db extract_rc_effort_level high
set_db extract_rc_lef_tech_file_map qrcMap.layermap
set_db extract_rc_engine post_route
set_db extract_rc_coupled true
extract_rc
write_parasitics -spef_file ../innovus/SIGNALS_VDDL_128_64_16/outputs/SIGNALS_VDDL_128_64_16_final_high_effort.spef -rc_corner default_emulate_rc_corner
}
# END OF COMMENT

# COMMENTED OUT UNTIL VERIFIED
if 0 {

# Signoff Effort Requires qrcMap.layermap
# I strongly believe this file is wrong
 IF RUN IT WILL FAIL
reset_parasitics
set_db extract_rc_effort_level signoff
set_db extract_rc_lef_tech_file_map qrcMap.layermap
set_db extract_rc_engine post_route
set_db extract_rc_coupled true
extract_rc
write_parasitics -spef_file ../innovus/SIGNALS_VDDL_128_64_16/outputs/SIGNALS_VDDL_128_64_16_final_signoff_effort.spef -rc_corner default_emulate_rc_corner
}
# END OF COMMENT
report_qor -file ../reports/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16_innovus_metrics.html -format html
# Report size to be used by controll signal module
set outfile [open ../reports/SIGNALS_VDDL_128_64_16/SIGNALS_VDDL_128_64_16_innovus_size.rep "w"]
set x [get_db current_design .bbox.ur.x]
puts $outfile "x = $x"
set  y [get_db current_design .bbox.ur.y]
puts $outfile "y = $y"
close $outfile 



# Exiting ...


exit

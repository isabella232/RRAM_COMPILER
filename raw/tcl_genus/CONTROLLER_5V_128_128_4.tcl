#################################################
# THIS CODE HAS BEEN GENERATED BY RRAM COMPILER #
#################################################
# AUTHOR:		DIMITRIS ANTONIADIS
# ORGANIZATION:	IMPERIAL COLLEGE LONDON


set DESIGN "CONTROLLER_5V_128_128_4"
#########################################
# Genus Synthesis Script for Controller #
#########################################

# THIS SCRIPT IS THE INITIAL SCRIPT TO BE USED FOR THE COMPILER
# EVERYTHING SHOULD BE PARAMETERISED ON THE TOP DESIGN NAME
# INSTRUCTIONS #
# Genus must be invoked from work directory
# In genus command line: source tcl/counter/setup.tcl
# SET TO LEGACY MODE
#set_db common_ui false;


# DESIGN VARIABLES
# SET THE LOCAL DIRECTORY
# SET SYNTHESIS DIRECTORY
# SET TCL_PATH
# SET RTL PATH
# SET RTL LIST
# SET TIMING AND LEF LIBRARIES
# SET CAPACTINACE TABLE

set LOCAL_DIR "[exec pwd]/.."
set SYNTH_DIR "${LOCAL_DIR}/synthesis/${DESIGN}"
set TCL_PATH "${LOCAL_DIR}/tcl/${DESIGN} ${LOCAL_DIR}/constraints/${DESIGN}"
set RTL_PATH "$LOCAL_DIR/rtl/${DESIGN}"
set RTL_LIST "${DESIGN}.v"
set LIB_PATH "/usr/local/cadence/kits/tsmc/180n_FORTE/PDK_v02_1.6b_2021/tsmc_libraries/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcb018bcdgp2a_110a /ibe/local/cadence/kits/tsmc/180n_FORTE/PDK_v02_1.6b_2021/tsmc_libraries/TSMCHOME/digital/Back_End/lef/tcb018bcdgp2a_110a/lef"
set LIB_LIST "tcb018bcdgp2atc.lib"
set LEF_LIST "tcb018bcdgp2a_5lm.lef"
set CAP_TABLE_FILE {/ibe/local/cadence/kits/tsmc/180n_FORTE/PDK_v02_1.6b_2021/tsmc_libraries/TSMCHOME/digital/Back_End/lef/tcb018bcdgp2a_110a/techfiles/captable/t018lo_1p5m_typical.captable}
#set QRC_TECHFILE {/ibe/local/cadence/kits/tsmc/180n_FORTE/PDK_v02_1.6b_2021/Assura/lvs_rcx/qrcTechFile}

# PATH SETTINGS #
set_db init_lib_search_path $LIB_PATH
set_db script_search_path $TCL_PATH
set_db init_hdl_search_path $RTL_PATH

# READ LIBS #
read_libs $LIB_LIST
read_physical -lef $LEF_LIST
set_db cap_table_file $CAP_TABLE_FILE
#read_qrc $QRC_TECHFILE

# DESIGN PROCESS NODE #
set_db design_process_node 180

# CONFIGURATION SETTINGS
set_db information_level 6
set_db auto_partition true;   # Activates automatic internal partitioning of large designs for efficient synthesis. This attribute must be set before synthesis. 
set_db hdl_track_filename_row_col true;   #Enables or disables file, row, and column information tracking. When set to false, all the file, row, and column information is deleted. Set this attribute to true to enable file, row, column information before using the elaborate command.
set_db auto_ungroup both;    # Activates automatic ungrouping to improve area and timing during synthesis. This attribute must be specified before synthesis.

# Analyze and Elaborate the HDL files
read_hdl  ${RTL_LIST}
elaborate ${DESIGN}
check_design
check_design -unresolved

# READ SDC CONSTRAINTS
read_sdc ${LOCAL_DIR}/constraints/${DESIGN}/constraints.sdc
check_timing_intent

# SYNTHESIS
set_db syn_generic_effort high
set_db syn_map_effort high
set_db syn_opt_effort high
syn_generic 
syn_map 
syn_opt
write_sdf -design $DESIGN -nonegchecks -edges check_edge -setuphold merge_when_paired -recrem merge_when_paired  > ${LOCAL_DIR}/constraints/${DESIGN}/${DESIGN}_syn.sdf


# RESULTS
report_qor

# WRITE OUT THE REPORTS
report timing > ${LOCAL_DIR}/reports/${DESIGN}/${DESIGN}_timing.rep 
report gates  > ${LOCAL_DIR}/reports/${DESIGN}/${DESIGN}_cell.rep 
report area   > ${LOCAL_DIR}/reports/${DESIGN}/${DESIGN}_area.rep 
report power  > ${LOCAL_DIR}/reports/${DESIGN}/${DESIGN}_power.rep 


write_db -to_file ${LOCAL_DIR}/db/${DESIGN}/${DESIGN}_syn.db
write_hdl > ${LOCAL_DIR}/rtl/${DESIGN}/${DESIGN}_syn.v
write_sdc > ${LOCAL_DIR}/constraints/${DESIGN}/${DESIGN}_syn.sdc
#write_sdf -design $DESIGN  -edges check_edge -setuphold merge_when_paired -recrem merge_when_paired  > ${LOCAL_DIR}/constraints/${DESIGN}/${DESIGN}_syn.sdf
write_design -innovus -base_name ${LOCAL_DIR}/innovus/${DESIGN}/${DESIGN}

#gui_show
exit

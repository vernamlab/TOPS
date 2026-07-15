read_sdc -scenario "place_and_route" -netlist "optimized" -pin_separator "/" -ignore_errors {C:/Users/KyleM/Documents/phd_shite/polarfire/BTCMR/designer/top/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
report -type combinational_loops -format xml {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\designer\top\top_layout_combinational_loops.xml}
report -type slack {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\designer\top\pinslacks.txt}
set coverage [report \
    -type     constraints_coverage \
    -format   xml \
    -slacks   no \
    {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\designer\top\top_place_and_route_constraint_coverage.xml}]
set reportfile {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\designer\top\coverage_placeandroute}
set fp [open $reportfile w]
puts $fp $coverage
close $fp
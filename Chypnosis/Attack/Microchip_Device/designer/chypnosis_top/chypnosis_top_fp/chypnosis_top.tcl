open_project -project {C:\Users\KyleM\Documents\phd_shite\polarfire\chypnosis\designer\chypnosis_top\chypnosis_top_fp\chypnosis_top.pro}
enable_device -name {MPFS095T} -enable 1
set_programming_file -name {MPFS095T} -file {C:\Users\KyleM\Documents\phd_shite\polarfire\chypnosis\designer\chypnosis_top\chypnosis_top.ppd}
set_programming_action -action {PROGRAM} -name {MPFS095T} 
run_selected_actions
save_project
close_project

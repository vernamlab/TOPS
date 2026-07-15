new_project \
         -name {chypnosis_top} \
         -location {C:\Users\KyleM\Documents\phd_shite\polarfire\chypnosis\designer\chypnosis_top\chypnosis_top_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {MPFS095T} \
         -name {MPFS095T}
enable_device \
         -name {MPFS095T} \
         -enable {TRUE}
save_project
close_project

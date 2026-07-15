open_project -project {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\designer\top\top_fp\top.pro}\
         -connect_programmers {FALSE}
load_programming_data \
    -name {MPFS095T} \
    -fpga {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\designer\top\top.map} \
    -header {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\designer\top\top.hdr} \
    -snvm {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\designer\top\top_snvm.efc} \
    -spm {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\designer\top\top.spm} \
    -dca {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\designer\top\top.dca}
export_single_ppd \
    -name {MPFS095T} \
    -file {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\designer\top\top.ppd}

save_project
close_project

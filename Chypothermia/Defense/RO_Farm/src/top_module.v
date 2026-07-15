`timescale 1ns / 1ps

module top_module (
    input  wire [3:0] jb_en,
    output wire [3:0] led
);


    (* keep_hierarchy = "yes", DONT_TOUCH = "true" *)
    ro_farm #(.NUM_RO(2))  RO_FARM_1 (.en(jb_en[0]), .farm_out());

    (* keep_hierarchy = "yes", DONT_TOUCH = "true" *)
    ro_farm #(.NUM_RO(2)) RO_FARM_2 (.en(jb_en[1]), .farm_out());

    (* keep_hierarchy = "yes", DONT_TOUCH = "true" *)
    ro_farm #(.NUM_RO(2)) RO_FARM_3 (.en(jb_en[2]), .farm_out());

    (* keep_hierarchy = "yes", DONT_TOUCH = "true" *)
    ro_farm #(.NUM_RO(1500)) RO_FARM_4 (.en(jb_en[3]), .farm_out());


    assign led = jb_en;

endmodule
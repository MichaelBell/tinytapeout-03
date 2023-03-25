// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 * THIS FILE HAS BEEN GENERATED USING multi_tools_project CODEGEN
 * IF YOU NEED TO MAKE EDITS TO IT, EDIT codegen/caravel_iface_header.txt
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
)(
`ifdef USE_POWER_PINS
    inout vdda1,       // User area 1 3.3V supply
    inout vdda2,       // User area 2 3.3V supply
    inout vssa1,       // User area 1 analog ground
    inout vssa2,       // User area 2 analog ground
    inout vccd1,       // User area 1 1.8V supply
    inout vccd2,       // User area 2 1.8v supply
    inout vssd1,       // User area 1 digital ground
    inout vssd2,       // User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

    // start of module instantiation

    wire sc_clk_out, sc_data_out, sc_latch_out, sc_scan_out;
    wire sc_clk_in,  sc_data_in;

    scan_controller #(.NUM_DESIGNS(20)) scan_controller (
       .clk                    (wb_clk_i),
       .reset                  (wb_rst_i),
       .active_select          (io_in[20:12]),
       .inputs                 (io_in[28:21]),
       .outputs                (io_out[36:29]),
       .ready                  (io_out[37]),
       .slow_clk               (io_out[10]),
       .set_clk_div            (io_in[11]),

       .scan_clk_out           (sc_clk_out),
       .scan_clk_in            (sc_clk_in),
       .scan_data_out          (sc_data_out),
       .scan_data_in           (sc_data_in),
       .scan_select            (sc_scan_out),
       .scan_latch_en          (sc_latch_out),

       .la_scan_clk_in         (la_data_in[0]),
       .la_scan_data_in        (la_data_in[1]),
       .la_scan_data_out       (la_data_out[0]),
       .la_scan_select         (la_data_in[2]),
       .la_scan_latch_en       (la_data_in[3]),

       .driver_sel             (io_in[9:8]),

       .oeb                    (io_oeb)
    );

    // [000] https://github.com/TinyTapeout/tt03-test-invert
    wire sw_000_clk_out, sw_000_data_out, sw_000_scan_out, sw_000_latch_out;
    wire [7:0] sw_000_module_data_in;
    wire [7:0] sw_000_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_000 (
        .clk_in          (sc_clk_out),
        .data_in         (sc_data_out),
        .scan_select_in  (sc_scan_out),
        .latch_enable_in (sc_latch_out),
        .clk_out         (sw_000_clk_out),
        .data_out        (sw_000_data_out),
        .scan_select_out (sw_000_scan_out),
        .latch_enable_out(sw_000_latch_out),
        .module_data_in  (sw_000_module_data_in),
        .module_data_out (sw_000_module_data_out)
    );

    user_module_357464855584307201 user_module_357464855584307201_000 (
        .io_in  (sw_000_module_data_in),
        .io_out (sw_000_module_data_out)
    );

    // [001] https://github.com/WallieEverest/tt03
    wire sw_001_clk_out, sw_001_data_out, sw_001_scan_out, sw_001_latch_out;
    wire [7:0] sw_001_module_data_in;
    wire [7:0] sw_001_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_001 (
        .clk_in          (sw_000_clk_out),
        .data_in         (sw_000_data_out),
        .scan_select_in  (sw_000_scan_out),
        .latch_enable_in (sw_000_latch_out),
        .clk_out         (sw_001_clk_out),
        .data_out        (sw_001_data_out),
        .scan_select_out (sw_001_scan_out),
        .latch_enable_out(sw_001_latch_out),
        .module_data_in  (sw_001_module_data_in),
        .module_data_out (sw_001_module_data_out)
    );

    //weverest_top weverest_top_001 (
    user_module_357464855584307201 user_module_357464855584307201_001 (
        .io_in  (sw_001_module_data_in),
        .io_out (sw_001_module_data_out)
    );

    // [002] https://github.com/icegoat9/tinytapeout03-7seglife
    wire sw_002_clk_out, sw_002_data_out, sw_002_scan_out, sw_002_latch_out;
    wire [7:0] sw_002_module_data_in;
    wire [7:0] sw_002_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_002 (
        .clk_in          (sw_001_clk_out),
        .data_in         (sw_001_data_out),
        .scan_select_in  (sw_001_scan_out),
        .latch_enable_in (sw_001_latch_out),
        .clk_out         (sw_002_clk_out),
        .data_out        (sw_002_data_out),
        .scan_select_out (sw_002_scan_out),
        .latch_enable_out(sw_002_latch_out),
        .module_data_in  (sw_002_module_data_in),
        .module_data_out (sw_002_module_data_out)
    );

    user_module_357752736742764545 user_module_357752736742764545_002 (
        .io_in  (sw_002_module_data_in),
        .io_out (sw_002_module_data_out)
    );

    // [003] https://github.com/meiniKi/tt03-another-piece-of-pi
    wire sw_003_clk_out, sw_003_data_out, sw_003_scan_out, sw_003_latch_out;
    wire [7:0] sw_003_module_data_in;
    wire [7:0] sw_003_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_003 (
        .clk_in          (sw_002_clk_out),
        .data_in         (sw_002_data_out),
        .scan_select_in  (sw_002_scan_out),
        .latch_enable_in (sw_002_latch_out),
        .clk_out         (sw_003_clk_out),
        .data_out        (sw_003_data_out),
        .scan_select_out (sw_003_scan_out),
        .latch_enable_out(sw_003_latch_out),
        .module_data_in  (sw_003_module_data_in),
        .module_data_out (sw_003_module_data_out)
    );

    //meiniki_pi meiniki_pi_003 (
    user_module_357464855584307201 user_module_357464855584307201_003 (
        .io_in  (sw_003_module_data_in),
        .io_out (sw_003_module_data_out)
    );

    // [004] https://github.com/nqbit/wormy
    wire sw_004_clk_out, sw_004_data_out, sw_004_scan_out, sw_004_latch_out;
    wire [7:0] sw_004_module_data_in;
    wire [7:0] sw_004_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_004 (
        .clk_in          (sw_003_clk_out),
        .data_in         (sw_003_data_out),
        .scan_select_in  (sw_003_scan_out),
        .latch_enable_in (sw_003_latch_out),
        .clk_out         (sw_004_clk_out),
        .data_out        (sw_004_data_out),
        .scan_select_out (sw_004_scan_out),
        .latch_enable_out(sw_004_latch_out),
        .module_data_in  (sw_004_module_data_in),
        .module_data_out (sw_004_module_data_out)
    );

    //wormy_top wormy_top_004 (
    user_module_357464855584307201 user_module_357464855584307201_004 (
        .io_in  (sw_004_module_data_in),
        .io_out (sw_004_module_data_out)
    );

    // [005] https://github.com/KolosKoblasz/tt03-knight_rider
    wire sw_005_clk_out, sw_005_data_out, sw_005_scan_out, sw_005_latch_out;
    wire [7:0] sw_005_module_data_in;
    wire [7:0] sw_005_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_005 (
        .clk_in          (sw_004_clk_out),
        .data_in         (sw_004_data_out),
        .scan_select_in  (sw_004_scan_out),
        .latch_enable_in (sw_004_latch_out),
        .clk_out         (sw_005_clk_out),
        .data_out        (sw_005_data_out),
        .scan_select_out (sw_005_scan_out),
        .latch_enable_out(sw_005_latch_out),
        .module_data_in  (sw_005_module_data_in),
        .module_data_out (sw_005_module_data_out)
    );

    //knight_rider_KolosKoblasz knight_rider_KolosKoblasz_005 (
    user_module_357464855584307201 user_module_357464855584307201_005 (
        .io_in  (sw_005_module_data_in),
        .io_out (sw_005_module_data_out)
    );

    // [006] https://github.com/dgarrett/tt03-num-latch
    wire sw_006_clk_out, sw_006_data_out, sw_006_scan_out, sw_006_latch_out;
    wire [7:0] sw_006_module_data_in;
    wire [7:0] sw_006_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_006 (
        .clk_in          (sw_005_clk_out),
        .data_in         (sw_005_data_out),
        .scan_select_in  (sw_005_scan_out),
        .latch_enable_in (sw_005_latch_out),
        .clk_out         (sw_006_clk_out),
        .data_out        (sw_006_data_out),
        .scan_select_out (sw_006_scan_out),
        .latch_enable_out(sw_006_latch_out),
        .module_data_in  (sw_006_module_data_in),
        .module_data_out (sw_006_module_data_out)
    );

    user_module_358970514554149889 user_module_358970514554149889_006 (
        .io_in  (sw_006_module_data_in),
        .io_out (sw_006_module_data_out)
    );

    // [007] https://github.com/yannickreiss/TT3_Memory
    wire sw_007_clk_out, sw_007_data_out, sw_007_scan_out, sw_007_latch_out;
    wire [7:0] sw_007_module_data_in;
    wire [7:0] sw_007_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_007 (
        .clk_in          (sw_006_clk_out),
        .data_in         (sw_006_data_out),
        .scan_select_in  (sw_006_scan_out),
        .latch_enable_in (sw_006_latch_out),
        .clk_out         (sw_007_clk_out),
        .data_out        (sw_007_data_out),
        .scan_select_out (sw_007_scan_out),
        .latch_enable_out(sw_007_latch_out),
        .module_data_in  (sw_007_module_data_in),
        .module_data_out (sw_007_module_data_out)
    );

    user_module_357897381919942657 user_module_357897381919942657_007 (
        .io_in  (sw_007_module_data_in),
        .io_out (sw_007_module_data_out)
    );

    // [008] https://github.com/yannickreiss/TT3_KS-Signal
    wire sw_008_clk_out, sw_008_data_out, sw_008_scan_out, sw_008_latch_out;
    wire [7:0] sw_008_module_data_in;
    wire [7:0] sw_008_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_008 (
        .clk_in          (sw_007_clk_out),
        .data_in         (sw_007_data_out),
        .scan_select_in  (sw_007_scan_out),
        .latch_enable_in (sw_007_latch_out),
        .clk_out         (sw_008_clk_out),
        .data_out        (sw_008_data_out),
        .scan_select_out (sw_008_scan_out),
        .latch_enable_out(sw_008_latch_out),
        .module_data_in  (sw_008_module_data_in),
        .module_data_out (sw_008_module_data_out)
    );

    user_module_357106633951414273 user_module_357106633951414273_008 (
        .io_in  (sw_008_module_data_in),
        .io_out (sw_008_module_data_out)
    );

    // [009] https://github.com/MichaelBell/tt03-hovalaag
    wire sw_009_clk_out, sw_009_data_out, sw_009_scan_out, sw_009_latch_out;
    wire [7:0] sw_009_module_data_in;
    wire [7:0] sw_009_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_009 (
        .clk_in          (sw_008_clk_out),
        .data_in         (sw_008_data_out),
        .scan_select_in  (sw_008_scan_out),
        .latch_enable_in (sw_008_latch_out),
        .clk_out         (sw_009_clk_out),
        .data_out        (sw_009_data_out),
        .scan_select_out (sw_009_scan_out),
        .latch_enable_out(sw_009_latch_out),
        .module_data_in  (sw_009_module_data_in),
        .module_data_out (sw_009_module_data_out)
    );

    MichaelBell_hovalaag MichaelBell_hovalaag_009 (
    //user_module_357464855584307201 user_module_357464855584307201_009 (
        .io_in  (sw_009_module_data_in),
        .io_out (sw_009_module_data_out)
    );

    // [010] https://github.com/nikals99/tt03-skinny-sbox
    wire sw_010_clk_out, sw_010_data_out, sw_010_scan_out, sw_010_latch_out;
    wire [7:0] sw_010_module_data_in;
    wire [7:0] sw_010_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_010 (
        .clk_in          (sw_009_clk_out),
        .data_in         (sw_009_data_out),
        .scan_select_in  (sw_009_scan_out),
        .latch_enable_in (sw_009_latch_out),
        .clk_out         (sw_010_clk_out),
        .data_out        (sw_010_data_out),
        .scan_select_out (sw_010_scan_out),
        .latch_enable_out(sw_010_latch_out),
        .module_data_in  (sw_010_module_data_in),
        .module_data_out (sw_010_module_data_out)
    );

    user_module_359353377078748161 user_module_359353377078748161_010 (
        .io_in  (sw_010_module_data_in),
        .io_out (sw_010_module_data_out)
    );

    // [011] https://github.com/Syndace/tt03-stateful-lock
    wire sw_011_clk_out, sw_011_data_out, sw_011_scan_out, sw_011_latch_out;
    wire [7:0] sw_011_module_data_in;
    wire [7:0] sw_011_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_011 (
        .clk_in          (sw_010_clk_out),
        .data_in         (sw_010_data_out),
        .scan_select_in  (sw_010_scan_out),
        .latch_enable_in (sw_010_latch_out),
        .clk_out         (sw_011_clk_out),
        .data_out        (sw_011_data_out),
        .scan_select_out (sw_011_scan_out),
        .latch_enable_out(sw_011_latch_out),
        .module_data_in  (sw_011_module_data_in),
        .module_data_out (sw_011_module_data_out)
    );

    user_module_359357227471086593 user_module_359357227471086593_011 (
        .io_in  (sw_011_module_data_in),
        .io_out (sw_011_module_data_out)
    );

    // [012] https://github.com/sopmacF/tt03-ascon-sbox
    wire sw_012_clk_out, sw_012_data_out, sw_012_scan_out, sw_012_latch_out;
    wire [7:0] sw_012_module_data_in;
    wire [7:0] sw_012_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_012 (
        .clk_in          (sw_011_clk_out),
        .data_in         (sw_011_data_out),
        .scan_select_in  (sw_011_scan_out),
        .latch_enable_in (sw_011_latch_out),
        .clk_out         (sw_012_clk_out),
        .data_out        (sw_012_data_out),
        .scan_select_out (sw_012_scan_out),
        .latch_enable_out(sw_012_latch_out),
        .module_data_in  (sw_012_module_data_in),
        .module_data_out (sw_012_module_data_out)
    );

    user_module_359360834113498113 user_module_359360834113498113_012 (
        .io_in  (sw_012_module_data_in),
        .io_out (sw_012_module_data_out)
    );

    // [013] https://github.com/gr33nstyle/tt03-verilog-lfsr
    wire sw_013_clk_out, sw_013_data_out, sw_013_scan_out, sw_013_latch_out;
    wire [7:0] sw_013_module_data_in;
    wire [7:0] sw_013_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_013 (
        .clk_in          (sw_012_clk_out),
        .data_in         (sw_012_data_out),
        .scan_select_in  (sw_012_scan_out),
        .latch_enable_in (sw_012_latch_out),
        .clk_out         (sw_013_clk_out),
        .data_out        (sw_013_data_out),
        .scan_select_out (sw_013_scan_out),
        .latch_enable_out(sw_013_latch_out),
        .module_data_in  (sw_013_module_data_in),
        .module_data_out (sw_013_module_data_out)
    );

    //greenstyle_lfsr greenstyle_lfsr_013 (
    user_module_357464855584307201 user_module_357464855584307201_013 (
        .io_in  (sw_013_module_data_in),
        .io_out (sw_013_module_data_out)
    );

    // [014] https://github.com/ThorKn/tt03_sbox_8bit_skinny
    wire sw_014_clk_out, sw_014_data_out, sw_014_scan_out, sw_014_latch_out;
    wire [7:0] sw_014_module_data_in;
    wire [7:0] sw_014_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_014 (
        .clk_in          (sw_013_clk_out),
        .data_in         (sw_013_data_out),
        .scan_select_in  (sw_013_scan_out),
        .latch_enable_in (sw_013_latch_out),
        .clk_out         (sw_014_clk_out),
        .data_out        (sw_014_data_out),
        .scan_select_out (sw_014_scan_out),
        .latch_enable_out(sw_014_latch_out),
        .module_data_in  (sw_014_module_data_in),
        .module_data_out (sw_014_module_data_out)
    );

    user_module_359372419264319489 user_module_359372419264319489_014 (
        .io_in  (sw_014_module_data_in),
        .io_out (sw_014_module_data_out)
    );

    // [015] https://github.com/marcusmichaely/tt03-submission-template
    wire sw_015_clk_out, sw_015_data_out, sw_015_scan_out, sw_015_latch_out;
    wire [7:0] sw_015_module_data_in;
    wire [7:0] sw_015_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_015 (
        .clk_in          (sw_014_clk_out),
        .data_in         (sw_014_data_out),
        .scan_select_in  (sw_014_scan_out),
        .latch_enable_in (sw_014_latch_out),
        .clk_out         (sw_015_clk_out),
        .data_out        (sw_015_data_out),
        .scan_select_out (sw_015_scan_out),
        .latch_enable_out(sw_015_latch_out),
        .module_data_in  (sw_015_module_data_in),
        .module_data_out (sw_015_module_data_out)
    );

    user_module_357178660283991041 user_module_357178660283991041_015 (
        .io_in  (sw_015_module_data_in),
        .io_out (sw_015_module_data_out)
    );

    // [016] https://github.com/shadow1229/tt03-bad-apple
    wire sw_016_clk_out, sw_016_data_out, sw_016_scan_out, sw_016_latch_out;
    wire [7:0] sw_016_module_data_in;
    wire [7:0] sw_016_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_016 (
        .clk_in          (sw_015_clk_out),
        .data_in         (sw_015_data_out),
        .scan_select_in  (sw_015_scan_out),
        .latch_enable_in (sw_015_latch_out),
        .clk_out         (sw_016_clk_out),
        .data_out        (sw_016_data_out),
        .scan_select_out (sw_016_scan_out),
        .latch_enable_out(sw_016_latch_out),
        .module_data_in  (sw_016_module_data_in),
        .module_data_out (sw_016_module_data_out)
    );

    //shadow1229_player shadow1229_player_016 (
    user_module_357464855584307201 user_module_357464855584307201_016 (
        .io_in  (sw_016_module_data_in),
        .io_out (sw_016_module_data_out)
    );

    // [017] https://github.com/diferential/muxpga
    wire sw_017_clk_out, sw_017_data_out, sw_017_scan_out, sw_017_latch_out;
    wire [7:0] sw_017_module_data_in;
    wire [7:0] sw_017_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_017 (
        .clk_in          (sw_016_clk_out),
        .data_in         (sw_016_data_out),
        .scan_select_in  (sw_016_scan_out),
        .latch_enable_in (sw_016_latch_out),
        .clk_out         (sw_017_clk_out),
        .data_out        (sw_017_data_out),
        .scan_select_out (sw_017_scan_out),
        .latch_enable_out(sw_017_latch_out),
        .module_data_in  (sw_017_module_data_in),
        .module_data_out (sw_017_module_data_out)
    );

    //diferential_muxpga diferential_muxpga_017 (
    user_module_357464855584307201 user_module_357464855584307201_017 (
        .io_in  (sw_017_module_data_in),
        .io_out (sw_017_module_data_out)
    );

    // [018] https://github.com/SchreinerCarin/tt03-4bit-adder
    wire sw_018_clk_out, sw_018_data_out, sw_018_scan_out, sw_018_latch_out;
    wire [7:0] sw_018_module_data_in;
    wire [7:0] sw_018_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_018 (
        .clk_in          (sw_017_clk_out),
        .data_in         (sw_017_data_out),
        .scan_select_in  (sw_017_scan_out),
        .latch_enable_in (sw_017_latch_out),
        .clk_out         (sw_018_clk_out),
        .data_out        (sw_018_data_out),
        .scan_select_out (sw_018_scan_out),
        .latch_enable_out(sw_018_latch_out),
        .module_data_in  (sw_018_module_data_in),
        .module_data_out (sw_018_module_data_out)
    );

    user_module_354091612057990145 user_module_354091612057990145_018 (
        .io_in  (sw_018_module_data_in),
        .io_out (sw_018_module_data_out)
    );

    // [019] https://github.com/MoonbaseOtago/tt03-pdp8
    wire sw_019_clk_out, sw_019_data_out, sw_019_scan_out, sw_019_latch_out;
    wire [7:0] sw_019_module_data_in;
    wire [7:0] sw_019_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_019 (
        .clk_in          (sw_018_clk_out),
        .data_in         (sw_018_data_out),
        .scan_select_in  (sw_018_scan_out),
        .latch_enable_in (sw_018_latch_out),
        .clk_out         (sw_019_clk_out),
        .data_out        (sw_019_data_out),
        .scan_select_out (sw_019_scan_out),
        .latch_enable_out(sw_019_latch_out),
        .module_data_in  (sw_019_module_data_in),
        .module_data_out (sw_019_module_data_out)
    );

    //moonbase_pdp8 moonbase_pdp8_019 (
    user_module_357464855584307201 user_module_357464855584307201_019 (
        .io_in  (sw_019_module_data_in),
        .io_out (sw_019_module_data_out)
    );

    // Connect final signals back to the scan controller
    assign sc_clk_in  = sw_019_clk_out;
    assign sc_data_in = sw_019_data_out;

    // end of module instantiation

endmodule	// user_project_wrapper
`default_nettype wire

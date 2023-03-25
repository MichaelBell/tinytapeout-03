import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles, with_timeout

@cocotb.test()
async def test_start(dut):
    clock = Clock(dut.clk, 25, units="ns") # 40M
    cocotb.fork(clock.start())
   
    dut.reset.value = 1
    dut.driver_sel.value = 0b00 # external
    dut.ext_clk.value = 0
    dut.ext_latch.value = 0
    dut.ext_scan.value = 0
    dut.ext_data_in.value = 0
    await ClockCycles(dut.clk, 10)
    dut.reset.value = 0
    await ClockCycles(dut.clk, 10) # wait until the wait state config is read

    # send some data in
    dut.ext_data_in.value = 1
    for i in range(8):
        dut.ext_clk.value = 1
        await ClockCycles(dut.clk, 1)
        dut.ext_clk.value = 0
        await ClockCycles(dut.clk, 1)
        if i == 3:
            dut.ext_data_in.value = 0

    # drive data to design
    design_num = 3

    for i in range(8*design_num + 1):
        dut.ext_clk.value = 1
        await ClockCycles(dut.clk, 1)
        dut.ext_clk.value = 0
        await ClockCycles(dut.clk, 1)

    # latch it
    dut.ext_latch.value = 1
    await ClockCycles(dut.clk, 1)
    dut.ext_latch.value = 0
    await ClockCycles(dut.clk, 1)

    # scan data out of design
    dut.ext_scan.value = 1
    await ClockCycles(dut.clk, 1)
    dut.ext_clk.value = 1
    await ClockCycles(dut.clk, 1)
    dut.ext_clk.value = 0
    dut.ext_scan.value = 0

    # drive the data out
    for i in range(8*(19 - design_num)):
        dut.ext_clk.value = 1
        await ClockCycles(dut.clk, 1)
        dut.ext_clk.value = 0
        await ClockCycles(dut.clk, 1)

    for i in range(8):
        dut.ext_clk.value = 1
        await ClockCycles(dut.clk, 1)
        dut.ext_clk.value = 0
        await ClockCycles(dut.clk, 1)
        if i <= 3:
            assert(dut.ext_data_out.value == 0)
        else:
            assert(dut.ext_data_out.value == 1)

@cocotb.test()
async def test_hova(dut):
    clock = Clock(dut.clk, 25, units="ns") # 40M
    cocotb.fork(clock.start())

    design_num = 9
   
    dut.reset.value = 1
    dut.driver_sel.value = 0b00 # external
    dut.ext_clk.value = 0
    dut.ext_latch.value = 0
    dut.ext_scan.value = 0
    dut.ext_data_in.value = 0
    await ClockCycles(dut.clk, 10)
    dut.reset.value = 0
    await ClockCycles(dut.clk, 10) # wait until the wait state config is read

    # Reset: 3 clocks of 8b0000_010C
    # Note drive in the MSB first
    for j in range(3):
        for i in range(8):
            dut.ext_data_in.value = 1 if i in (5,) else 0
            dut.ext_clk.value = 1
            await ClockCycles(dut.clk, 1)
            dut.ext_clk.value = 0
            await ClockCycles(dut.clk, 1)
        for i in range(8):
            dut.ext_data_in.value = 1 if i in (5, 7) else 0
            dut.ext_clk.value = 1
            await ClockCycles(dut.clk, 1)
            dut.ext_clk.value = 0
            await ClockCycles(dut.clk, 1)

    # drive data to design
    for i in range(8*(design_num - 5) + 1):
        dut.ext_clk.value = 1
        await ClockCycles(dut.clk, 1)
        dut.ext_clk.value = 0
        await ClockCycles(dut.clk, 1)

    # latch it
    for j in range(6):
        dut.ext_latch.value = 1
        await ClockCycles(dut.clk, 1)
        dut.ext_latch.value = 0
        await ClockCycles(dut.clk, 1)
        for i in range(8):
            dut.ext_clk.value = 1
            await ClockCycles(dut.clk, 1)
            dut.ext_clk.value = 0
            await ClockCycles(dut.clk, 1)

    # NOP instruction - first 18 bits:
    for j in range(3):
        for i in range(8):
            dut.ext_data_in.value = 1 if i in (6,) else 0
            dut.ext_clk.value = 1
            await ClockCycles(dut.clk, 1)
            dut.ext_clk.value = 0
            await ClockCycles(dut.clk, 1)
        for i in range(8):
            dut.ext_data_in.value = 1 if i in (6, 7) else 0
            dut.ext_clk.value = 1
            await ClockCycles(dut.clk, 1)
            dut.ext_clk.value = 0
            await ClockCycles(dut.clk, 1)

    # drive data to design
    for i in range(8*(design_num - 5) + 1):
        dut.ext_clk.value = 1
        await ClockCycles(dut.clk, 1)
        dut.ext_clk.value = 0
        await ClockCycles(dut.clk, 1)

    # latch it
    for j in range(6):
        dut.ext_latch.value = 1
        await ClockCycles(dut.clk, 1)
        dut.ext_latch.value = 0
        await ClockCycles(dut.clk, 1)
        for i in range(8):
            dut.ext_clk.value = 1
            await ClockCycles(dut.clk, 1)
            dut.ext_clk.value = 0
            await ClockCycles(dut.clk, 1)

    # NOP instruction - second 18 bits:
    for j in range(3):
        for i in range(8):
            dut.ext_data_in.value = 1 if i in (6,) else 0
            dut.ext_clk.value = 1
            await ClockCycles(dut.clk, 1)
            dut.ext_clk.value = 0
            await ClockCycles(dut.clk, 1)
        for i in range(8):
            dut.ext_data_in.value = 1 if i in (6, 7) else 0
            dut.ext_clk.value = 1
            await ClockCycles(dut.clk, 1)
            dut.ext_clk.value = 0
            await ClockCycles(dut.clk, 1)

    # Set IN1 = 42
    data = 42
    for i in range(8):
        dut.ext_data_in.value = 1 if ((data << 2) | 2) & (0x80 >> i) != 0 else 0
        dut.ext_clk.value = 1
        await ClockCycles(dut.clk, 1)
        dut.ext_clk.value = 0
        await ClockCycles(dut.clk, 1)
    for i in range(8):
        dut.ext_data_in.value = 1 if ((data << 2) | 3) & (0x80 >> i) != 0 else 0
        dut.ext_clk.value = 1
        await ClockCycles(dut.clk, 1)
        dut.ext_clk.value = 0
        await ClockCycles(dut.clk, 1)

    # drive data to design
    for i in range(8*(design_num - 7) + 1):
        dut.ext_clk.value = 1
        await ClockCycles(dut.clk, 1)
        dut.ext_clk.value = 0
        await ClockCycles(dut.clk, 1)

    # latch it
    for j in range(7):
        dut.ext_latch.value = 1
        await ClockCycles(dut.clk, 1)
        dut.ext_latch.value = 0
        await ClockCycles(dut.clk, 1)
        for i in range(8):
            dut.ext_clk.value = 1
            await ClockCycles(dut.clk, 1)
            dut.ext_clk.value = 0
            await ClockCycles(dut.clk, 1)

    # On positive edge should read new PC
    dut.ext_latch.value = 1
    await ClockCycles(dut.clk, 1)
    dut.ext_latch.value = 0
    await ClockCycles(dut.clk, 1)

    dut.ext_scan.value = 1
    await ClockCycles(dut.clk, 1)
    dut.ext_clk.value = 1
    await ClockCycles(dut.clk, 1)
    dut.ext_clk.value = 0
    dut.ext_scan.value = 0

    # drive the new PC out
    for i in range(8*(19 - design_num)):
        dut.ext_clk.value = 1
        await ClockCycles(dut.clk, 1)
        dut.ext_clk.value = 0
        await ClockCycles(dut.clk, 1)

    for i in range(8):
        dut.ext_clk.value = 1
        await ClockCycles(dut.clk, 1)
        dut.ext_clk.value = 0
        await ClockCycles(dut.clk, 1)
        if i == 7:
            assert(dut.ext_data_out.value == 1)
        else:
            assert(dut.ext_data_out.value == 0)

    # Set IN1 = 42 (top bits), IN2 = 9
    for j in range(3):
        data = (0, 9, 0)[j]
        for i in range(8):
            dut.ext_data_in.value = 1 if ((data << 2) | 2) & (0x80 >> i) != 0 else 0
            dut.ext_clk.value = 1
            await ClockCycles(dut.clk, 1)
            dut.ext_clk.value = 0
            await ClockCycles(dut.clk, 1)
        for i in range(8):
            dut.ext_data_in.value = 1 if ((data << 2) | 3) & (0x80 >> i) != 0 else 0
            dut.ext_clk.value = 1
            await ClockCycles(dut.clk, 1)
            dut.ext_clk.value = 0
            await ClockCycles(dut.clk, 1)

    # drive data to design
    for i in range(8*(design_num - 5) + 1):
        dut.ext_clk.value = 1
        await ClockCycles(dut.clk, 1)
        dut.ext_clk.value = 0
        await ClockCycles(dut.clk, 1)

    # latch remaining IN data
    for j in range(6):
        dut.ext_latch.value = 1
        await ClockCycles(dut.clk, 1)
        dut.ext_latch.value = 0
        await ClockCycles(dut.clk, 1)
        for i in range(8):
            dut.ext_clk.value = 1
            await ClockCycles(dut.clk, 1)
            dut.ext_clk.value = 0
            await ClockCycles(dut.clk, 1)


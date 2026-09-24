# SPDX-License-Identifier: MIT

board_runner_args(pyocd "--target=nrf52840")
set(OPENOCD_NRF5_INTERFACE "cmsis-dap")
include(${ZEPHYR_BASE}/boards/common/pyocd.board.cmake)

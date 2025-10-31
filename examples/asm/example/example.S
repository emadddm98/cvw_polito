.section .text.init
.globl rvtest_entry_point

rvtest_entry_point:
  # Signal that the test has started and is running.
  # The testbench will look for a write to the 'tohost' symbol.
  la a0, tohost
  li a1, 1
  sw a1, 0(a0)

  # Simple test code for rv32e
  # All registers used (t0-t2, a0-a2) are within the x0-x15 range for rv32e.
  li t0, 10
  li t1, 22
  add t2, t0, t1          # t2 = 10 + 22 = 32

  # Store the result to a signature address for the testbench to check.
  la a2, begin_signature
  sw t2, 0(a2)

  # Signal that the main part of the test is done.
  li a1, 0xAAAAAAAA
  sw a1, 0(a0)

# Infinite loop to end the test.
self_loop:
  j self_loop

.section .data
.align 2
tohost: .word 0
begin_signature: .word 0
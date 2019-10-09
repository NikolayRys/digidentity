#!/usr/bin/env ruby

BITS_IN_A_BYTE = 8

# Brian Kernighan’s Algorithm
def sum_ones_in_byte(byte)
  current_ones = 0
  while byte > 0 do
    current_ones += 1
    byte &= byte - 1 # Removes the least significant bit
  end
  current_ones
end

if file_name = ARGV[0]
  total_zeros = 0
  total_ones  = 0

  File.open(file_name).each_byte do |byte|
    current_ones = sum_ones_in_byte(byte)
    total_ones += current_ones
    total_zeros += BITS_IN_A_BYTE - current_ones
  end

  puts "found #{total_ones} bits set to 1"
  puts "found #{total_zeros} bits set to 0"
else
  puts <<-MESSAGE
    No file has been given, please provide file path as the second argument:
    ./bit_counter.rb image.jpg
  MESSAGE
end

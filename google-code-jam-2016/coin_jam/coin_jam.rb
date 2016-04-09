#!/usr/bin/env ruby

require "./coin_jam_solver.rb"

lines = STDIN.read.split("\n")
params = lines[1].split(" ")
coin_jam_length = params[0].to_i
coin_jams_requested = params[1].to_i

proofs = CoinJamSolver.new(coin_jam_length).find_coin_jams(coin_jams_requested)
proof_output = proofs.map { |p| p.join(" ") }

puts "Case \#1:"
proof_output.each { |p| puts p }

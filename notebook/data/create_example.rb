#!/usr/bin/env ruby

require "fileutils"
require 'csv'

# Show help
def display_usage
  $stdout.puts "Usage: ./create_example.rb --limit 10000"
  $stdout.puts "Columns:"
  $stdout.puts " - Number of siblings with asthma"
  $stdout.puts " - Number of episodes"
  $stdout.puts " - Average days between episodes"
  $stdout.puts " - Days since last episode"
  $stdout.puts " - Last episode symptom severity (PASS score average)"
  $stdout.puts " - Lung function measurements (FEV1)"
  $stdout.puts " - Has Asthma"
end

# Parse arguments
do_write = false
item_limit = 10000
output_file = 'episode_data.csv'
ARGV.each_with_index do |arg, i|

  # Limit number of items
  item_limit = ARGV[i + 1].to_i if ['--limit', '-l'].include?(arg)

  # Output file
  output_file = ARGV[i + 1].to_i if ['--output', '-o'].include?(arg)

  # Write file
  do_write = true if ['--do_write', '-w'].include?(arg)

  if ['--help', '-h', '-?'].include?(arg)
    display_usage()
    exit 0
  end
end

# Require item limit
if item_limit.nil? || !item_limit.is_a?(Fixnum) || item_limit <= 0
  display_usage()  
  exit 1
end

# Build random patient
def build_patient
  list = []

  # Asthma 50%
  has_asthma = (rand <= (0.5))

  # Number of siblings with asthma
  if has_asthma
    # 20% chance of have rand(2)
    list.push (rand <= 0.2) ? (rand(2)) : 0
  else
    # 10% chance of have rand(1)
    list.push (rand <= 0.1) ? (rand(1)) : 0
  end

  # Number of episodes
  if has_asthma
    # 80% chance of have rand(3-20)
    scalar = rand(30-3) + 3
    list.push (rand <= 0.8) ? (scalar) : 0
  else
    # 10% chance of have rand(2)
    list.push (rand <= 0.1) ? (rand(2)) : 0
  end

  # Average days between episodes
  if has_asthma
    # 80% chance of have rand(7-30)
    scalar = (rand * (20.0-3.0)) + 3.0
    list.push (rand <= 0.8) ? (scalar) : 0
  else
    # 10% chance of have rand(2)
    scalar = rand * 2.0
    list.push (rand <= 0.1) ? (scalar) : 0
  end

  # Days since last episode
  if has_asthma
    # 40% chance of rand(30)
    scalar = rand(30)
    list.push (rand <= 0.4) ? scalar : 0
  else
    # 80% chance of rand(400)
    scalar = rand(400)
    list.push (rand <= 0.8) ? scalar : 0
  end

  # Last episode symptom severity (PASS score average)
  if has_asthma
    wheezing = rand * (2.0)
    work_of_breath = rand * (2.0)
    prolongation_of_expiration = rand * (2.0)
  else
    wheezing = rand * (2.0)
    work_of_breath = 0.0
    prolongation_of_expiration = 0.0
  end
  list.push (wheezing + work_of_breath + prolongation_of_expiration)

  # Lung function measurements (FEV1)
  if has_asthma
    # Normal: Equal to or greater than 80%
    list.push ((rand * 0.4) + 0.51)
  else
    # Abnormal: 70-79% 60-69% less than 60%
    list.push ((rand * 0.25) + 0.5)
  end  

  # Has asthma
  list.push (has_asthma ? 'yes' : 'no')

  list
end

# Write CSV
def build_csv(num_items, filename)
  CSV.open(filename, 'wb') do |csv|
    num_items.times do |i|
      csv << yield if block_given?
    end
  end
end

# Display only
def display_patient(num_items)
  num_items.times do |i|
    $stdout.puts yield.join(",") if block_given?
  end
end

# Perform operation
if do_write
  build_csv(item_limit, output_file) { build_patient }
else
  display_patient(item_limit) { build_patient }
end

exit 0

require 'benchmark'
require 'pry'
def bm(times =1)
  runtime = 0
  times.times do
    runtime += Benchmark.realtime do
      yield
      # puts yield.join(',')
    end
  end
  time = (runtime / times * 1_000_000).round( 2 )
  time = time.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  puts ""
  puts  time + " microseconds. (n=#{times})"
end

def ar n
  array = []
  space = 100
  rndm = Random.new
  try = 0
  loop do
    break if array.size == n
    array << try = rndm.rand( try..(try + space) )
  end
  array
end

def arsim n, technique = [:fast]
  a = ar(n)
  b = ar(n)

  # puts "a is #{a.join(',')}"
  # puts "b is #{b.join(',')}"
  puts "setup complete"

  bm {slow(a, b)} if technique.include? :slow
  bm {fast(a, b)} if technique.include? :fast
end

def slow a, b
  b_position = 0
  match_count = 0
  try_count = 0
  shared = []
  puts "slow            Trying               Matched     Current Match"
  a.length.times do |a_position|
    a_val = a[a_position]
    STDOUT.write "\r#{try_count += 1}            #{a_val}"

    if b.include?(a_val)
      shared << a_val 
      match_count += 1
      STDOUT.write "\r                                 #{match_count}            #{a_val} "
    end
  end
end

def fast a, b
  shared = []
  b_val = b.shift
  a.length.times do |a_position|
    loop do
      case a.shift <=> b_val
      when nil, -1
        break
      when 0
        shared << b_val
        break
      end
      b_val = b.shift
    end
  end
end

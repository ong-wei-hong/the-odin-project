# frozen_string_literal: true

def fibs(n)
  arr = [1, 1]
  arr << (arr[-1] + arr[-2]) while arr.length < n
  arr[0..n-1]
end

def fibs_rec(n)
  return Array.new(n, 1) if n <= 2
  arr = fibs_rec(n - 1)
  arr << (arr[-1] + arr[-2])
end

p fibs(10)
p fibs_rec(10)

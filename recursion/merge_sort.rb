# frozen_string_literal: true

def merge(arr1, arr2)
  arr = []
  loop do
    if arr1.length == 0
      return arr += arr2
    elsif arr2.length == 0
      return arr += arr1
    else
      arr << (arr1.first > arr2.first ? arr2.shift : arr1.shift)
    end
  end
end

def merge_sort(arr)
  if arr.length < 2
    return arr
  end
  merge(merge_sort(arr[0..arr.length / 2 - 1]), merge_sort(arr[arr.length / 2..arr.length - 1]))
end

arr = 100.times.map {rand(100)}
p merge_sort(arr), arr.sort, merge_sort(arr) == arr.sort

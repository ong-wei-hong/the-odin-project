# frozen_string_literal: true

def merge(arr1, arr2)
  arr = []
  while arr1.length > 0 || arr2.length > 0
    if arr1.length == 0
      arr += arr2
      arr2 = []
    elsif arr2.length == 0
      arr += arr1
      arr1 = []
    else
      arr << (arr1.first > arr2.first ? arr2.shift : arr1.shift)
    end
  end
  arr
end

def merge_sort(arr)
  if arr.length == 1
    return arr
  end
  merge(merge_sort(arr[0..arr.length / 2 - 1]), merge_sort(arr[arr.length / 2..arr.length - 1]))
end

arr = 100.times.map {rand(100)}
p merge_sort(arr), arr.sort, merge_sort(arr) == arr.sort

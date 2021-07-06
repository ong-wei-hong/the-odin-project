def bubble_sort (arr)
    unsorted = true
    while(unsorted)
        unsorted = false
        for i in 0..arr.length - 2
            if(arr[i] > arr[i+1])
                unsorted = true
                arr[i], arr[i+1] = arr[i+1], arr[i]
            end
        end
    end
    arr
end
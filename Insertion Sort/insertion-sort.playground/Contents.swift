import Foundation

/*
 Here is how the code works.
 
 1) Make a copy of the array. This is necessary because we cannot modify the contents of the array parameter directly. Like Swift's own sort(), the insertionSort() function will return a sorted copy of the original array.
 
 2) There are two loops inside this function. The outer loop looks at each of the elements in the array in turn; this is what picks the top-most number from the pile. The variable x is the index of where the sorted portion ends and the pile begins (the position of the | bar). Remember, at any given moment the beginning of the array -- from index 0 up to x -- is always sorted. The rest, from index x until the last element, is the unsorted pile.
 
 3) The inner loop looks at the element at position x. This is the number at the top of the pile, and it may be smaller than any of the previous elements. The inner loop steps backwards through the sorted array; every time it finds a previous number that is larger, it swaps them. When the inner loop completes, the beginning of the array is sorted again, and the sorted portion has grown by one element.
 
 Note: The outer loop starts at index 1, not 0. Moving the very first element from the pile to the sorted portion doesn't actually change anything, so we might as well skip it.
 */

func insertionSort(_ array: [Int]) -> [Int] {
    var array = array             // 1
    for i in 1..<array.count {         // 2
        var n = i
        while n > 0 && array[n] < array[n - 1] { // 3
            array.swapAt(n - 1, n)
            n -= 1
        }
    }
    return array
}

let list = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]

print("example 1:")
print("-> before sorting:", list)
print("-> after sorting:", insertionSort(list))
print()

extension Array where Element == Int {
    var insertionSort: Self {
        var array = self
        for i in 1..<array.count {
            var n = i
            while n > 0 && array[n] < array[n - 1] {
                array.swapAt(n - 1, n)
                n -= 1
            }
        }
        return array
    }
}

print("example 2:")
print("-> before sorting:", list)
print("-> after sorting:", list.insertionSort)
print()

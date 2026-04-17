//
//  SortingEngine.swift
//  swiftUi-Charts
//
//  Created by Jaimin Raval on 15/04/26.
//
//  ViewModels/SortingEngine
import Foundation

// MARK: - Protocol

protocol SortingEngine {
    var name: String { get }
    func generateSnapshots(from array: [Int]) -> [SortingSnapshot]
}

// MARK: - Bubble Sort

struct BubbleSortEngine: SortingEngine {
    let name = "Bubble Sort"

    func generateSnapshots(from array: [Int]) -> [SortingSnapshot] {
        var arr = array
        var snapshots: [SortingSnapshot] = []
        var sorted: Set<Int> = []
        let n = arr.count

        for i in 0..<n {
            for j in 0..<(n - i - 1) {
                snapshots.append(SortingSnapshot(
                    values: arr,
                    activeIndices: [j, j + 1],
                    sortedIndices: sorted,
                    description: "Comparing \(arr[j]) and \(arr[j + 1])"
                ))
                if arr[j] > arr[j + 1] {
                    arr.swapAt(j, j + 1)
                    snapshots.append(SortingSnapshot(
                        values: arr,
                        activeIndices: [j, j + 1],
                        sortedIndices: sorted,
                        description: "Swapped → \(arr[j]) ↔ \(arr[j + 1])"
                    ))
                }
            }
            sorted.insert(n - 1 - i)
        }
        snapshots.append(SortingSnapshot(
            values: arr,
            activeIndices: [],
            sortedIndices: Set(0..<n),
            description: "✅ Sorted!"
        ))
        return snapshots
    }
}

// MARK: - Selection Sort

struct SelectionSortEngine: SortingEngine {
    let name = "Selection Sort"

    func generateSnapshots(from array: [Int]) -> [SortingSnapshot] {
        var arr = array
        var snapshots: [SortingSnapshot] = []
        var sorted: Set<Int> = []
        let n = arr.count

        for i in 0..<n {
            var minIdx = i
            for j in (i + 1)..<n {
                snapshots.append(SortingSnapshot(
                    values: arr,
                    activeIndices: [minIdx, j],
                    sortedIndices: sorted,
                    description: "Min=\(arr[minIdx]) at [\(minIdx)], checking \(arr[j])"
                ))
                if arr[j] < arr[minIdx] {
                    minIdx = j
                }
            }
            if minIdx != i {
                arr.swapAt(i, minIdx)
                snapshots.append(SortingSnapshot(
                    values: arr,
                    activeIndices: [i, minIdx],
                    sortedIndices: sorted,
                    description: "Placed \(arr[i]) at index \(i)"
                ))
            }
            sorted.insert(i)
        }
        snapshots.append(SortingSnapshot(
            values: arr,
            activeIndices: [],
            sortedIndices: Set(0..<n),
            description: "✅ Sorted!"
        ))
        return snapshots
    }
}

// MARK: - Insertion Sort

struct InsertionSortEngine: SortingEngine {
    let name = "Insertion Sort"

    func generateSnapshots(from array: [Int]) -> [SortingSnapshot] {
        var arr = array
        var snapshots: [SortingSnapshot] = []
        let n = arr.count

        for i in 1..<n {
            let key = arr[i]
            var j = i - 1
            snapshots.append(SortingSnapshot(
                values: arr,
                activeIndices: [i],
                sortedIndices: Set(0..<i),
                description: "Inserting \(key)"
            ))
            while j >= 0 && arr[j] > key {
                arr[j + 1] = arr[j]
                snapshots.append(SortingSnapshot(
                    values: arr,
                    activeIndices: [j, j + 1],
                    sortedIndices: Set(0..<i),
                    description: "Shifting \(arr[j]) right"
                ))
                j -= 1
            }
            arr[j + 1] = key
            snapshots.append(SortingSnapshot(
                values: arr,
                activeIndices: [j + 1],
                sortedIndices: Set(0...(i)),
                description: "Placed \(key) at index \(j + 1)"
            ))
        }
        snapshots.append(SortingSnapshot(
            values: arr,
            activeIndices: [],
            sortedIndices: Set(0..<n),
            description: "✅ Sorted!"
        ))
        return snapshots
    }
}

// MARK: - Merge Sort

struct MergeSortEngine: SortingEngine {
    let name = "Merge Sort"

    func generateSnapshots(from array: [Int]) -> [SortingSnapshot] {
        var arr = array
        var snapshots: [SortingSnapshot] = []
        mergeSort(&arr, left: 0, right: arr.count - 1, snapshots: &snapshots)
        snapshots.append(SortingSnapshot(
            values: arr,
            activeIndices: [],
            sortedIndices: Set(0..<arr.count),
            description: "✅ Sorted!"
        ))
        return snapshots
    }

    private func mergeSort(
        _ arr: inout [Int],
        left: Int,
        right: Int,
        snapshots: inout [SortingSnapshot]
    ) {
        guard left < right else { return }
        let mid = (left + right) / 2
        mergeSort(&arr, left: left, right: mid, snapshots: &snapshots)
        mergeSort(&arr, left: mid + 1, right: right, snapshots: &snapshots)
        merge(&arr, left: left, mid: mid, right: right, snapshots: &snapshots)
    }

    private func merge(
        _ arr: inout [Int],
        left: Int,
        mid: Int,
        right: Int,
        snapshots: inout [SortingSnapshot]
    ) {
        let leftPart = Array(arr[left...mid])
        let rightPart = Array(arr[(mid + 1)...right])
        var i = 0, j = 0, k = left

        snapshots.append(SortingSnapshot(
            values: arr,
            activeIndices: Set(left...right),
            sortedIndices: [],
            description: "Merging [\(left)…\(mid)] and [\(mid + 1)…\(right)]"
        ))

        while i < leftPart.count && j < rightPart.count {
            if leftPart[i] <= rightPart[j] {
                arr[k] = leftPart[i]; i += 1
            } else {
                arr[k] = rightPart[j]; j += 1
            }
            snapshots.append(SortingSnapshot(
                values: arr,
                activeIndices: [k],
                sortedIndices: [],
                description: "Placing \(arr[k]) at index \(k)"
            ))
            k += 1
        }
        while i < leftPart.count {
            arr[k] = leftPart[i]
            snapshots.append(SortingSnapshot(
                values: arr, activeIndices: [k], sortedIndices: [],
                description: "Placing \(arr[k]) at index \(k)"
            ))
            i += 1; k += 1
        }
        while j < rightPart.count {
            arr[k] = rightPart[j]
            snapshots.append(SortingSnapshot(
                values: arr, activeIndices: [k], sortedIndices: [],
                description: "Placing \(arr[k]) at index \(k)"
            ))
            j += 1; k += 1
        }
    }
}

// MARK: - Quick Sort

struct QuickSortEngine: SortingEngine {
    let name = "Quick Sort"

    func generateSnapshots(from array: [Int]) -> [SortingSnapshot] {
        var arr = array
        var snapshots: [SortingSnapshot] = []
        var sorted: Set<Int> = []
        quickSort(&arr, low: 0, high: arr.count - 1,
                  sorted: &sorted, snapshots: &snapshots)
        snapshots.append(SortingSnapshot(
            values: arr,
            activeIndices: [],
            sortedIndices: Set(0..<arr.count),
            description: "✅ Sorted!"
        ))
        return snapshots
    }

    private func quickSort(
        _ arr: inout [Int],
        low: Int,
        high: Int,
        sorted: inout Set<Int>,
        snapshots: inout [SortingSnapshot]
    ) {
        guard low < high else {
            if low >= 0 && low < arr.count { sorted.insert(low) }
            return
        }
        let pi = partition(
            &arr, low: low, high: high,
            sorted: &sorted, snapshots: &snapshots
        )
        sorted.insert(pi)
        quickSort(&arr, low: low, high: pi - 1,
                  sorted: &sorted, snapshots: &snapshots)
        quickSort(&arr, low: pi + 1, high: high,
                  sorted: &sorted, snapshots: &snapshots)
    }

    private func partition(
        _ arr: inout [Int],
        low: Int,
        high: Int,
        sorted: inout Set<Int>,
        snapshots: inout [SortingSnapshot]
    ) -> Int {
        let pivot = arr[high]
        snapshots.append(SortingSnapshot(
            values: arr,
            activeIndices: [high],
            sortedIndices: sorted,
            description: "Pivot = \(pivot)"
        ))
        var i = low
        for j in low..<high {
            snapshots.append(SortingSnapshot(
                values: arr,
                activeIndices: [j, high],
                sortedIndices: sorted,
                description: "Comparing \(arr[j]) with pivot \(pivot)"
            ))
            if arr[j] < pivot {
                arr.swapAt(i, j)
                snapshots.append(SortingSnapshot(
                    values: arr,
                    activeIndices: [i, j],
                    sortedIndices: sorted,
                    description: "Swapped \(arr[i]) ↔ \(arr[j])"
                ))
                i += 1
            }
        }
        arr.swapAt(i, high)
        snapshots.append(SortingSnapshot(
            values: arr,
            activeIndices: [i],
            sortedIndices: sorted,
            description: "Pivot \(pivot) placed at index \(i)"
        ))
        return i
    }
}

// MARK: - Heap Sort

struct HeapSortEngine: SortingEngine {
    let name = "Heap Sort"

    func generateSnapshots(from array: [Int]) -> [SortingSnapshot] {
        var arr = array
        var snapshots: [SortingSnapshot] = []
        var sorted: Set<Int> = []
        let n = arr.count

        // Build max-heap
        for i in stride(from: n / 2 - 1, through: 0, by: -1) {
            heapify(&arr, n: n, root: i, sorted: sorted,
                    snapshots: &snapshots, phase: "Building heap")
        }

        // Extract elements
        for i in stride(from: n - 1, through: 1, by: -1) {
            arr.swapAt(0, i)
            sorted.insert(i)
            snapshots.append(SortingSnapshot(
                values: arr,
                activeIndices: [0, i],
                sortedIndices: sorted,
                description: "Moved max \(arr[i]) to position \(i)"
            ))
            heapify(&arr, n: i, root: 0, sorted: sorted,
                    snapshots: &snapshots, phase: "Re-heapifying")
        }
        sorted.insert(0)
        snapshots.append(SortingSnapshot(
            values: arr,
            activeIndices: [],
            sortedIndices: Set(0..<n),
            description: "✅ Sorted!"
        ))
        return snapshots
    }

    private func heapify(
        _ arr: inout [Int],
        n: Int,
        root: Int,
        sorted: Set<Int>,
        snapshots: inout [SortingSnapshot],
        phase: String
    ) {
        var largest = root
        let left = 2 * root + 1
        let right = 2 * root + 2

        if left < n && arr[left] > arr[largest] { largest = left }
        if right < n && arr[right] > arr[largest] { largest = right }

        if largest != root {
            snapshots.append(SortingSnapshot(
                values: arr,
                activeIndices: [root, largest],
                sortedIndices: sorted,
                description: "\(phase): swapping \(arr[root]) ↔ \(arr[largest])"
            ))
            arr.swapAt(root, largest)
            snapshots.append(SortingSnapshot(
                values: arr,
                activeIndices: [root, largest],
                sortedIndices: sorted,
                description: "\(phase): heapify at \(largest)"
            ))
            heapify(&arr, n: n, root: largest, sorted: sorted,
                    snapshots: &snapshots, phase: phase)
        }
    }
}

// MARK: - Shell Sort

struct ShellSortEngine: SortingEngine {
    let name = "Shell Sort"

    func generateSnapshots(from array: [Int]) -> [SortingSnapshot] {
        var arr = array
        var snapshots: [SortingSnapshot] = []
        let n = arr.count
        var gap = n / 2

        while gap > 0 {
            snapshots.append(SortingSnapshot(
                values: arr,
                activeIndices: [],
                sortedIndices: [],
                description: "Gap = \(gap)"
            ))
            for i in gap..<n {
                let temp = arr[i]
                var j = i
                while j >= gap && arr[j - gap] > temp {
                    snapshots.append(SortingSnapshot(
                        values: arr,
                        activeIndices: [j, j - gap],
                        sortedIndices: [],
                        description: "Comparing \(arr[j - gap]) > \(temp), shifting"
                    ))
                    arr[j] = arr[j - gap]
                    j -= gap
                }
                arr[j] = temp
                snapshots.append(SortingSnapshot(
                    values: arr,
                    activeIndices: [j],
                    sortedIndices: [],
                    description: "Placed \(temp) at index \(j)"
                ))
            }
            gap /= 2
        }
        snapshots.append(SortingSnapshot(
            values: arr,
            activeIndices: [],
            sortedIndices: Set(0..<n),
            description: "✅ Sorted!"
        ))
        return snapshots
    }
}

// MARK: - Radix Sort (LSD, base 10)

struct RadixSortEngine: SortingEngine {
    let name = "Radix Sort"

    func generateSnapshots(from array: [Int]) -> [SortingSnapshot] {
        var arr = array
        var snapshots: [SortingSnapshot] = []
        let maxVal = arr.max() ?? 0
        var exp = 1
        
        while maxVal / exp > 0 {
            // Scanning phase: show each element's digit
            for i in 0..<arr.count {
                let digit = (arr[i] / exp) % 10
                snapshots.append(SortingSnapshot(
                    values: arr,
                    activeIndices: [i],
                    sortedIndices: [],
                    description: "[\(arr[i])] digit at ×\(exp) place = \(digit)"
                ))
            }
            arr = countingSorted(arr, exp: exp)
            snapshots.append(SortingSnapshot(
                values: arr,
                activeIndices: Set(0..<arr.count),
                sortedIndices: [],
                description: "Rearranged by ×\(exp) digit"
            ))
            exp *= 10
        }
        snapshots.append(SortingSnapshot(
            values: arr,
            activeIndices: [],
            sortedIndices: Set(0..<arr.count),
            description: "✅ Sorted
    }
    private func countingSorted(_ arr: [Int], exp: Int) -> [Int] {
            var output = Array(repeating: 0, count: arr.count)
            var count = Array(repeating: 0, count: 10)

            for val in arr {
                count[(val / exp) % 10] += 1
            }
            for i in 1..<10 {
                count[i] += count[i - 1]
            }
            for i in stride(from: arr.count - 1, through: 0, by: -1) {
                let digit = (arr[i] / exp) % 10
                count[digit] -= 1
                output[count[digit]] = arr[i]
            }
            return output
        }
    }

    // MARK: - Engine Factory

    enum SortingEngineFactory {
        static func engine(for name: String) -> SortingEngine {
            switch name {
            case "Bubble Sort":    return BubbleSortEngine()
            case "Merge Sort":     return MergeSortEngine()
            case "Quick Sort":     return QuickSortEngine()
            case "Heap Sort":      return HeapSortEngine()
            case "Insertion Sort":  return InsertionSortEngine()
            case "Selection Sort":  return SelectionSortEngine()
            case "Radix Sort":     return RadixSortEngine()
            case "Shell Sort":     return ShellSortEngine()
            default:               return BubbleSortEngine()
            }
        }
    }
}

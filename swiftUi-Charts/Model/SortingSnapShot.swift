//
//  SortingSnapShot.swift
//  swiftUi-Charts
//
//  Created by Jaimin Raval on 15/04/26.
//
//  Models/SortingSnapshot
import Foundation

/// A single snapshot of the array state during sorting
struct SortingSnapshot {
    let values: [Int]
    let activeIndices: Set<Int>
    let sortedIndices: Set<Int>
    let description: String
}

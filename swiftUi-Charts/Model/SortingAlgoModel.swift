//
//  SortingAlgoModel.swift
//  swiftUi-Charts
//
//  Created by Jaimin Raval on 15/04/26.
//
//  Models/SortingAlgoModel
import SwiftUI
// MARK: - Data Models

struct SortStep: Identifiable {
    let id = UUID()
    let index: Int
    let value: Double
    let isHighlighted: Bool
}

struct SortingAlgorithm: Identifiable {
    let id = UUID()
    let name: String
    let subtitle: String
    let complexity: String
    let accentColor: Color
    let steps: [SortStep]
    // (CAN delete later the following below)
    // Predefined visual snapshots (bar chart data) for each algo
    static let all: [SortingAlgorithm] = [
        SortingAlgorithm(
            name: "Bubble Sort",
            subtitle: "Comparison-based",
            complexity: "O(n²)",
            accentColor: .orange,
            steps: [
                SortStep(index: 0, value: 3, isHighlighted: true),
                SortStep(index: 1, value: 7, isHighlighted: true),
                SortStep(index: 2, value: 1, isHighlighted: false),
                SortStep(index: 3, value: 5, isHighlighted: false),
                SortStep(index: 4, value: 9, isHighlighted: false),
                SortStep(index: 5, value: 2, isHighlighted: false),
                SortStep(index: 6, value: 8, isHighlighted: false),
            ]
        ),
        SortingAlgorithm(
            name: "Merge Sort",
            subtitle: "Divide & Conquer",
            complexity: "O(n log n)",
            accentColor: .blue,
            steps: [
                SortStep(index: 0, value: 1, isHighlighted: false),
                SortStep(index: 1, value: 3, isHighlighted: false),
                SortStep(index: 2, value: 5, isHighlighted: true),
                SortStep(index: 3, value: 5, isHighlighted: true),
                SortStep(index: 4, value: 7, isHighlighted: false),
                SortStep(index: 5, value: 8, isHighlighted: false),
                SortStep(index: 6, value: 9, isHighlighted: false),
            ]
        ),
        SortingAlgorithm(
            name: "Quick Sort",
            subtitle: "Partition-based",
            complexity: "O(n log n)",
            accentColor: .green,
            steps: [
                SortStep(index: 0, value: 2, isHighlighted: false),
                SortStep(index: 1, value: 4, isHighlighted: false),
                SortStep(index: 2, value: 6, isHighlighted: true),
                SortStep(index: 3, value: 3, isHighlighted: false),
                SortStep(index: 4, value: 8, isHighlighted: false),
                SortStep(index: 5, value: 5, isHighlighted: false),
                SortStep(index: 6, value: 9, isHighlighted: false),
            ]
        ),
        SortingAlgorithm(
            name: "Heap Sort",
            subtitle: "Tree-based",
            complexity: "O(n log n)",
            accentColor: .purple,
            steps: [
                SortStep(index: 0, value: 9, isHighlighted: true),
                SortStep(index: 1, value: 7, isHighlighted: false),
                SortStep(index: 2, value: 5, isHighlighted: false),
                SortStep(index: 3, value: 6, isHighlighted: false),
                SortStep(index: 4, value: 3, isHighlighted: false),
                SortStep(index: 5, value: 2, isHighlighted: false),
                SortStep(index: 6, value: 1, isHighlighted: false),
            ]
        ),
        SortingAlgorithm(
            name: "Insertion Sort",
            subtitle: "Incremental build",
            complexity: "O(n²)",
            accentColor: .pink,
            steps: [
                SortStep(index: 0, value: 1, isHighlighted: false),
                SortStep(index: 1, value: 2, isHighlighted: false),
                SortStep(index: 2, value: 3, isHighlighted: false),
                SortStep(index: 3, value: 4, isHighlighted: true),
                SortStep(index: 4, value: 7, isHighlighted: false),
                SortStep(index: 5, value: 8, isHighlighted: false),
                SortStep(index: 6, value: 9, isHighlighted: false),
            ]
        ),
        SortingAlgorithm(
            name: "Selection Sort",
            subtitle: "In-place comparison",
            complexity: "O(n²)",
            accentColor: .teal,
            steps: [
                SortStep(index: 0, value: 1, isHighlighted: false),
                SortStep(index: 1, value: 5, isHighlighted: false),
                SortStep(index: 2, value: 2, isHighlighted: true),
                SortStep(index: 3, value: 8, isHighlighted: false),
                SortStep(index: 4, value: 4, isHighlighted: false),
                SortStep(index: 5, value: 9, isHighlighted: false),
                SortStep(index: 6, value: 6, isHighlighted: false),
            ]
        ),
        SortingAlgorithm(
            name: "Radix Sort",
            subtitle: "Non-comparative",
            complexity: "O(nk)",
            accentColor: .red,
            steps: [
                SortStep(index: 0, value: 2, isHighlighted: false),
                SortStep(index: 1, value: 4, isHighlighted: false),
                SortStep(index: 2, value: 5, isHighlighted: false),
                SortStep(index: 3, value: 6, isHighlighted: false),
                SortStep(index: 4, value: 7, isHighlighted: false),
                SortStep(index: 5, value: 8, isHighlighted: true),
                SortStep(index: 6, value: 9, isHighlighted: false),
            ]
        ),
        SortingAlgorithm(
            name: "Shell Sort",
            subtitle: "Gap-sequence based",
            complexity: "O(n log² n)",
            accentColor: .indigo,
            steps: [
                SortStep(index: 0, value: 3, isHighlighted: false),
                SortStep(index: 1, value: 1, isHighlighted: true),
                SortStep(index: 2, value: 6, isHighlighted: false),
                SortStep(index: 3, value: 4, isHighlighted: true),
                SortStep(index: 4, value: 7, isHighlighted: false),
                SortStep(index: 5, value: 5, isHighlighted: false),
                SortStep(index: 6, value: 9, isHighlighted: false),
            ]
        ),
    ]
}

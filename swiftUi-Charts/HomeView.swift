//
//  HomeView.swift
//  swiftUi-Charts
//
//  Created by Jaimin Raval on 11/04/26.
//
//  Views/HomeView

import SwiftUI
import Charts

struct HomeView: View {
    var body: some View {
        SortingAlgorithmListView()
    }
}

#Preview {
    HomeView()
}


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

// MARK: - Chart Thumbnail View

struct AlgorithmChartThumbnail: View {
    let algorithm: SortingAlgorithm

    var body: some View {
        Chart(algorithm.steps) { step in
            BarMark(
                x: .value("Index", step.index),
                y: .value("Value", step.value)
            )
            .foregroundStyle(
                step.isHighlighted
                    ? algorithm.accentColor
                    : algorithm.accentColor.opacity(0.3)
            )
            .cornerRadius(2)
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartPlotStyle { content in
            content.background(Color.clear)
        }
        .frame(width: 72, height: 44)
        .padding(6)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(algorithm.accentColor.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(algorithm.accentColor.opacity(0.18), lineWidth: 1)
                )
        )
    }
}

// MARK: - Row View

struct AlgorithmRowView: View {
    let algorithm: SortingAlgorithm

    var body: some View {
        HStack(spacing: 14) {
            // Leading: icon + text
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(algorithm.accentColor.opacity(0.12))
                        .frame(width: 42, height: 42)
                    Image(systemName: algorithmIcon)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(algorithm.accentColor)
                }

                VStack(alignment: .leading, spacing: 3) {
                    Text(algorithm.name)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundStyle(.primary)

                    Text(algorithm.subtitle)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.secondary)

                    Text(algorithm.complexity)
                        .font(.system(size: 11, weight: .medium, design: .monospaced))
                        .foregroundStyle(algorithm.accentColor)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(
                            Capsule()
                                .fill(algorithm.accentColor.opacity(0.1))
                        )
                }
            }

            Spacer()

            // Trailing: Chart thumbnail
            AlgorithmChartThumbnail(algorithm: algorithm)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 4)
    }

    // Map algorithm names to SF Symbols
    private var algorithmIcon: String {
        switch algorithm.name {
        case "Bubble Sort":     return "bubbles.and.sparkles"
        case "Merge Sort":      return "arrow.triangle.merge"
        case "Quick Sort":      return "bolt.fill"
        case "Heap Sort":       return "pyramid.fill"
        case "Insertion Sort":  return "arrow.right.to.line"
        case "Selection Sort":  return "hand.point.up.left.fill"
        case "Radix Sort":      return "number.circle.fill"
        case "Shell Sort":      return "chart.bar.xaxis"
        default:                return "waveform"
        }
    }
}

// MARK: - Main List View

struct SortingAlgorithmListView: View {
    let algorithms = SortingAlgorithm.all
    @State private var searchText = ""
    @State private var selectedAlgorithm: SortingAlgorithm?

    var filtered: [SortingAlgorithm] {
        if searchText.isEmpty { return algorithms }
        return algorithms.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List(filtered) { algorithm in
                Button {
                    selectedAlgorithm = algorithm
                } label: {
                    AlgorithmRowView(algorithm: algorithm)
                }
                .buttonStyle(.plain)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color(.secondarySystemGroupedBackground))
                        .padding(.vertical, 3)
                        .padding(.horizontal, 6)
                )
                .listRowSeparator(.hidden)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Sorting Algorithms")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText, prompt: "Search algorithms")
            .background(Color(.systemGroupedBackground))
        }
    }
}

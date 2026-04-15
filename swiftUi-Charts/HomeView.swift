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

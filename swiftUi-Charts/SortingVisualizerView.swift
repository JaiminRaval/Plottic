//
//  SortingVisualizerView.swift
//  swiftUi-Charts
//
//  Created by Jaimin Raval on 14/04/26.
//
//
// SortingVisualizerView.swift
import SwiftUI
import Charts

struct SortingVisualizerView: View {
    let algorithm: SortingAlgorithmType
    @State private var engine = SortingEngine()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // Stats Bar
            statsBar
                .padding(.horizontal)
                .padding(.top, 8)

            // Chart
            chartView
                .padding()

            Divider()

            // Controls
            controlsPanel
                .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(algorithm.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    ForEach([20, 30, 50, 75, 100], id: \.self) { count in
                        Button("  \(count) bars") {
                            engine.barCount = count
                            engine.generateBars()
                        }
                    }
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }
                .disabled(engine.isSorting)
            }
        }
        .onDisappear {
            engine.stop()
        }
    }

    // MARK: - Stats

    private var statsBar: some View {
        HStack(spacing: 16) {
            StatBadge(
                label: "Comparisons",
                value: "\(engine.comparisons)",
                icon: "eye.fill",
                color: .blue
            )
            StatBadge(
                label: "Swaps",
                value: "\(engine.swaps)",
                icon: "arrow.left.arrow.right",
                color: .orange
            )
            StatBadge(
                label: "Complexity",
                value: algorithm.timeComplexity,
                icon: "clock.fill",
                color: .purple
            )
        }
    }

    // MARK: - Chart

    private var chartView: some View {
        Chart(Array(engine.bars.enumerated()), id: \.element.id) {
            index, bar in
            BarMark(
                x: .value("Index", index),
                y: .value("Value", bar.value)
            )
            .foregroundStyle(barColor(for: bar.state).gradient)
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 2,
                    topTrailingRadius: 2
                )
            )
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartYScale(domain: 0...110)
        .animation(.easeInOut(duration: 0.08), value: engine.bars)
        .frame(maxHeight: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.background)
                .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
        )
    }

    private func barColor(for state: SortBar.BarState) -> Color {
        switch state {
        case .idle: return algorithm.color.opacity(0.7)
        case .comparing: return .yellow
        case .swapping: return .red
        case .sorted: return .green
        case .pivot: return .pink
        }
    }

    // MARK: - Controls

    private var controlsPanel: some View {
        VStack(spacing: 16) {
            // Speed slider
            HStack {
                Image(systemName: "tortoise.fill")
                    .foregroundStyle(.secondary)
                Slider(value: $engine.speed, in: 1...100)
                    .tint(algorithm.color)
                Image(systemName: "hare.fill")
                    .foregroundStyle(.secondary)
            }

            // Buttons
            HStack(spacing: 12) {
                Button {
                    engine.shuffle()
                } label: {
                    Label("Shuffle", systemImage: "shuffle")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))
                }
                .disabled(engine.isSorting)

                Button {
                    if engine.isSorting {
                        engine.stop()
                    } else {
                        engine.sort(using: algorithm)
                    }
                } label: {
                    Label(
                        engine.isSorting ? "Stop" : "Sort",
                        systemImage: engine.isSorting
                            ? "stop.fill" : "play.fill"
                    )
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        (engine.isSorting ? Color.red : algorithm.color)
                            .gradient,
                        in: RoundedRectangle(cornerRadius: 14)
                    )
                }
                .disabled(engine.isSorted)
            }

            // Legend
            legendView
        }
    }

    private var legendView: some View {
        HStack(spacing: 16) {
            LegendDot(color: algorithm.color.opacity(0.7), label: "Idle")
            LegendDot(color: .yellow, label: "Comparing")
            LegendDot(color: .red, label: "Swapping")
            LegendDot(color: .green, label: "Sorted")
        }
        .font(.caption2)
    }
}

// MARK: - Supporting Views

struct StatBadge: View {
    let label: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.caption2)
                    .foregroundStyle(color)
                Text(value)
                    .font(.subheadline.bold().monospacedDigit())
            }
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(color.opacity(0.08), in: RoundedRectangle(cornerRadius: 10))
    }
}

struct LegendDot: View {
    let color: Color
    let label: String

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(color.gradient)
                .frame(width: 8, height: 8)
            Text(label)
                .foregroundStyle(.secondary)
        }
    }
}
struct SortingVisualizerView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SortingVisualizerView()
}

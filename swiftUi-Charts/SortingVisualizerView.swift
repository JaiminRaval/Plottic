////
////  SortingVisualizerView.swift
////  swiftUi-Charts
////
////  Created by Jaimin Raval on 14/04/26.
////
////
//// SortingVisualizerView.swift
import SwiftUI
import Charts

struct SortingVisualizerView: View {
    @StateObject private var vm: SortingVisualizerViewModel
    @Environment(\.dismiss) private var dismiss

    init(algorithm: SortingAlgorithm) {
        _vm = StateObject(
            wrappedValue: SortingVisualizerViewModel(algorithm: algorithm)
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            chartSection
            statusBar
            controlsSection
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(vm.algorithm.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    vm.soundEnabled.toggle()
                } label: {
                    Image(systemName: vm.soundEnabled
                          ? "speaker.wave.2.fill"
                          : "speaker.slash.fill")
                    .foregroundStyle(vm.algorithm.accentColor)
                }
            }
        }
        .onDisappear { vm.stop() }
    }

    // MARK: - Chart

    private var chartSection: some View {
        Chart(Array(vm.values.enumerated()), id: \.offset) { index, value in
            BarMark(
                x: .value("Index", index),
                y: .value("Value", value)
            )
            .foregroundStyle(barColor(for: index))
            .cornerRadius(2)
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .animation(.easeInOut(duration: 0.15), value: vm.values)
        .padding(.horizontal, 20)
        .padding(.top, 24)
        .padding(.bottom, 12)
        .frame(maxHeight: .infinity)
    }

    // MARK: - Status Bar

    private var statusBar: some View {
        Text(vm.statusText)
            .font(.system(size: 14, weight: .medium, design: .monospaced))
            .foregroundStyle(.secondary)
            .lineLimit(1)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.tertiarySystemGroupedBackground))
            )
            .padding(.horizontal, 20)
    }

    // MARK: - Controls

    private var controlsSection: some View {
        VStack(spacing: 16) {
            // Speed slider
            HStack(spacing: 10) {
                Image(systemName: "tortoise.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Slider(value: $vm.speed, in: 0...1)
                    .tint(vm.algorithm.accentColor)
                    .disabled(vm.isSorting)
                Image(systemName: "hare.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 20)

            // Buttons
            HStack(spacing: 16) {
                // Shuffle
                Button {
                    vm.shuffle()
                } label: {
                    Label("Shuffle", systemImage: "shuffle")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color(.tertiarySystemGroupedBackground))
                        )
                        .foregroundStyle(.primary)
                }
                .disabled(vm.isSorting)
                .opacity(vm.isSorting ? 0.4 : 1)

                // Sort / Stop
                Button {
                    if vm.isSorting {
                        vm.stop()
                    } else {
                        if vm.isComplete { vm.shuffle() }
                        vm.sort()
                    }
                } label: {
                    Label(
                        vm.isSorting ? "Stop" : "Sort",
                        systemImage: vm.isSorting
                            ? "stop.fill" : "play.fill"
                    )
                    .font(.system(size: 15, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.orange)
                    )
                    .foregroundStyle(.white)
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
                .ignoresSafeArea(edges: .bottom)
        )
    }

    // MARK: - Helpers

    private func barColor(for index: Int) -> Color {
        if vm.sortedIndices.contains(index) && !vm.activeIndices.contains(index) {
            return .green
        }
        if vm.activeIndices.contains(index) {
            return vm.algorithm.accentColor
        }
        return vm.algorithm.accentColor.opacity(0.3)
    }
}

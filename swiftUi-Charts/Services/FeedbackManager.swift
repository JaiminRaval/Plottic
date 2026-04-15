//
//  FeedbackManager.swift
//  swiftUi-Charts
//
//  Created by Jaimin Raval on 15/04/26.
//

import Foundation
import AVFoundation
import UIKit

final class FeedbackManager {
    static let shared = FeedbackManager()

    private var audioPlayer: AVAudioPlayer?
    private let lightImpact = UIImpactFeedbackGenerator(style: .light)
    private let mediumImpact = UIImpactFeedbackGenerator(style: .medium)
    private let notificationFeedback = UINotificationFeedbackGenerator()

    private init() {
        lightImpact.prepare()
        mediumImpact.prepare()
        notificationFeedback.prepare()
    }

    /// Tick haptic + tone scaled to bar height
    func playStepFeedback(value: Int, maxValue: Int) {
        lightImpact.impactOccurred()
        playTone(value: value, maxValue: maxValue)
    }

    /// Swap haptic
    func playSwapFeedback() {
        mediumImpact.impactOccurred()
    }

    /// Completion haptic
    func playCompletionFeedback() {
        notificationFeedback.notificationOccurred(.success)
    }

    /// Generates a short sine-wave tone proportional to the value
    private func playTone(value: Int, maxValue: Int) {
        let sampleRate: Double = 44100
        let duration: Double = 0.05
        let numSamples = Int(sampleRate * duration)
        let minFreq: Double = 220
        let maxFreq: Double = 880
        let ratio = Double(value) / Double(max(maxValue, 1))
        let frequency = minFreq + ratio * (maxFreq - minFreq)

        var samples = [Float](repeating: 0, count: numSamples)
        for i in 0..<numSamples {
            let t = Double(i) / sampleRate
            samples[i] = Float(sin(2.0 * .pi * frequency * t) * 0.25)
        }

        // Build WAV data in memory
        let wavData = buildWAV(
            samples: samples,
            sampleRate: Int(sampleRate)
        )

        do {
            audioPlayer = try AVAudioPlayer(data: wavData)
            audioPlayer?.volume = 0.3
            audioPlayer?.play()
        } catch {}
    }

    private func buildWAV(samples: [Float], sampleRate: Int) -> Data {
        let numSamples = samples.count
        let bitsPerSample = 16
        let numChannels = 1
        let byteRate = sampleRate * numChannels * bitsPerSample / 8
        let blockAlign = numChannels * bitsPerSample / 8
        let dataSize = numSamples * blockAlign
        let chunkSize = 36 + dataSize

        var data = Data()

        // RIFF header
        data.append(contentsOf: "RIFF".utf8)
        data.append(contentsOf: withUnsafeBytes(of: UInt32(chunkSize).littleEndian) {
            Array($0)
        })
        data.append(contentsOf: "WAVE".utf8)

        // fmt sub-chunk
        data.append(contentsOf: "fmt ".utf8)
        data.append(contentsOf: withUnsafeBytes(of: UInt32(16).littleEndian) {
            Array($0)
        })
        data.append(contentsOf: withUnsafeBytes(of: UInt16(1).littleEndian) {
            Array($0) // PCM
        })
        data.append(contentsOf: withUnsafeBytes(of: UInt16(numChannels).littleEndian) {
            Array($0)
        })
        data.append(contentsOf: withUnsafeBytes(of: UInt32(sampleRate).littleEndian) {
            Array($0)
        })
        data.append(contentsOf: withUnsafeBytes(of: UInt32(byteRate).littleEndian) {
            Array($0)
        })
        data.append(contentsOf: withUnsafeBytes(of: UInt16(blockAlign).littleEndian) {
            Array($0)
        })
        data.append(contentsOf: withUnsafeBytes(of: UInt16(bitsPerSample).littleEndian) {
            Array($0)
        })

        // data sub-chunk
        data.append(contentsOf: "data".utf8)
        data.append(contentsOf: withUnsafeBytes(of: UInt32(dataSize).littleEndian) {
            Array($0)
        })

        for sample in samples {
            let clamped = max(-1.0, min(1.0, sample))
            let int16Val = Int16(clamped * Float(Int16.max))
            data.append(contentsOf: withUnsafeBytes(of: int16Val.littleEndian) {
                Array($0)
            })
        }

        return data
    }
}

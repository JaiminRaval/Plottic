//
//  SoundManager.swift
//  swiftUi-Charts
//
//  Created by Jaimin Raval on 14/04/26.
//

import Foundation
// SoundEngine.swift
import AVFoundation

class SoundEngine {
    static let shared = SoundEngine()

    private let audioEngine = AVAudioEngine()
    private let playerNode = AVAudioPlayerNode()
    private let sampleRate: Double = 44100
    private var audioFormat: AVAudioFormat

    private init() {
        audioFormat = AVAudioFormat(
            standardFormatWithSampleRate: sampleRate,
            channels: 1
        )!

        audioEngine.attach(playerNode)
        audioEngine.connect(
            playerNode,
            to: audioEngine.mainMixerNode,
            format: audioFormat
        )

        audioEngine.mainMixerNode.outputVolume = 0.3

        do {
            try AVAudioSession.sharedInstance().setCategory(
                .playback,
                mode: .default,
                options: .mixWithOthers
            )
            try AVAudioSession.sharedInstance().setActive(true)
            try audioEngine.start()
            playerNode.play()
        } catch {
            print("Audio engine error: \(error)")
        }
    }

    func playTone(frequency: Float, duration: Float = 0.05) {
        let frameCount = AVAudioFrameCount(sampleRate * Double(duration))

        guard let buffer = AVAudioPCMBuffer(
            pcmFormat: audioFormat,
            frameCapacity: frameCount
        ) else { return }

        buffer.frameLength = frameCount

        let theta = 2.0 * Float.pi * frequency / Float(sampleRate)
        guard let channelData = buffer.floatChannelData?[0] else { return }

        for i in 0..<Int(frameCount) {
            let sample = sinf(theta * Float(i))
            // Apply envelope to avoid clicks
            let envelope: Float
            let attackSamples = min(Int(frameCount) / 4, 200)
            let releaseSamples = min(Int(frameCount) / 4, 200)

            if i < attackSamples {
                envelope = Float(i) / Float(attackSamples)
            } else if i > Int(frameCount) - releaseSamples {
                envelope = Float(Int(frameCount) - i) / Float(releaseSamples)
            } else {
                envelope = 1.0
            }
            channelData[i] = sample * envelope * 0.4
        }

        playerNode.scheduleBuffer(buffer, completionHandler: nil)
    }
}

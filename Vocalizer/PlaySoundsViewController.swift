//
//  PlaySoundsViewController.swift
//  Vocalizer
//
//  Created by Thomas Truongchau on 3/6/16.
//  Copyright © 2016 Thomas Truongchau. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var audioEngine: AVAudioEngine!
    var receivedAudio: RecordedAudio!
    var audioFile: AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }

    func playAudioHelper(rate: Float) {
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioHelper(0.7)
    }

    @IBAction func playFastAudio(sender: UIButton) {
        playAudioHelper(2.0)
    }

    func playAudioWithVariablePitch(pitch: Float) {
        // Stop the audio player and reset the audio engine
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()

        // Set up the audioPlayerNode and changePitchEffect
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)

        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)

        // Connect the audioPlayerNode to the new pitch effect to the speaker
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)

        // Play the audio with new sound effects
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()
    }

    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }

    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }

    @IBAction func stopRecordingAudio(sender: UIButton) {
        audioPlayer.stop()
    }
}

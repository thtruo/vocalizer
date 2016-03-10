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
    var receivedAudio: RecordedAudio!

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    @IBAction func stopRecordingAudio(sender: UIButton) {
        audioPlayer.stop()
    }
}

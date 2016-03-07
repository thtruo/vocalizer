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

    override func viewDidLoad() {
        super.viewDidLoad()
        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            let filePathURL = NSURL.fileURLWithPath(filePath)
            audioPlayer = try!AVAudioPlayer(contentsOfURL: filePathURL)
            audioPlayer.enableRate = true
        } else {
            print("The filePath is empty")
        }
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

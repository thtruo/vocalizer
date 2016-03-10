//
//  RecordSoundsViewController.swift
//  Vocalizer
//
//  Created by Thomas Truongchau on 3/2/16.
//  Copyright © 2016 Thomas Truongchau. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingStatus: UILabel!
    @IBOutlet weak var stopButtonStatus: UIButton!

    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!

    override func viewDidLoad() {
        super.viewDidLoad()
        recordingStatus.hidden = true
    }

    override func viewWillAppear(animated: Bool) {
        recordButton.enabled = true
        stopButtonStatus.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordButton.enabled = false
        recordingStatus.hidden = false
        stopButtonStatus.hidden = false

        // Record the user's voice
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String

        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)

        // Set up audio session
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)

        // Initialize and set up the audio recorder
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            // Save recorded audio
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url;
            recordedAudio.title = recorder.url.lastPathComponent;

            // Move to the next scene via segue
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio )
        } else {
            print("Ouch, we hit a snag and couldn't record successfully.")
            recordButton.enabled = true
            stopButtonStatus.hidden = true
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }

    @IBAction func stopRecordingAudio(sender: UIButton) {
        if !recordingStatus.hidden {
            recordingStatus.hidden = true
        }
        recordButton.enabled = true

        // Stop recording the user's voice
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
}


//
//  ViewController.swift
//  Vocalizer
//
//  Created by Thomas Truongchau on 3/2/16.
//  Copyright © 2016 Thomas Truongchau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingStatus: UILabel!
    @IBOutlet weak var stopButtonStatus: UIButton!

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
        print("in recordAudio...")
        recordButton.enabled = false
        recordingStatus.hidden = false
        stopButtonStatus.hidden = false
    }

    @IBAction func stopRecordingAudio(sender: UIButton) {
        print("in stopRecordingAudio...")
        if !recordingStatus.hidden {
            recordingStatus.hidden = true
        }
        recordButton.enabled = true
    }
}


//
//  ViewController.swift
//  Vocalizer
//
//  Created by Thomas Truongchau on 3/2/16.
//  Copyright © 2016 Thomas Truongchau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // `Recording` label
    @IBOutlet weak var recordingStatus: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        recordingStatus.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        print("in recordAudio...")
        recordingStatus.hidden = false
    }

    @IBAction func stopRecordingAudio(sender: UIButton) {
        print("in stopRecordingAudio...")
        if !recordingStatus.hidden {
            recordingStatus.hidden = true
        }
    }
}


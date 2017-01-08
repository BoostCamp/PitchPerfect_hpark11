//
//  ViewController.swift
//  PitchPerfect
//
//  Created by connect on 2017. 1. 9..
//  Copyright © 2017년 boostcamp. All rights reserved.
//

import UIKit

class RecordSoundsViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var pauseRecordingButton: UIButton!
    @IBOutlet weak var resumeRecordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    // MARK: Lifecycle methods override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeUIState(record: true, stop: true, pause: true, resume: true, recordLbl: true, state: "")
    }
    
    // MARK: Actions Relating to Audio Recording
    
    @IBAction func recordAudio(_ sender: Any) {
        changeUIState(record: false, stop: false, pause: false, resume: true, recordLbl: false, state: "Recording")
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        changeUIState(record: true, stop: true, pause: true, resume: true, recordLbl: true, state: "")
    }
    
    @IBAction func pauseRecording(_ sender: Any) {
        changeUIState(record: false, stop: false, pause: true, resume: false, recordLbl: false, state: "Recording Paused")
    }
    
    @IBAction func resumeRecording(_ sender: Any) {
        changeUIState(record: false, stop: false, pause: false, resume: true, recordLbl: false, state: "Recording")
    }
    
    // MARK: General methods
    
    func changeUIState(record:Bool, stop:Bool, pause:Bool, resume:Bool, recordLbl: Bool, state:String? = nil) {
        
        if recordButton.isEnabled != record {
            recordButton.isEnabled = record
        }
        
        if stopRecordingButton.isHidden != stop {
            stopRecordingButton.isHidden = stop
        }
        
        if pauseRecordingButton.isHidden != pause {
            pauseRecordingButton.isHidden = pause
        }
        
        if resumeRecordingButton.isHidden != resume {
            resumeRecordingButton.isHidden = resume
        }
        
        if recordingLabel.isHidden != recordLbl {
            recordingLabel.isHidden = recordLbl
        }
        
        if let state = state {
            recordingLabel.text = state
        }
    }
    
}


//
//  ViewController.swift
//  PitchPerfect
//
//  Created by hpark on 2017. 1. 9..
//  Copyright © 2017년 boostcamp. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    
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
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        
        let current = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "ddyyyyMM-HHmmss"
        let recordingName = formatter.string(from: current as Date) + ".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
            try audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        } catch _ {
            print("::: Error in Recording Audio")
        }
        
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        changeUIState(record: true, stop: true, pause: true, resume: true, recordLbl: true, state: "")
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch _ {
            print("::: Error in Stop Recording")
        }
        
    }
    
    @IBAction func pauseRecording(_ sender: Any) {
        changeUIState(record: false, stop: false, pause: true, resume: false, recordLbl: false, state: "Recording Paused")
        
        audioRecorder.pause()
    }
    
    @IBAction func resumeRecording(_ sender: Any) {
        changeUIState(record: false, stop: false, pause: false, resume: true, recordLbl: false, state: "Recording")
        
        audioRecorder.record()
    }
    
    // MARK : delegates
    
    // gives url of recorded audio file to the next view controller
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("recording was not successful")
        }
    }
    
    // playSoundsViewController needs to know what it should do when the segue is performed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
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


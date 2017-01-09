//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by hpark on 2017. 1. 9..
//  Copyright © 2017년 boostcamp. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var remainTimeLabel: UILabel!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    var remainTimer: Timer!
    
    var remainingTime: Double = 0
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: Lifecycle methods override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAudio()
    }
    
    // MARK: Actions for playing changed sounds
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    // MARK: General methods
    
    func countRemainingTime() {
        let seconds:String = String(format: "%02d", Int(self.remainingTime) % 60)
        let minutes:String = String(format: "%02d", Int(self.remainingTime) % 3600 / 60)
        let hours:String = String(format: "%02d", Int(self.remainingTime / 3600.0))
        
        if (remainingTime < 1) {
            remainTimer.invalidate()
            self.remainTimeLabel.text = "00:00:00 Left"
        }

        self.remainTimeLabel.text = "\(hours):\(minutes):\(seconds) Left"
        self.remainingTime = self.remainingTime - 1.0
    }
}

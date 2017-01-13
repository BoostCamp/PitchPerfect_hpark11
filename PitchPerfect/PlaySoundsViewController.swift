//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by hpark on 2017. 1. 9..
//  Copyright © 2017년 boostcamp. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var remainTimeLabel: UILabel!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    var remainTimer: Timer!
    
    var isSaved:Bool = false
    var isTrySaving: Bool = false
    var remainingTime: Double = 0
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: Lifecycle methods override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
        if isSaved {
            saveButton.isEnabled = !saveButton.isEnabled
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isTrySaving = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAudio()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if !isTrySaving {
            if !checkAudioURLSaved() {
                let fileManager = FileManager.default
                do {
                    try fileManager.removeItem(atPath: recordedAudioURL.absoluteString)
                }
                catch let error as NSError {
                    print("::: Error in deleting audio file at : \(error)")
                }
            }
        }
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
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        isTrySaving = true
        performSegue(withIdentifier: "saveAudio", sender: recordedAudioURL)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveAudio" {
            let saveSoundsVC = segue.destination as! SaveSoundsViewController
            let recordedAudioURL = sender as! URL
            saveSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    
    // MARK: General methods
    
    func countRemainingTime() {
        let seconds:String = String(format: "%02d", Int(self.remainingTime) % 60)
        let minutes:String = String(format: "%02d", Int(self.remainingTime) % 3600 / 60)
        let hours:String = String(format: "%02d", Int(self.remainingTime / 3600.0))
        
        if (remainingTime < 1) {
            remainTimer.invalidate()
            self.remainTimeLabel.text = "00:00:00"
        }

        self.remainTimeLabel.text = "\(hours):\(minutes):\(seconds)"
        self.remainingTime = self.remainingTime - 1.0
    }
    
    func checkAudioURLSaved() -> Bool {
        let entityDesc = NSEntityDescription.entity(forEntityName: "Item", in: context)
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.entity = entityDesc
        
        if let url = self.recordedAudioURL {
            let pathArr: [String] = url.path.components(separatedBy: "/")
            let filePath = pathArr[pathArr.count - 1]
            
            let pred = NSPredicate(format: "(fileName = %@)", filePath)
            request.predicate = pred
            
            do {
                let objects = try context.fetch(request)
                if objects.count > 0 {
                    return true
                } else {
                    return false
                }
            } catch let error as NSError {
                print("\(error.localizedFailureReason)")
                print("::: Error occurred at checking whether the audio file URL is saved in Core Data or not")
            }
        }
        
        return false
    }
}

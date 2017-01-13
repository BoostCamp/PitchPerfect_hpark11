//
//  SaveSoundsViewController.swift
//  PitchPerfect
//
//  Created by connect on 2017. 1. 11..
//  Copyright © 2017년 boostcamp. All rights reserved.
//

import UIKit

class SaveSoundsViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    
    var recordedAudioURL:URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveAudio(_ sender: Any) {
        var item: Item!
        item = Item(context: context)
        
        if let title = titleField.text {
            item.title = title
        }
        
        if let url = recordedAudioURL {
            let pathArr: [String] = url.path.components(separatedBy: "/")
            item.fileName = pathArr[pathArr.count - 1]
        }
        
        item.created = NSDate()
        appDelegate.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }
}

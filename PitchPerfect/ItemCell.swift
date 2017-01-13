//
//  ItemCell.swift
//  PitchPerfect
//
//  Created by connect on 2017. 1. 11..
//  Copyright © 2017년 boostcamp. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    
    
    
    func buildCell(item: Item) {
        titleLabel.text = item.title
        fileNameLabel.text = item.fileName
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 - HH:mm:ss"
        let recordingName = formatter.string(from: item.created as! Date)
        createdLabel.text = recordingName
    }
}

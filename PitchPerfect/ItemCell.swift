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
        createdLabel.text = "\(item.created)"
    }
}

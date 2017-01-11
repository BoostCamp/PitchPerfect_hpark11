//
//  SoundsListViewController_ex.swift
//  PitchPerfect
//
//  Created by connect on 2017. 1. 11..
//  Copyright © 2017년 boostcamp. All rights reserved.
//

import UIKit
import CoreData

// Extension Relating to UITableView
extension SoundsListViewController : UITableViewDelegate, UITableViewDataSource {
    
    // build each cell with some UI components
    func buildCell(cell:ItemCell, indexPath: IndexPath) {
        let item = self.itemController.object(at: indexPath)
        cell.buildCell(item: item)
    }
    
    // re - using
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = soundsTableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        buildCell(cell: cell, indexPath: indexPath)
        return UITableViewCell()
    }
    
    // when selected particular cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objects = itemController.fetchedObjects, objects.count > 0 {
            //let item = objects[indexPath.row]
        }
    }
    
    // number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = itemController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    // cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = itemController.sections {
            return sections.count
        }
        return 0
    }
}

// Extension Relating to Core Data
extension SoundsListViewController : NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        soundsTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        soundsTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
        case.insert:
            if let indexPath = newIndexPath {
                soundsTableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                soundsTableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = soundsTableView.cellForRow(at: indexPath) as! ItemCell
                buildCell(cell: cell, indexPath: indexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                soundsTableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                soundsTableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
}


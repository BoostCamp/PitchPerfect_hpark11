//
//  SoundsListViewController.swift
//  PitchPerfect
//
//  Created by connect on 2017. 1. 11..
//  Copyright © 2017년 boostcamp. All rights reserved.
//

import UIKit
import CoreData

class SoundsListViewController: UIViewController {
    
    var itemController: NSFetchedResultsController<Item>!
    
    @IBOutlet weak var soundsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.soundsTableView.delegate = self
        self.soundsTableView.dataSource = self
        
        fetchData()
    }
    
    func fetchData() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let sortByDate = NSSortDescriptor(key: "created", ascending: false)
        request.sortDescriptors = [sortByDate]
        
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        self.itemController = controller
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    // playSoundsViewController needs to know what it should do when the segue is performed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playSavedFile" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
            playSoundsVC.isSaved = true
        }
    }
    
}

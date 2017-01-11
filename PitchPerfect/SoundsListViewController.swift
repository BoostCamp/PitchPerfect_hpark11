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
        
        //generateTestData()
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
    
    
    func generateTestData() {
        let item = Item(context: context)
        item.title = "Mac Book Pro"
        item.fileName = "ppp.wav"
        item.created = NSDate()
        
        let item2 = Item(context: context)
        item2 .title = "Mac Book Pro"
        item2.fileName = "ppp.wav"
        item2.created = NSDate()
        
        let item3 = Item(context: context)
        item3.title = "Mac Book Pro"
        item3.fileName = "ppp.wav"
        item3.created = NSDate()
        
        appDelegate.saveContext()
    }
    
}

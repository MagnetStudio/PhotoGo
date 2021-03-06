//
//  ImagesTableViewController.swift
//  PhotoGo
//
//  Created by Jack Ka on 9/27/2016.
//  Copyright (c) 2016 JackKa. All rights reserved.
//

import UIKit
import PhotoLib

class ImagesTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func refreshTable() {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImageService.sharedService.images.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let image = ImageService.sharedService.images[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("imageCell")! as UITableViewCell
        cell.textLabel?.text = image.title
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showImageSegue") {
            let indexPath: NSIndexPath = tableView.indexPathForSelectedRow!
            let image = ImageService.sharedService.images[indexPath.row]
            
            let destViewController = segue.destinationViewController as! ImageViewController
            destViewController.image = image
        }
        
    }
    
}

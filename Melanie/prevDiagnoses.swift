//
//  prevDiagnoses.swift
//  Melanie
//
//  Created by Jacob on 11/13/16.
//  Copyright © 2016 Ian Mobbs. All rights reserved.
//

import UIKit
import CoreData

class prevDiagnoses: UITableViewController {

    var moles = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moles.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! customViewCell

        let mole = moles[indexPath.row]
        let n = mole.valueForKey("n") as! String
        let dn = mole.valueForKey("dn") as! String
        let m = mole.valueForKey("m") as! String
        let rotated = UIImage(data: mole.valueForKey("mi") as! NSData, scale: 1.0)
        let mi = UIImage(CGImage: rotated!.CGImage!, scale: 1.0, orientation: UIImageOrientation.Right)
        
        
        
        cell.nevus.text = "Nevus: \(n)"
        cell.dysplasticNevus.text = "Dysplastic Nevus: \(dn)"
        cell.melanoma.text = "Melanoma: \(m)"
        cell.moleImage.image = mi
        

        return cell as UITableViewCell!
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Mole")
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            moles = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }


    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            //1
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            managedContext.deleteObject(moles[indexPath.row])
            moles.removeAtIndex(indexPath.row)
            do {
                try managedContext.save()
            } catch let error as NSError {
                print(error)
            }
            tableView.reloadData()
        }
    }

}

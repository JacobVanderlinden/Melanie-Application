//
//  DiagnosisViewController.swift
//  Melanie
//
//  Created by Ian Mobbs on 11/13/16.
//  Copyright © 2016 Ian Mobbs. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class DiagnosisViewController: UIViewController {
    
    var moles = [NSManagedObject]()
    @IBOutlet weak var moleImageView: UIImageView!
    var moleImage: UIImage!
    @IBOutlet weak var processingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var processingLabel: UILabel!
    @IBOutlet weak var nevus: UILabel!
    @IBOutlet weak var dysplasticnevus: UILabel!
    @IBOutlet weak var melanoma: UILabel!
    @IBAction func save(sender: UIButton) {
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Mole", inManagedObjectContext:managedContext)
        let mole = NSManagedObject(entity: entity!,  insertIntoManagedObjectContext: managedContext)
        
        //3
        mole.setValue(NSData(data: UIImagePNGRepresentation(moleImage)!), forKey: "mi")
        mole.setValue(nevus, forKey: "n")
        mole.setValue(dysplasticnevus, forKey: "dn")
        mole.setValue(melanoma, forKey: "m")
        
        //4
        do {
            try managedContext.save()
            //5
            moles.append(mole)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        processingIndicator.startAnimating()
        getMoleData()
    }
    
    override func viewWillAppear(animated: Bool) {
        moleImageView.image = moleImage
        processingLabel.alpha = 1
        processingIndicator.alpha = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getMoleData() {
        upload(moleImage)
        //nevus.text =
        //dysplasticnevus.text =
        //melanoma.text =
    }
    
    func upload(image:UIImage) {
        let imageData:NSData = UIImageJPEGRepresentation(image, 100)!
        SRWebClient.POST("http://8374d8af.ngrok.io")
            .data(imageData, fieldName:"image", data: ["timestamp":NSDate()])
            .send({(response:AnyObject!, status:Int) -> Void in
                print(response)
                // process success response
                self.updateLabels((response["nevus"] as? NSNumber)!.doubleValue, dn: (response["dysplasticnevus"] as? NSNumber)!.doubleValue, m: (response["melanoma"] as? NSNumber)!.doubleValue)
                },failure:{(error:NSError!) -> Void in
                // process failure response
                print(error)
            })
        
    }
    
    func updateLabels(n: Double, dn: Double, m: Double) {
        // Create text
        let nevusText = String(format:"%.4f", n * 100)
        let dysplasticText = String(format:"%.4f", dn * 100)
        let melanomaText = String(format:"%.4f", m * 100)
        // Update text
        self.nevus.text = "\(nevusText)%"
        self.dysplasticnevus.text = "\(dysplasticText)%"
        self.melanoma.text = "\(melanomaText)%"
        // Hide processing labels
        self.processingLabel.text = ""
        self.processingIndicator.hidesWhenStopped = true
        self.processingIndicator.stopAnimating()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

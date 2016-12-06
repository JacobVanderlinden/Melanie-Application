//
//  ViewController.swift
//  Melanie
//
//  Created by Ian Mobbs on 11/13/16.
//  Copyright © 2016 Ian Mobbs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var moleExample: UIView!
    var imageTaken: UIImage!
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapDiagnose(sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
    
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        dismissViewControllerAnimated(true, completion: nil)
        self.imageTaken = image
        performSegueWithIdentifier("diagnoseMole", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "diagnoseMole" {
            let destination = segue.destinationViewController as! DiagnosisViewController
            destination.moleImage = imageTaken
        }
    }

}


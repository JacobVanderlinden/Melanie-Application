//
//  DiagnosisViewController.swift
//  Melanie
//
//  Created by Ian Mobbs on 11/13/16.
//  Copyright © 2016 Ian Mobbs. All rights reserved.
//

import UIKit

class DiagnosisViewController: UIViewController {
    
    
    @IBOutlet weak var moleImageView: UIImageView!
    var moleImage: UIImage!
    @IBOutlet weak var processingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var processingLabel: UILabel!
    @IBOutlet weak var nevus: UILabel!
    @IBOutlet weak var dysplasticnevus: UILabel!
    @IBOutlet weak var melanoma: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        processingIndicator.startAnimating()
        nnSender()
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
    
    func nnSender() {
        upload(moleImage)
        //wait
        //nevus.text =
        //dysplasticnevus.text =
        //melanoma.text =
        
        
    }
    
    func upload(image: UIImage){
        let url = NSURL(string: "http://de34fa5b.ngrok.io/image")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        let imageData = UIImagePNGRepresentation(image)
        let base64String = imageData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        //print(base64String)
        let postString = "image=" + base64String
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
    
    
//    func upload(image: UIImage) {
//        
//        let url = NSURL(string: "http://de34fa5b.ngrok.io/image")
//        
//        let request = NSMutableURLRequest(URL: url!)
//        request.HTTPMethod = "POST"
//        
//        let boundary = generateBoundaryString()
//        
//        //define the multipart request type
//        
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        
//        //let image_data = UIImageJPEGRepresentation(image, 1)!.base64EncodedStringWithOptions([])
//        print(image_data)
//        
////        if(image_data == nil)
////        {
////            return
////        }
//        
//        
//        let body = NSMutableData()
//        
//        let fname = "mole.jpeg"
//        let mimetype = "image/jpeg"
//        
//        //define the data post parameter
//        
//        body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//        body.appendData("Content-Disposition:form-data; name=\"test\"\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//        body.appendData("hi\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//        
//        
//        
//        body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//        body.appendData("Content-Disposition:form-data; name=\"file\"; filename=\"\(fname)\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//        body.appendData("Content-Type: \(mimetype)\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//        body.appendData(image_data)
//        body.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//        
//        
//        body.appendData("--\(boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//        
//        
//        
//        request.HTTPBody = body
//        
//        
//        
//        let session = NSURLSession.sharedSession()
//        
//        
//        let task = session.dataTaskWithRequest(request) {
//            (
//            let data, let response, let error) in
//            
//            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
//                print("error")
//                return
//            }
//            
//            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print(dataString)
//            
//        }
//        
//        task.resume()
//        
//        
//    }
    
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().UUIDString)"
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

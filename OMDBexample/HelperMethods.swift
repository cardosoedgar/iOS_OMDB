//
//  HelperMethods.swift
//  OMDBexample
//
//  Created by Edgar Cardoso on 2/4/16.
//  Copyright © 2016 Edgar Cardoso. All rights reserved.
//
import Alamofire
import AlamofireImage
import UIKit

typealias finishDownloadImage = (image: Image) -> Void
typealias finishRequestingMovie = (json: AnyObject?, error: String?) -> Void

class HelperMethods {

    func createAlert(message: String) -> UIAlertController {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "Ok", style: .Default) { _ in }
        alertController.addAction(OKAction)
        return alertController
    }
    
    func startActivityIndicator() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func stopActivityIndicator() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    private func getDocumentsDirectory() -> NSString {
        return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!
    }
    
    func saveImage(image: UIImage?, filename: String) {
        if let data = UIImagePNGRepresentation(image!) {
            let path = getDocumentsDirectory().stringByAppendingPathComponent(filename)
            data.writeToFile(path, atomically: true)
        }
    }
    
    func getImage(filename: String) -> UIImage? {
        let path = getDocumentsDirectory().stringByAppendingPathComponent(filename)
        if let data = NSData(contentsOfFile: path) {
            return UIImage(data: data)
        }
        return nil
    }
    
    func downloadImage(path: String?, completionHandler: finishDownloadImage) {
        guard let stringPath = path else {
            return
        }
        
        Alamofire.request(.GET, stringPath).responseImage { response in
            if let image = response.result.value {
                completionHandler(image: image)
            }
        }
    }
    
    func requestMovie(url: String, completionHandler: finishRequestingMovie) {
        Alamofire.request(.GET, url).responseJSON {
            (response) -> Void in
            
            switch(response.result) {
                case .Success:
                    if let json = response.result.value {
                        completionHandler(json: json, error: nil)
                    }
                    break
                default:
                    completionHandler(json: nil, error: "Não foi possível se conectar com o servidor")
                    break
            }
        }
    }
}

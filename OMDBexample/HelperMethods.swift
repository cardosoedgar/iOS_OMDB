//
//  HelperMethods.swift
//  OMDBexample
//
//  Created by Edgar Cardoso on 2/4/16.
//  Copyright © 2016 Edgar Cardoso. All rights reserved.
//

import UIKit

class HelperMethods {
    
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
        let data = NSData(contentsOfFile: path)!
        return UIImage(data: data)
    }
}

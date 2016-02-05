//
//  ImageExtension.swift
//  OMDBexample
//
//  Created by Edgar Cardoso on 2/4/16.
//  Copyright © 2016 Edgar Cardoso. All rights reserved.
//
import Alamofire
import AlamofireImage
import UIKit

extension UIImageView {
    func downloadImage(path: String?) {
        let helperMethods = HelperMethods()
        helperMethods.downloadImage(path) { (image) -> Void in
            self.image = image
        }
    }
}

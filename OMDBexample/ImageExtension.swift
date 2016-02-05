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
        guard let stringPath = path else {
            return
        }
        
        Alamofire.request(.GET, stringPath).responseImage { response in
                
            if let image = response.result.value {
                self.image = image
            }
        }
    }
}

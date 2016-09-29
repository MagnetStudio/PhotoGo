//
//  Image.swift
//  PhotoGo
//
//  Created by Jack Ka on 9/27/2016.
//  Copyright (c) 2016 JackKa. All rights reserved.
//

import Foundation
import UIKit

public class Image: NSObject, NSCoding {
    
    public let title: String
    public let image: UIImage
    public var url: NSURL?
    
    public init(imgTitle: String, imgImage: UIImage) {
        title = imgTitle
        image = imgImage
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObjectForKey("title") as! String
        image = aDecoder.decodeObjectForKey("image") as! UIImage
        url = aDecoder.decodeObjectForKey("url") as? NSURL
    }
    
    public func encodeWithCoder(aCoder: NSCoder)  {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(image, forKey: "image")
        aCoder.encodeObject(url, forKey: "url")
    }
    
}

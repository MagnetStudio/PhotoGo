//
//  TempImage.swift
//  PhotoGo
//
//  Created by Jack Ka on 9/27/2016.
//  Copyright (c) 2016 JackKa. All rights reserved.
//

import Foundation

public class TempImage {
    
    public let imgurId: String
    public let title: String
    public var link: NSURL?
    
    public init(fromJson json: JSON) {
        imgurId = json["id"].string!
        title = json["title"].string ?? ""
        self.link = nil
        let urlString = json["link"].string!
        if let link = NSURL(string: urlString) {
            self.link = link
        }
    }
}
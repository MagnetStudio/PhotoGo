//
//  ImageViewController.swift
//  PhotoGo
//
//  Created by Jack Ka on 9/27/2016.
//  Copyright (c) 2016 JackKa. All rights reserved.
//

import UIKit
import PhotoLib

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var urlLabel: UILabel!
    var image: Image!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image.image
        title = image.title
        if let url = image.url {
            urlLabel.text = url.absoluteString
        }
    }
    
    @IBAction func copyURLtoClipboard(sender: UIBarButtonItem) {
        if let url = image.url {
            UIPasteboard.generalPasteboard().URL = url
        }
    }
    
}
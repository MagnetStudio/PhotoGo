//
//  ShareViewController.swift
//  PhotoGoEx
//
//  Created by Jack Ka on 9/27/2016.
//  Copyright (c) 2016 JackKa. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices
import PhotoLib

class ShareViewController: SLComposeServiceViewController {
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let content = extensionContext!.inputItems[0] as! NSExtensionItem
        let contentType = kUTTypeImage as String
        
        for attachment in content.attachments as! [NSItemProvider] {
            if attachment.hasItemConformingToTypeIdentifier(contentType) {
                    
                attachment.loadItemForTypeIdentifier(contentType, options: nil) { data, error in
                    if error == nil {
                        let url = data as! NSURL
                        if let imageData = NSData(contentsOfURL: url) {
                            self.selectedImage = UIImage(data: imageData)
                        }
                    } else {
                        
                        let alert = UIAlertController(title: "Error", message: "Error loading image", preferredStyle: .Alert)
                        
                        let action = UIAlertAction(title: "Error", style: .Cancel) { _ in
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                        
                        alert.addAction(action)
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    override func isContentValid() -> Bool {
        if selectedImage != nil{
            if !contentText.isEmpty {
                return true
            }
        }
        
        return false
    }
    
    override func didSelectPost() {
        let defaultSession = UploadImageService.sharedService.session
        let defaultSessionConfig = defaultSession.configuration
        let defaultHeaders = defaultSessionConfig.HTTPAdditionalHeaders
        let config = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("com.jackka.iosapp.PhotoGoEx.bkgrdsession")
        config.sharedContainerIdentifier = "group.com.jackka.iosapp.PhotoGo"
        config.HTTPAdditionalHeaders = defaultHeaders
        
        let session = NSURLSession(configuration: config, delegate: UploadImageService.sharedService, delegateQueue: NSOperationQueue.mainQueue())
        
        let completion: (TempImage?, NSError?, NSURL?) -> () = { image, error, tempURL in
            if error == nil {
                if let imageURL = image?.link {
                    let image = Image(imgTitle: self.contentText, imgImage: self.selectedImage!)
                    image.url = imageURL
                    let imageService = ImageService.sharedService
                    imageService.addImage(image)
                    imageService.saveImages()
                }
                if let container = tempURL {
                    if NSFileManager.defaultManager().isDeletableFileAtPath(container.path!) {
                        
                        do {
                            try NSFileManager.defaultManager().removeItemAtPath(container.path!)
                        } catch let error as NSError {
                            print("Error removing file at path: \(error.localizedDescription)")
                        }
                    }
                }
            } else {
                print("Error uploading image: \(error!)")
                if let container = tempURL {
                    if NSFileManager.defaultManager().isDeletableFileAtPath(container.path!) {
                        
                        do {
                            try NSFileManager.defaultManager().removeItemAtPath(container.path!)
                        } catch let error as NSError {
                            print("Error removing file at path: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
        
        let title = contentText
        UploadImageService.sharedService.uploadImage(selectedImage!, title: title, session: session, completion:completion)
        
        self.extensionContext?.completeRequestReturningItems([], completionHandler: nil)
    }
    
    override func configurationItems() -> [AnyObject]! {
        
        return []
    }

}

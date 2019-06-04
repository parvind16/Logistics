//
//  Utility.swift
//  Logistic
//
//  Created by parvind bhatt on 16/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import Foundation
import UIKit
import Reachability

 func isNetworkAvailable() -> Bool {
    let status = Reachability()?.connection
    return (status == Reachability.Connection.none) ? false : true
}

/* Show Progress Indicator */
func showProgressIndicator(view: UIView) {
    
    view.isUserInteractionEnabled = false
    // Create and add the view to the screen.
    let progressIndicator = ProgressIndicator(text: LocalizationConstant.loadingText)
    progressIndicator.tag = .kProgressIndicatorViewTag
    view.addSubview(progressIndicator)
    
}

/* Hide progress Indicator */
func hideProgressIndicator(view: UIView) {
    view.isUserInteractionEnabled = true
    if let viewWithTag = view.viewWithTag(.kProgressIndicatorViewTag) {
        viewWithTag.removeFromSuperview()
    }
    
}

func saveImageAtPath(imagePath: String, image: UIImage) {
    // get the documents directory url
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    // choose a name for your image
    let fileName = imagePath
    // create the destination file url to save your image
    let fileURL = documentsDirectory.appendingPathComponent(fileName)
    // get your UIImage jpeg data representation and check if the destination file url already exists
    if let data = image.jpegData(compressionQuality: 1.0),
        !FileManager.default.fileExists(atPath: fileURL.path) {
        do {
            // writes the image data to disk
            try data.write(to: fileURL)
            debugPrint("file saved")
        } catch {
            debugPrint("error saving file:", error)
        }
    }
}

func imageAtFilePath(imagePath: String) -> UIImage? {
    // get the documents directory url
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    // choose a name for your image
    let fileName = imagePath
    // create the destination file url to save your image
    let fileURL = documentsDirectory.appendingPathComponent(fileName)
    
    if FileManager.default.fileExists(atPath: fileURL.path) {
        if let image = UIImage(contentsOfFile: fileURL.path) {
            return image
        }
        return nil
    } else {
        return nil
    }
}

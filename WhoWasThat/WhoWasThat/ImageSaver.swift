//
//  ImageSaver.swift
//  WhoWasThat
//
//  Created by Cory Steers on 9/6/23.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writePhotoToDisk(_ image: UIImage, fileName: String) {
        do {
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                try jpegData.write(to: FileManager.documentsDirectory.appendingPathComponent(fileName), options: [.atomicWrite, .completeFileProtection])
            }
            successHandler?()
        } catch {
            errorHandler?(error)
//            print("Unable to save one of contact photo or contact data: \(error.localizedDescription)")
        }
    }
}

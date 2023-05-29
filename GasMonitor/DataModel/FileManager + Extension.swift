//
//  FileManager + Extension.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 29/05/2023.
//

import UIKit

extension FileManager {
    
    func retrieveImage(with id:String) -> UIImage? {
        let url = URL.documentsDirectory.appendingPathComponent("\(id).jpg")
        do {
            let imageData = try Data(contentsOf: url)
            return UIImage(data: imageData)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func saveImage(id:String, image:UIImage) {
        if let data = image.jpegData(compressionQuality: 0.6) {
            do {
                let url = URL.documentsDirectory.appendingPathComponent("\(id).jpg")
                try data.write(to: url)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("Could not save image...")
        }
    }
    
    func deleteImage(with id:String) {
        let url = URL.documentsDirectory.appendingPathComponent("\(id).jpg")
        if fileExists(atPath: url.path) {
            do {
                try removeItem(at: url)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("Image does not exist")
        }
    }
    
}

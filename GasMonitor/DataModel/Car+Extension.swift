////
////  Car+Extension.swift
////  GasMonitor
////
////  Created by Maxime BOULANGER on 28/05/2023.
////

import Foundation

extension Car {
    var nameView: String {
        model ?? ""
    }
    
    var imageID: String {
        imageId ?? ""
    }
}

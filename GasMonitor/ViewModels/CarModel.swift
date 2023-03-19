//
//  CarModel.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/03/2023.
//

import Foundation

class CarModel: ObservableObject {
    @Published var cars = [Car]()
    
    init () {
        // Create an instance of DataService and get the data
        self.cars = DataService().getLocalData()
        
        // Set the recipes property
        
    }
    
    func editCarInfo(forId: Int) {
        print("button")
        
    }
}

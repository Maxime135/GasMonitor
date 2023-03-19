//
//  CarModel.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/03/2023.
//

import Foundation

class CarModel: ObservableObject {
    @Published var cars = [Car]()
    
    init() {
        let pathString = Bundle.main.path(forResource: "cars", ofType: "json") // Optional
        
        if let path = pathString {
            let url = URL(fileURLWithPath: path)
            
            do {
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                
                do {
                    let carData = try decoder.decode([Car].self, from: data)
                    self.cars = carData
                }
                catch {
                    print(error)
                }
            }
            catch {
                print(error)
            }
        }
        
    }
}

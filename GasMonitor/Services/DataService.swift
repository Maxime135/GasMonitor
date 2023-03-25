//
//  DataService.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/03/2023.
//

import Foundation

class DataService {
    
    func getLocalData() -> [Car] {
        // ----- Perse the local JSON file
        // Get a url path to the JSON file
        let pathString = Bundle.main.path(forResource: "cars", ofType: "json")
        
        // Check if pathString is not nil, otherwise...
        guard pathString != nil else {
            return [Car]()
        }
        
        // Create a url object
        let url = URL(fileURLWithPath: pathString!)
        
        // Create a data object
        do {
            let data = try Data(contentsOf: url)
            
            // Decode data with a JSON decoder
            let decoder = JSONDecoder()
            
            do {
                let carData = try decoder.decode([Car].self, from: data)
                
                // Add the unique IDs for recipes
                for r in carData {
                    r.id = UUID()
                }
                
                // Return the recipies
                return carData
            }
            catch {
                print(error)
            }
        }
        catch {
            print(error)
        }
        return [Car]()
    }
    
    func writeData(_ totals: [Car]) -> Void {
        do {
            let pathString = Bundle.main.path(forResource: "cars", ofType: "json")
            let fileURL = URL(fileURLWithPath: pathString!)
            //let fileURL = try FileManager.default
            //    .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            //    .appendingPathComponent("pastData.json")
            
            try JSONEncoder()
                .encode(totals)
                .write(to: fileURL)
        } catch {
            print("error writing data")
        }
    }
    
}

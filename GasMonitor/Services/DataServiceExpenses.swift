//
//  DataServiceExpense.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 02/04/2023.
//

import Foundation

class DataServiceExpense {
    
    func getLocalData() -> [Expense] {
        // ----- Perse the local JSON file
        // Get a url path to the JSON file
        let pathString = Bundle.main.path(forResource: "expenses", ofType: "json")
        
        // Check if pathString is not nil, otherwise...
        guard pathString != nil else {
            return [Expense]()
        }
        
        // Create a url object
        let url = URL(fileURLWithPath: pathString!)
        
        // Create a data object
        do {
            let data = try Data(contentsOf: url)
            
            // Decode data with a JSON decoder
            let decoder = JSONDecoder()
            
            do {
                let expenseData = try decoder.decode([Expense].self, from: data)
                
                // Add the unique IDs for recipes
                for r in expenseData {
                    r.id = UUID()
                }
                
                // Return the recipies
                return expenseData
            }
            catch {
                print(error)
            }
        }
        catch {
            print(error)
        }
        return [Expense]()
    }
    
    func writeData(_ totals: [Expense]) -> Void {
        do {
            let pathString = Bundle.main.path(forResource: "expenses", ofType: "json")
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


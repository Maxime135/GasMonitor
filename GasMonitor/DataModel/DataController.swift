//
//  DataController.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/05/2023.
//

import Foundation
import CoreData
import UIKit
import SwiftUI

class DataController: ObservableObject {
    let container = NSPersistentContainer(name:"CarModel")
    
    static let shared = DataController()
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved!")
        } catch {
            print("Error while saving the data...")
        }
    }
    
    func addCar(brand: String, model:String, energy:String, milage:Int64, modelYear:Int64, tankCapacity:Int64?, horsepower:Int64?, engineSize:Float?, nickname:String?, image:UIImage?,color:String?, context:NSManagedObjectContext) {
        let car = Car(context: context)
        car.id = UUID()
        car.brand = brand
        car.model = model
        car.color = color
        car.energy = energy
        car.milage = milage
        car.modelYear = modelYear
//        car.image = "sputnik"
        car.nickname = nickname
        car.tankCapacity = tankCapacity ?? 0
        car.horsepower = horsepower ?? 0
        car.engineSize = engineSize ?? 0
        
        if (image != nil) {
            car.imageId = UUID().uuidString
        }
        
        save(context: context)
        
        if (image != nil) {
            FileManager().saveImage(id: car.imageId!, image: image!)
            print("image saved")
        }
        save(context: context)
        
        
    }
    
    func editCar(car: Car, brand: String, model:String, energy:String, milage:Int64, modelYear:Int64, tankCapacity:Int64?, horsepower:Int64?, engineSize:Float?, nickname:String?, image:UIImage?,color:String?, context:NSManagedObjectContext) {
        car.brand = brand
        car.model = model
        car.nickname = nickname
        car.energy = energy
        car.milage = milage
        car.modelYear = modelYear
        car.nickname = nickname
        car.tankCapacity = tankCapacity ?? 0
        car.horsepower = horsepower ?? 0
        car.engineSize = engineSize ?? 0
        car.color = color
        
        if (image != nil) {
            car.imageId = UUID().uuidString
        }
        
        save(context: context)
        
        if (image != nil) {
            FileManager().saveImage(id: car.imageId!, image: image!)
            print("image saved")
        }
        save(context: context)
    }
    
    
    
//    func updateGasMilage(car: Car, context:NSManagedObjectContext) {
//        var distance:Float = 0.0
//        var liters:Float = 0.0
//        let expenses = car.expenses!
//        
//        for expense in expenses {
//            distance += Float(expense.traveledDistance)
//            liters += Float(expense.liters)
//        }
//        
//        car.fuelConsumption = distance/liters
//    }
    
//    func getItem(with id: UUID?, context:NSManagedObjectContext) -> Car? {
//        guard let id = id else { return nil }
//        let request = Car.fetchRequest() as NSFetchRequest<Car>
//        request.predicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)
//        guard let cars = try? context.fetch(request) else { return nil }
//        return cars.first
//    }
    
//    func getCarFromId(id: UUID, context: NSManagedObjectContext) {
//        let context = container.viewContext
//        let request = NSFetchRequest<Car>(id)
//
//        do {
//            return try context.fetch(req)
//        } catch {
//            print("Could not find the select car...")
//        }
//    }
    
    func addExpense(car: Car, liters: Double, price:Double, traveledDistance:Int64, energy:String, place:String, date: Date, context:NSManagedObjectContext) {
        let expense = Expense(context: context)
        expense.id = UUID()
//        expense.car = car
        expense.liters = liters
        expense.price = price
        expense.traveledDistance = traveledDistance
        expense.place = place
        expense.energy = energy
        expense.date = date
        
//        car.fuelConsumption = (car.fuelConsumption*Float(car.milage)/100 + Float(expense.liters))/(Float(expense.traveledDistance)+Float(car.milage))
//        car.fuelConsumption += Float(expense.liters)/Float(expense.traveledDistance) * 100
        car.milage += traveledDistance
        
        
        car.addToExpenses(expense)
        
        car.fuelConsumption = calculateGasMilage(car: car)
        
        save(context: context)
//        try! context.save()
    }
    
    func editExpense(expense: Expense, liters: Double, price:Double, traveledDistance:Int64, energy:String, place:String, date: Date, context:NSManagedObjectContext) {
        var car = expense.car
        let previous_liters = expense.liters
        let previous_traveledDistance = expense.traveledDistance
        
        expense.liters = liters
        expense.price = price
        expense.traveledDistance = traveledDistance
        expense.place = place
        expense.energy = energy
        expense.date = date
        
        //updating gas milage & car milage:
//        car!.fuelConsumption -= Float(previous_liters)/Float(previous_traveledDistance) * 100
//        car!.fuelConsumption += Float(expense.liters)/Float(expense.traveledDistance) * 100
        car!.milage -= previous_traveledDistance
        car!.milage += traveledDistance
        
        car!.fuelConsumption = calculateGasMilage(car: car!)
        
        save(context: context)
//        try! context.save()
    }
    
    func calculateGasMilage(car:Car) -> Float {
//        let expenses:Expense = car.expenses!
        var gasMilage:Double = 0.0
        var totalLiters:Double = 0.0
        var totalDistance:Int64 = 0
        
//        ForEach(Array(car.expenses as? Set<Expense> ?? [])) { element in
//            totalLiters += element.liters
//            totalDistance += element.traveledDistance
//        }
//
        for expense in Array(car.expenses as? Set<Expense> ?? []) {
            totalLiters += expense.liters
            totalDistance += expense.traveledDistance
        }
        
        if totalDistance != 0 {
            gasMilage = totalLiters / Double(totalDistance) * 100
        }
        
        return(Float(gasMilage))
    }
    
    
    func colorToString(color:Color) -> String {
        let rgba = color.cgColor!.components
        return "\(rgba![0]) \(rgba![1]) \(rgba![2]) \(rgba![3])"
    }
    
    func stringToColor(stringColor:String) -> Color {
        let red = Double(stringColor.components(separatedBy: " ")[0])
        let green = Double(stringColor.components(separatedBy: " ")[1])
        let blue = Double(stringColor.components(separatedBy: " ")[2])
        let alpha = Double(stringColor.components(separatedBy: " ")[3])
        
        return Color(.sRGB, red: red!, green: green!, blue: blue!)
    }

}

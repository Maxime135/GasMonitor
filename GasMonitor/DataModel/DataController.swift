//
//  DataController.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/05/2023.
//

import Foundation
import CoreData

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
    
    func addCar(brand: String, model:String, energy:String, milage:Int64, modelYear:Int64, tankCapacity:Int64?, horsepower:Int64?, engineSize:Float?, nickname:String?, context:NSManagedObjectContext) {
        let car = Car(context: context)
        car.id = UUID()
        car.brand = brand
        car.model = model
        car.energy = energy
        car.milage = milage
        car.modelYear = modelYear
        car.image = "sputnik"
        car.nickname = nickname
        car.tankCapacity = tankCapacity ?? 0
        car.horsepower = horsepower ?? 0
        car.engineSize = engineSize ?? 0
        
        save(context: context)
    }
    
    func editCar(car: Car, brand: String, model:String, energy:String, milage:Int64, modelYear:Int64, tankCapacity:Int64?, horsepower:Int64?, engineSize:Float?, nickname:String?, context:NSManagedObjectContext) {
        car.brand = brand
        car.model = model
        car.energy = energy
        car.milage = milage
        car.modelYear = modelYear
        car.nickname = nickname
        car.tankCapacity = tankCapacity ?? 0
        car.horsepower = horsepower ?? 0
        car.engineSize = engineSize ?? 0
        
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
        car.milage += traveledDistance
        
        
        car.addToExpenses(expense)
        
        save(context: context)
//        try! context.save()
    }
    
    func editExpense(expense: Expense, liters: Double, price:Double, traveledDistance:Int64, energy:String, place:String, date: Date, context:NSManagedObjectContext) {
        
        expense.liters = liters
        expense.price = price
        expense.traveledDistance = traveledDistance
        expense.place = place
        expense.energy = energy
        expense.date = date
        
        save(context: context)
//        try! context.save()
    }
    
//    func getMonthInfo(context:NSManagedObjectContext) {
//        var priceThisMonth:Float = 0.0
//        var distanceThisMonth:Float = 0.0
//
//
//
//        @FetchRequest(
//            sortDescriptors: [SortDescriptor(keyPath: \Car.expenses.date, ascending: true)],
//            predicate: NSPredicate(format: "date >= %@", month as NSDate)
//        ) var expenseThisMonth: FetchedResults<Expense>
//        ) var expenseThisMonth: FetchedResults<Expense>
//
//    }
    
}

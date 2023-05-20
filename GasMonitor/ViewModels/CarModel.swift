////
////  CarModel.swift
////  GasMonitor
////
////  Created by Maxime BOULANGER on 19/03/2023.
////
//
//import Foundation
//
//class CarModel: ObservableObject {
//    @Published var cars = [Car]()
//    
//    init () {
//        // Create an instance of DataService and get the data
//        self.cars = DataService().getLocalData()
//        
//        // Set the recipes property
//        
//    }
//    
//    func editCarInfo(forCar: CarModel) {
//        print("editCarInfo")
//
//        
//    }
//    
//    func addCar(brand:String,
//                model:String,
//                nickname:String?,
//                energy:String,
//                image:String,
//                milage:Int,
//                modelYear:Int,
//                fuelConsumption:Float?,
//                tankCapacity:Int?,
//                horsepower:Int?,
//                engineSize:Float?) {
//        
//        print("addCar")
//        
//        let newCar = Car(brand, model, energy, image, milage, modelYear)
//        newCar.nickname = nickname
//        newCar.fuelConsumption = fuelConsumption
//        newCar.tankCapacity = tankCapacity
//        newCar.horsepower = horsepower
//        newCar.engineSize = engineSize
////        newCar.image = image
//        
//        self.cars.append(newCar)
//        
//    }
//    
//    func addExpense(car:Car,
//                    liters:Float,
//                    price:Float,
//                    traveledDistance:Float,
//                    energy:String,
//                    place:String?) {
//        
//        print("add expense to a car")
//        
//        let newExpense = Expense(liters, price, traveledDistance, energy)
//        newExpense.place = place
//        
//        car.expenses?.append(newExpense)
//        
//    }
//    
//}

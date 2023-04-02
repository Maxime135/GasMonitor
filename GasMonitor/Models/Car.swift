//
//  Car.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/03/2023.
//

import Foundation


class Car: Identifiable, Decodable, Encodable {
    var id:UUID?
    var brand:String
    var model:String
    var nickname:String?
    var energy:String
    var image:String
    var milage:Int
    var modelYear:Int
    var fuelConsumption:Float?
    var tankCapacity:Int?
    var horsepower:Int?
    var engineSize:Float?
    var expenses:[Expense]?
    
    init(_ ncBrand:String, _ ncModel:String, _ ncEnergy:String, _ ncImage:String, _ ncMilage:Int, _ ncModelYear:Int) {
        id = UUID()
        brand = ncBrand
        model = ncModel
        energy = ncEnergy
        image = ncImage
        milage = ncMilage
        modelYear = ncModelYear
    }
}

class Expense: Identifiable, Decodable, Encodable {
    var id:UUID?
//    var carID:UUID
    var liters:Float
    var price:Float
    var traveledDistance:Float
    var energy:String
    var place:String?
    
    init( _ Eliters:Float, _ Eprice:Float, _ EtraveledDistance:Float, _ Eenergy:String) {
        id = UUID()
//        carID = EcarID
        liters = Eliters
        price = Eprice
        traveledDistance = EtraveledDistance
        energy = Eenergy
    }
}

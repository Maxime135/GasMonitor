//
//  Car.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/03/2023.
//

import Foundation


class Car: Identifiable, Decodable {
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
}

class Expense: Identifiable, Decodable {
    var id:UUID?
    var car:[Car]
    var liters:Float
    var price:Float
    var traveledDistance:Float
    var energy:Int?
    var place:String?
}

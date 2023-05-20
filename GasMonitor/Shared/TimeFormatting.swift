//
//  TimeFormatting.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 20/05/2023.
//

import Foundation


extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}


func getMonthPrice() -> Float {
    var priceThisMonth:Float = 0.0
    var currentMonth = Date().get(.month)
    var currentYear = Date().get(.year)
    
//        ForEach(expense) { element in
    for element in expense {
        var expenseMonth = element.date!.get(.month)
        var expenseYear = element.date!.get(.year)
        
        if expenseMonth == currentMonth && expenseYear == currentYear {
            priceThisMonth += Float(element.price)
        }
    }
    return priceThisMonth
}

func getMonthDistance() -> Float {
    var distanceThisMonth:Float = 0.0
    var currentMonth = Date().get(.month)
    var currentYear = Date().get(.year)
    
//        ForEach(expense) { element in
    for element in expense {
        var expenseMonth = element.date!.get(.month)
        var expenseYear = element.date!.get(.year)
        
        if expenseMonth == currentMonth && expenseYear == currentYear {
            distanceThisMonth += Float(element.traveledDistance)
        }
    }
    return distanceThisMonth
}

func getDateAsString(date:Date) -> String {
    let dateFormatter = DateFormatter()

    // Set Date Format
    dateFormatter.dateFormat = "YY/MM/dd"

    // Convert Date to String
    
    return dateFormatter.string(from: date)
}

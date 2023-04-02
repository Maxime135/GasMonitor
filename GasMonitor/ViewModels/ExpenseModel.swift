////
////  Expense.swift
////  GasMonitor
////
////  Created by Maxime BOULANGER on 19/03/2023.
////
//
//import Foundation
//
//class ExpenseModel: ObservableObject {
//    @Published var expenses = [Expense]()
//
//    init () {
//        // Create an instance of DataService and get the data
//        self.expenses = DataServiceExpense().getLocalData()
//    }
//
//    func editExpenseInfo(forId: Int) {
//        print("editExpenseInfo")
//
//    }
//
//    var id:UUID?
//    var carID:UUID
//    var liters:Float
//    var price:Float
//    var traveledDistance:Float
//    var energy:String
//    var place:String?
//
//    func addExpense(carID:UUID, liters:Float, price:Float, traveledDistance:Float, energy:String, place:String?) {
//
//        print("addExpense")
//
//        let newExpense = Expense(carID, liters, price, traveledDistance, energy)
//        newExpense.place = place
//
//        self.expenses.append(newExpense)
//
//    }
//}

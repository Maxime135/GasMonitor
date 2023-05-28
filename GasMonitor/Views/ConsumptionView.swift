//
//  ConsumptionView.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/03/2023.
//

import SwiftUI

struct ConsumptionView: View {
    
//    @EnvironmentObject var model:CarModel
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors:[SortDescriptor(\.brand)]) var car:FetchedResults<Car>
    @FetchRequest(sortDescriptors:[SortDescriptor(\.date)]) var expense:FetchedResults<Expense>
//    @State var place:String?


    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                HStack {
                    Text("This Month")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                Text("Sun, 2 April")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
                    .padding(.bottom)
                
                HStack {
                    ZStack {
                        Rectangle()
                            .frame(height: 75.0)
                            .foregroundColor(/*@START_MENU_TOKEN@*/Color(hue: 0.384, saturation: 0.382, brightness: 0.643)/*@END_MENU_TOKEN@*/)
                            .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                            .shadow(color: .gray, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        VStack {
                            HStack {
                                Image(systemName: "dollarsign.circle.fill")
                                    .foregroundColor(.yellow)
                                Text("EXPENSES")
                                    .font(.caption)
                                    .foregroundColor(Color.white)
                                Spacer()
                            }
                            Text(String(getMonthPrice())+" €")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                        }
                        .padding(.all)
                    }
                    ZStack {
                        Rectangle()
                            .frame(height: 75.0)
                            .foregroundColor(/*@START_MENU_TOKEN@*/Color(hue: 0.55, saturation: 0.492, brightness: 1.0)/*@END_MENU_TOKEN@*/)
                            .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                            .shadow(color: .gray, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        VStack {
                            HStack {
                                Image(systemName: "fuelpump.circle.fill")
                                    .foregroundColor(.red)
                                Text("DISTANCE")
                                    .font(.caption)
                                    .foregroundColor(Color.white)
                                Spacer()
                            }
                            Text(String(getMonthDistance())+" km")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                        }
                        .padding(.all)
                    }
                }
                
                ForEach(car) { element in
                    Text(element.model!)
                        .font(.title3)
                        .padding(.top)
                    
    //                Text(String(element.expenses!.count))
                    
                    List {
                        ForEach(Array(element.expenses as? Set<Expense> ?? [])) { expenseElement in
                            NavigationLink(destination: EditExpenseView(expense:expenseElement)) {
                                VStack {
                                    HStack {
            //                            Text(String(expenseElement.traveledDistance) + " km")
                                        Text(String(expenseElement.price) + " €")
                                            .font(.subheadline)
                                        Spacer()
                                        Text(getDateAsString(date: expenseElement.date!))
                                            .font(.subheadline)
                                            .foregroundColor(Color.gray)

                                    }
                                    HStack {
                                        Text(expenseElement.place ?? "")
                                            .font(.subheadline)
                                            .foregroundColor(Color.gray)
                                        Spacer()
                                    }

                                }.padding(.leading)
                            }
                            
                        }
                        .onDelete(perform: deleteExpense)
                    }
                    .listStyle(.plain)
    //                ForEach(Array(element.expenses as? Set<Expense> ?? [])) { expenseElement in
    //                    VStack {
    //                        HStack {
    ////                            Text(String(expenseElement.traveledDistance) + " km")
    //                            Text(String(expenseElement.price) + " €")
    //                                .font(.subheadline)
    //                            Spacer()
    //                            Text(expenseElement.place ?? "")
    //                                .font(.subheadline)
    //                                .foregroundColor(Color.gray)
    //
    //                        }
    //
    ////                        HStack {
    ////                            Spacer()
    ////                            Text(expenseElement.place ?? "")
    ////                                .font(.subheadline)
    ////                                .foregroundColor(Color.gray)
    ////                        }
    //
    //                    }.padding(.leading)
    //                }
                }
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
        .navigationViewStyle(.stack)
        
        
    }
    
    
    
    
    func getMonthPrice() -> Int {
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
        return Int(priceThisMonth)
    }
    
    func getMonthDistance() -> Int {
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
        return Int(distanceThisMonth)
    }
    
    func getDateAsString(date:Date) -> String {
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "YY/MM/dd"

        // Convert Date to String
        
        return dateFormatter.string(from: date)
    }
    
    
    private func deleteExpense(offsets: IndexSet) {
        withAnimation {
            offsets.map { expense[$0] }.forEach(managedObjectContext.delete)
            
            DataController().save(context: managedObjectContext)
        }
    }
}

struct ConsumptionView_Previews: PreviewProvider {
    static var previews: some View {
        ConsumptionView()
//            .environmentObject(CarModel())
    }
}


extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

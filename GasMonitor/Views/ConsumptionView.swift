//
//  ConsumptionView.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/03/2023.
//

import SwiftUI
import Charts

struct ConsumptionView: View {
    
//    @EnvironmentObject var model:CarModel
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors:[SortDescriptor(\.brand)]) var car:FetchedResults<Car>
    @FetchRequest(sortDescriptors:[SortDescriptor(\.date, order: .reverse)]) var expense:FetchedResults<Expense>
//    @State var place:String?
    
    @State private var chartPeriodSelection = 1

    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                HStack {
                    Text("This Month")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                HStack {
                    Text(getMonthString(date:Date()))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray)
                        .padding(.bottom)
                    Spacer()
//                    Picker("Period", selection: $chartPeriodSelection ) {
//                        Text("Month").tag(1)
//                        Text("Year").tag(2)
//                    }
//                    .pickerStyle(.segmented)
                }
                
                
                // Month global overview
                
                HStack {
                    ZStack {
                        Rectangle()
                            .frame(height: 75.0)
                            .foregroundColor(.green)
                            .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
//                            .shadow(color: .gray, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
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
                            .foregroundColor(.blue)
                            .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
//                            .shadow(color: .gray, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
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
                
                // Bar Chart
                
                HStack {
                    if chartPeriodSelection == 1 {
                        Chart {
                            
                            ForEach(expense) { shape in
                                    BarMark(
        //                                   x: .value("Month", getMonthString(monthInt: shape.date!.get(.month))),
                                        x: .value("Month", getMonthString(monthInt: shape.date!.get(.month))),
                                        y: .value("€", shape.price)
                                    )
                                    .foregroundStyle(by: .value("Car", shape.car!.model!))
                                    .cornerRadius(5)
        //                                .annotation(position: .overlay) {
        //                                    Text(String(shape.car!.model!))
        //                                        .foregroundColor(Color.white)
        //                                        .font(.system(size: 12, weight: .bold))
        //                                }
                                    }
                            
//                                ForEach(expense) { shape in
//                                        BarMark(
//        //                                    x: .value("Month", getMonthString(monthInt: shape.date!.get(.month))),
//                                            x: .value("Year", shape.date!.get(.year)),
//                                            y: .value("€", shape.price)
//                                        )
//                                        .foregroundStyle(by: .value("Car", shape.car!.model!))
//                                        .cornerRadius(5)
//        //                                .annotation(position: .overlay) {
//        //                                    Text(String(shape.car!.model!))
//        //                                        .foregroundColor(Color.white)
//        //                                        .font(.system(size: 12, weight: .bold))
//        //                                }
//                                    }
                            
                            
                        }
                        
    //                    ForEach(car) { car in
    //                            .chartForegroundStyleScale([car.model: DataController.shared.stringToColor(stringColor: car.color ?? "0.9800000786781311 0.8999999761581421 0.19999998807907104 1.0")])
    //                    }
    //                    .chartForegroundStyleScale([
                        //                        "Green": .green, "Purple": .purple, "Pink": .pink, "Yellow": .yellow
                        //                    ])
                        .chartYAxisLabel {
                            Text("€")
                        }
    //                    .chartYScale(domain: 2022...2024)
                        .onTapGesture {
                            chartPeriodSelection = 2
                        }
                    } else {
                        Chart {
                            ForEach(expense) { shape in
                                BarMark(
                                    //                                    x: .value("Month", getMonthString(monthInt: shape.date!.get(.month))),
                                    x: .value("Year", String(shape.date!.get(.year))),
                                    y: .value("€", shape.price)
                                    )
                                    .foregroundStyle(by: .value("Car", shape.car!.model!))
                                    .cornerRadius(5)
                                    //                                .annotation(position: .overlay) {
                                    //                                    Text(String(shape.car!.model!))
                                    //                                        .foregroundColor(Color.white)
                                    //                                        .font(.system(size: 12, weight: .bold))
                                    //                                }
                            }
                        }
                        .chartYAxisLabel {
                            Text("€")
                        }
//                        .chartXScale(domain: 2022...2024)
                        .onTapGesture {
                            chartPeriodSelection = 1
                        }
                        
                    }
                    
                    
                }
                .frame(height: 250.00)
                
//                ForEach(car) { element in
//                    Text(element.model!)
//                        .font(.title3)
//                        .padding(.top)
//
//    //                Text(String(element.expenses!.count))
//
//                    List {
//                        ForEach(Array(element.expenses as? Set<Expense> ?? [])) { expenseElement in
//                            NavigationLink(destination: EditExpenseView(expense:expenseElement)) {
//                                VStack {
//                                    HStack {
//            //                            Text(String(expenseElement.traveledDistance) + " km")
//                                        Text(String(expenseElement.price) + " €")
//                                            .font(.subheadline)
//                                        Spacer()
//                                        Text(getDateAsString(date: expenseElement.date!))
//                                            .font(.subheadline)
//                                            .foregroundColor(Color.gray)
//
//                                    }
//                                    HStack {
//                                        Text(expenseElement.place ?? "")
//                                            .font(.subheadline)
//                                            .foregroundColor(Color.gray)
//                                        Spacer()
//                                    }
//
//                                }.padding(.leading)
//                            }
//
//                        }
//                        .onDelete(perform: deleteExpense)
//                    }
//                    .listStyle(.plain)
//    //                ForEach(Array(element.expenses as? Set<Expense> ?? [])) { expenseElement in
//    //                    VStack {
//    //                        HStack {
//    ////                            Text(String(expenseElement.traveledDistance) + " km")
//    //                            Text(String(expenseElement.price) + " €")
//    //                                .font(.subheadline)
//    //                            Spacer()
//    //                            Text(expenseElement.place ?? "")
//    //                                .font(.subheadline)
//    //                                .foregroundColor(Color.gray)
//    //
//    //                        }
//    //
//    ////                        HStack {
//    ////                            Spacer()
//    ////                            Text(expenseElement.place ?? "")
//    ////                                .font(.subheadline)
//    ////                                .foregroundColor(Color.gray)
//    ////                        }
//    //
//    //                    }.padding(.leading)
//    //                }
//                }
                
                Text("Expenses")
                                        .font(.title3)
                                        .padding(.top)
                
                List {
                    ForEach(expense) { expenseElement in
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
                                    Text(expenseElement.car!.model!)
                                        .font(.subheadline)
                                        .foregroundColor(Color.blue)
                                }

                            }.padding(.leading)
                        }
                        
                    }
                    .onDelete(perform: deleteExpense)
                }
                .listStyle(.plain)
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
        .navigationViewStyle(.stack)
        
        
    }
    
    func getMonthString(monthInt:Int) -> String {
        let monthFirstLetter:[String] = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        return monthFirstLetter[monthInt-1]
    }
    
    
    func getMonthString(date:Date) -> String {
        let month:String = ["January","February","March","April","May","June","July","August","September","October","November","December"][date.get(.month)-1]
        let day:String = ["Sun","Mon","Tues","Wed","Thr","Fri","Sat"][date.getDayNumberOfWeek()!-1]
        return String(day+", "+String(date.get(.day))+" "+month)
    }
    
    
    func getMonthPrice() -> Int {
        var priceThisMonth:Float = 0.0
        let currentMonth = Date().get(.month)
        let currentYear = Date().get(.year)
        
//        ForEach(expense) { element in
        for element in expense {
            let expenseMonth = element.date!.get(.month)
            let expenseYear = element.date!.get(.year)
            
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
        dateFormatter.dateFormat = "MM/dd/YY"

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
    func getDayNumberOfWeek() -> Int? {
            return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

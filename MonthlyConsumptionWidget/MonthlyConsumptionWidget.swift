//
//  MonthlyConsumptionWidget.swift
//  MonthlyConsumptionWidget
//
//  Created by Maxime BOULANGER on 17/06/2023.
//

import WidgetKit
import SwiftUI
import Charts

struct Provider: TimelineProvider {
    
//    @Environment(\.managedObjectContext) var managedObjectContext
//    @FetchRequest(sortDescriptors:[SortDescriptor(\.brand)]) var car:FetchedResults<Car>
    
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), fuelConsumtpion: Float(6.9), carMilage: 31200)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), fuelConsumtpion: Float(6.9), carMilage: 31200)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let cars = try! getData()
        let carFuelConsumption = cars.first?.fuelConsumption ?? 0.0
        let carMilage:Int64 = cars.first?.milage ?? 0
//        let selectedCar = car.first
//        let carFuelConsumption = car.first?.fuelConsumption ?? 0.0
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, fuelConsumtpion: Float(6.9))
//            entries.append(entry)
//        }
        
        let entry = SimpleEntry(date: currentDate, fuelConsumtpion: carFuelConsumption, carMilage: carMilage)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    private func getData() throws -> [Car] {
        let context = DataController.shared.container.viewContext
        
        let request = Car.fetchRequest()
        let result = try context.fetch(request)
        
        print("succeded getting car data")
        
        return result
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let fuelConsumtpion: Float
    let carMilage:Int64
}

struct MonthlyConsumptionWidgetEntryView : View {
    
    
    
    var entry: Provider.Entry
    
    var gradient = Gradient(colors: [.green, .orange])

    var body: some View {
        VStack() {
            HStack {
                Text(String(getMonthString(monthInt: Date().get(.month))))
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.gray)
                Spacer()
            }
            Spacer()
            
            Chart {
                BarMark(
                    x: .value("Milage", 15)
                    )
                .foregroundStyle(.linearGradient(gradient, startPoint: .leading, endPoint: .trailing))
                .clipShape(RoundedRectangle(cornerRadius: 10))
//                BarMark(
//                    x: .value("Milage", 5)
//                    )
//                .foregroundStyle(.purple)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
                PointMark(
                    x: .value("Current", entry.fuelConsumtpion),
                    y: .value("Current", 0)
                )
                .foregroundStyle(Color.blue)
                
            }
                
//            .chartXScale(domain: 0...10)
            
//            ZStack {
//                Capsule()
//                    .frame(height: 15.0)
//            }
            
            
//            Rectangle()
//                .frame(height: 20.0)
//                .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
//                .cornerRadius(10)
            HStack {
                Spacer()
                Text(String(format: "%.1f", entry.fuelConsumtpion))
                    .fontWeight(.bold)
                    .foregroundColor(Color(hue: 0.579, saturation: 0.859, brightness: 0.997))
                Text("L/100km")
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
            }
            
                
            Spacer()
            
            HStack(alignment: .bottom) {
                Spacer()
                Text(String(entry.carMilage))
                    .fontWeight(.bold)
                    .foregroundColor(Color.green)
                
                Text("km")
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
}


struct MonthlyConsumptionWidget: Widget {
    let kind: String = "MonthlyConsumptionWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MonthlyConsumptionWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

func getMonthString(monthInt:Int) -> String {
    let monthFirstLetter:[String] = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    return monthFirstLetter[monthInt-1]
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


struct MonthlyConsumptionWidget_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyConsumptionWidgetEntryView(entry: SimpleEntry(date: Date(), fuelConsumtpion: Float(6.9), carMilage: 31200))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


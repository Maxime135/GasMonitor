//
//  EditExpenseView.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 20/05/2023.
//

import SwiftUI
import MapKit

struct EditExpenseView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    var expense: FetchedResults<Expense>.Element
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Car.brand, ascending: true)], animation: .default)
    var cars: FetchedResults<Car>
    
    
    @State var selectedCar: Car?
    @State var selectedFuel:String = ""
    @State var fuelPrice:Double = 0
    @State var drivenDistance:Int64 = 0
    @State var fuelQuantity:Double = 0.0
    @State var place:String? = ""
    @State var date:Date = Date()
    
    @State var price:Double = 0
    
    // Geolocation related
    @StateObject private var mapAPI = MapAPI()
    @State var adressText = ""
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $mapAPI.region, annotationItems: mapAPI.locations) { location in
                MapMarker(coordinate: location.coordinate, tint: .red)
            }
            .frame(height: 200.0)
            
            Divider()
            
            Form {
                Section {
                    Picker("select car", selection: $selectedCar) {
    //                        ForEach(cars, id: \.self) { (element: Car) in
    //                            Text(element.model!).tag(element)
    //                        }
                        ForEach(cars) { element in
                            Text(element.model!).tag(Optional(element))
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onAppear {
                        selectedCar = expense.car
                        selectedFuel = expense.energy!
                        fuelPrice = expense.price
                        drivenDistance = expense.traveledDistance
                        fuelQuantity = expense.liters
                        place = expense.place
                        price = expense.price
                        adressText = expense.place ?? ""
                    }
                }
                
                Section {
                    HStack {
                        Text("Energy")
                        Spacer()
                        Picker("select fuel", selection: $selectedFuel) {
                            Text("E85").tag("E85")
                            Text("E95").tag("E95")
                            Text("E95-E10").tag("E95-E10")
                            Text("E98").tag("E98")
                            Text("Diesel").tag("Diesel")
                            Text("Electricity").tag("Electricity")
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    HStack {
                        Text("Volume (L)")
                        Spacer()
                        TextField("", value: $fuelQuantity, formatter: NumberFormatter())
                            .frame(width: 50.0)
                            .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                            .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    HStack {
                        Text("Distance (km)")
                        Spacer()
                        TextField("", value: $drivenDistance, formatter: NumberFormatter())
                            .frame(width: 50.0)
                            .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                            .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    HStack {
                        Text("Price (€)")
                        Spacer()
                        TextField("", value: $price, formatter: NumberFormatter())
                            .frame(width: 50.0)
                            .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                            .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    HStack {
                        DatePicker(
                                "Date",
                                selection: $date,
                                displayedComponents: [.date]
                            )
                        .datePickerStyle(.compact)
                    }
                    HStack {
                        Text("Location")
                        Spacer()
                        TextField("Address", text: $adressText)
                            .frame(width: 125.0)
                            .font(.body)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .onSubmit {
                                mapAPI.getLocation(address: adressText, delta: 0.005)
                            }
                    }
                }
            }
            
            Button {
                DataController.shared.editExpense(expense: expense, liters: fuelQuantity, price: price, traveledDistance: drivenDistance, energy: selectedFuel, place: adressText, date: date, context: managedObjectContext)
                dismiss()
            } label: {
                //Image(systemName: "checkmark.circle.fill")
                ZStack {
                    Rectangle()
                        .foregroundColor(/*@START_MENU_TOKEN@*/.green/*@END_MENU_TOKEN@*/)
                        .frame(height: 50.0)
                        .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        .padding(.all)
                    Text("Edit")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }
            }
            .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
            .onAppear {
                mapAPI.getLocation(address: adressText, delta: 0.005)
            }
            
        }
        
    }
}

//struct EditExpenseView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditExpenseView()
//    }
//}

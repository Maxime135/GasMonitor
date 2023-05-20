//
//  AddExpenseView.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/03/2023.
//

import SwiftUI
import MapKit

struct AddExpenseView: View {
    
//    @EnvironmentObject var model:CarModel
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss

//    @State private var cars:FetchedResults<Car>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Car.brand, ascending: true)], animation: .default)
    var cars: FetchedResults<Car>
      
    @State var selectedCar: Car?

    
//    @State var selectedCar:Int = 0
    @State var selectedFuelType:Int = 1
    @State var selectedFuel:String = "E95-E10"
    @State var fuelPrice:Double = 1.0
    @State var drivenDistance:Int64 = 500
    @State var fuelQuantity:Double = 10.0
    @State var place:String? = "Orgeval"
    
    @State var price:Double = 20.0
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.75773, longitude: -73.985708), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    
//    init(moc: NSManagedObjectContext) {
//        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
//        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Car.brand, ascending: true)]
//        fetchRequest.predicate = NSPredicate(value: true)
//        self._cars = FetchRequest(fetchRequest: fetchRequest)
//        do {
//            let firstCar = try moc.fetch(fetchRequest)
//            self._selection = State(initialValue: firstCar[0])
//        } catch {
//            fatalError("Uh, fetch problem...")
//        }
//    }
    
    
    var body: some View {
        VStack {
            //TextField("€", text: $price)
            //    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Map(coordinateRegion: $region, interactionModes: [])
                .frame(height: 200.0)
            
            Divider()
            
            ScrollView {
                ZStack {
                    Rectangle()
                        
                        .foregroundColor(Color(red: 0.0, green: 0.4, blue: 1.0, opacity: 0.3))
                        //.border(/*@START_MENU_TOKEN@*/Color(hue: 0.629, saturation: 0.816, brightness: 0.777)/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                        .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal)
                        
                    VStack(alignment: .center) {
                        HStack {
                            Text("Price")
                                .foregroundColor(Color.gray)
                                .padding(.leading)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        HStack(alignment: .center) {
                            TextField("", value: $price, formatter: NumberFormatter())
                                //.padding(/*@START_MENU_TOKEN@*/.horizontal, 100.0/*@END_MENU_TOKEN@*/)
                                //.padding([.top, .leading, .bottom])
                                //.frame(height: 100.0)
                                .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                                .scaledToFit()
                                .fontWeight(/*@START_MENU_TOKEN@*/.heavy/*@END_MENU_TOKEN@*/)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                            Text("€")
                                .foregroundColor(.gray)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            
                        }
                    }
                    .padding(.all)
                }
                .padding(.all)
                .frame(height: 125.0)
                
                Divider()
                
                HStack {
                    Text("Car")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Picker("select car", selection: $selectedCar) {
//                        ForEach(cars, id: \.self) { (element: Car) in
//                            Text(element.model!).tag(element)
//                        }
                        ForEach(cars) { element in
                            Text(element.model!).tag(Optional(element))
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Energy")
                        .font(.title2)
                        .fontWeight(.semibold)
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
                .padding(.horizontal)
                
                HStack {
                    Text("Volume (L)")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("", value: $fuelQuantity, formatter: NumberFormatter())
                        .frame(width: 50.0)
                        .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                        .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        
                    
                    
                }
                .padding(.horizontal)
                HStack {
                    Text("Driven distance (km)")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("", value: $drivenDistance, formatter: NumberFormatter())
                        .frame(width: 50.0)
                        .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                        .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    
                }
                .padding(.horizontal)
                
                Button {
//                    model.addExpense(car: model.cars[selectedCar], liters: fuelQuantity, price: fuelPrice, traveledDistance: drivenDistance, energy: selectedFuel, place: place)
                    
//                    let car:Car = managedObjectContext.objectWithID(selectedCar) as! Car
                    print("selected fuel: \(selectedFuel)")
                    print("selected car: \(selectedCar!.model)")
                    
                    DataController.shared.addExpense(car: selectedCar!, liters: fuelQuantity, price: price, traveledDistance: drivenDistance, energy: selectedFuel, place: place!, date: Date(), context: managedObjectContext)
                    dismiss()
                } label: {
                    //Image(systemName: "checkmark.circle.fill")
                    ZStack {
                        Rectangle()
                            .foregroundColor(/*@START_MENU_TOKEN@*/.green/*@END_MENU_TOKEN@*/)
                            .frame(height: 50.0)
                            .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                            .padding(.all)
                        Text("Add")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                }
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
                
            }
            
            

            
            
            
            //Spacer()
        }
        .ignoresSafeArea(.all, edges: .top)
    }
    
    
    
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
//            .environmentObject(CarModel())
    }
}

//
//  AddExpenseView.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/03/2023.
//

import SwiftUI
import MapKit

struct AddExpenseView: View {
    
    @EnvironmentObject var model:CarModel
    @State var selectedCar:Int = 0
    @State var selectedFuelType:Int = 1
    @State var fuelPrice:Float = 1.0
    @State var drivenDistance:Float = 500.0
    @State var fuelQuantity:Float = 10.0
    
    @State var price:Float = 20.0
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.75773, longitude: -73.985708), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    
    
    var body: some View {
        VStack {
            //TextField("€", text: $price)
            //    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Map(coordinateRegion: $region, interactionModes: [])
                .frame(height: 250.0)
            
            Divider()
            
            ScrollView {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(red: 0.0, green: 0.4, blue: 1.0, opacity: 0.1))
                        .border(/*@START_MENU_TOKEN@*/Color(hue: 0.629, saturation: 0.816, brightness: 0.777)/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                        .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                        
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
                                .padding([.top, .leading, .bottom])
                                .frame(width: 100.0, height: 100.0)
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
                .padding(.horizontal)
                .frame(height: 175.0)
                
                Divider()
                
                HStack {
                    Text("Car")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Picker("select car", selection: $selectedCar) {
                        ForEach(model.cars) { element in
                            Text(element.model).tag(element.id)
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
                    Picker("select fuel", selection: $selectedFuelType) {
                        Text("E85").multilineTextAlignment(.leading).tag(1)
                        Text("E95").tag(2)
                        Text("E95-E10").tag(3)
                        Text("E98").tag(4)
                        Text("Diesel").tag(5)
                        Text("Electricity").tag(6)
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
                        .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                        .fontWeight(.semibold)
                        .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                    
                }
                .padding(.horizontal)
                HStack {
                    Text("Distance (km)")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("", value: $drivenDistance, formatter: NumberFormatter())
                        .frame(width: 50.0)
                        .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                        .fontWeight(.semibold)
                        .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                    
                }
                .padding(.horizontal)
                
            }
            
            
            
            //Spacer()
        }
        .ignoresSafeArea()
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
            .environmentObject(CarModel())
    }
}

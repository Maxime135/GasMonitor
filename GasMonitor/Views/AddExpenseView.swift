//
//  AddExpenseView.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/03/2023.
//

import SwiftUI

struct AddExpenseView: View {
    
    @EnvironmentObject var model:CarModel
    @State var selectedCar:Int = 0
    @State var selectedFuelType:Int = 1
    @State var fuelPrice:Float = 1.0
    @State var drivenDistance:Float = 500.0
    @State var fuelQuantity:Float = 10.0
    
    @State var price:Float = 20.0
    
    var body: some View {
        VStack {
            //TextField("€", text: $price)
            //    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            HStack(alignment: .center) {
                TextField("Price €", value: $price, formatter: NumberFormatter())
                    //.padding(/*@START_MENU_TOKEN@*/.horizontal, 100.0/*@END_MENU_TOKEN@*/)
                    .padding(.all)
                    .frame(width: 100.0, height: 100.0)
                    .keyboardType(/*@START_MENU_TOKEN@*/.numberPad/*@END_MENU_TOKEN@*/)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .scaledToFit()
                Text("€")
                    .foregroundColor(.gray)
                Spacer()
            }
            
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
                Text("Type of Fuel")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Picker("select fuel", selection: $selectedFuelType) {
                    Text("E10").tag(1)
                    Text("E85").tag(2)
                    Text("E95").tag(3)
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
                
            }
            .padding(.horizontal)
            
        }
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
            .environmentObject(CarModel())
    }
}

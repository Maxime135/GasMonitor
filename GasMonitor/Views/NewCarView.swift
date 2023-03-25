//
//  NewCarView.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 25/03/2023.
//

import SwiftUI

struct NewCarView: View {
    
    @EnvironmentObject var model:CarModel
    
    @State var brand:String = ""
    @State var carModel:String = ""
    @State var nickname:String = ""
    @State var energy:String = ""
    @State var image:String = ""
    @State var milage:Int = 0
    @State var modelYear:Int = 0
    @State var tankCapacity:Int = 0
    @State var horsepower:Int?
    @State var engineSize:Float?
    
    
    @State var selectedCar:Int = 0
    @State var selectedFuelType:Int = 1
    @State var fuelPrice:Float = 1.0
    @State var drivenDistance:Float = 500.0
    @State var fuelQuantity:Float = 10.0
    
    @State var price:Float = 20.0
    
    var body: some View {
        
        VStack {
            ScrollView {
                
                HStack {
                    Text("Brand")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("enter the brand", text: $brand)
                        .frame(width: 125)
                        .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Model")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("enter the model", text: $carModel)
                        .frame(width: 125)
                        .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Nickname")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("optional", text: $nickname)
                        .frame(width: 125)
                        .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Energy")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Picker("select fuel", selection: $energy) {
                        Text("Gas").multilineTextAlignment(.leading).tag("gas")
                        Text("Diesel").tag("diesel")
                        Text("Flexfuel").tag("flexfuel")
                        Text("GPL").tag("gpl")
                        Text("Electric").tag("electric")
                    }
                    .frame(width: 200.0)
                    .pickerStyle(MenuPickerStyle())
                    
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Milage (km)")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("", value: $milage, formatter: NumberFormatter())
                        .frame(width: 125.0)
                        .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                        .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Model Year")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("", value: $modelYear, formatter: NumberFormatter())
                        .frame(width: 125.0)
                        .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                        .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Fuel Tank Capacity (L)")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("", value: $tankCapacity, formatter: NumberFormatter())
                        .frame(width: 125.0)
                        .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                        .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Engine Power (HP)")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("optional", value: $horsepower, formatter: NumberFormatter())
                        .frame(width: 125.0)
                        .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                        .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Engine Size (L)")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("optional", value: $engineSize, formatter: NumberFormatter())
                        .frame(width: 125.0)
                        .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                        .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Picture")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Button {
                        //
                    } label: {
                        Text("Add a picture")
                            .foregroundColor(Color.blue)
                            .multilineTextAlignment(.leading)
                            .frame(width: 150.0)
                    }

                }
                .padding(.horizontal)
                
            }
            
            Button {
                //
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
            .padding(/*@START_MENU_TOKEN@*/[.leading, .bottom, .trailing]/*@END_MENU_TOKEN@*/)

            
            
            
            //Spacer()
        }
    }
}

struct NewCarView_Previews: PreviewProvider {
    static var previews: some View {
        NewCarView()
            .environmentObject(CarModel())
    }
}

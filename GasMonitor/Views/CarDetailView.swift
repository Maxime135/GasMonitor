//
//  CarDetailView.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/03/2023.
//

import SwiftUI

struct CarDetailView: View {
    
    @EnvironmentObject var model:CarModel
    var car:Car
    
    var body: some View {
        ScrollView {
            VStack{
                Image(car.image)
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                    
                HStack {
                    Text(car.model)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Text(car.nickname ?? "")
                        .foregroundColor(.gray)
                }
                .padding([.top, .leading, .trailing])
                
                Divider()
                    
                Group {
                    HStack {
                        Text("Brand :")
                        Spacer()
                        Text(car.brand)
                    }
                    HStack {
                        Text("Model :")
                        Spacer()
                        Text(car.model)
                    }
                    HStack {
                        Text("Energy :")
                        Spacer()
                        Text(car.energy)
                    }
                    HStack {
                        Text("Milage (km) :")
                        Spacer()
                        Text(String(car.milage))
                            .foregroundColor(.green)
                    }
                    HStack {
                        Text("Model Year :")
                        Spacer()
                        Text(String(car.modelYear))
                    }
                    HStack {
                        Text("Fuel Consumption (L/100km) :")
                        Spacer()
                        Text(String(car.fuelConsumption ?? 0))
                            .foregroundColor(.red)
                    }
                    HStack {
                        Text("Tank Capacity (L) :")
                        Spacer()
                        Text(String(car.tankCapacity ?? 0))
                    }
                    HStack {
                        Text("HP :")
                        Spacer()
                        Text(String(car.horsepower ?? 0))
                    }
                    HStack {
                        Text("Engine Size (L) :")
                        Spacer()
                        Text(String(car.engineSize ?? 0))
                    }
                }
                
                HStack {
                    Spacer()
                    //Button {
                    //    model.editCarInfo(forId: car.id)
                    //} label: {
                    //    Text("Edit")
                    //}
                    Text("Edit")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.horizontal)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.green/*@END_MENU_TOKEN@*/)
                        .cornerRadius(/*@START_MENU_TOKEN@*/6.0/*@END_MENU_TOKEN@*/)
                        
                        
                    Spacer()
                    
                }
                .padding(.top, 15.0)
                
                
                
            }
            .padding(.horizontal)
        }

    }
}

struct CarDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let model = CarModel()
        CarDetailView(car: model.cars[0])
    }
}

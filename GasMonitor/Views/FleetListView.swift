//
//  FleetListView.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/03/2023.
//

import SwiftUI

struct FleetListView: View {
    
    @EnvironmentObject var model: CarModel
    
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                

                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(model.cars) { element in
                            NavigationLink(destination: CarDetailView(car: element), label: {
                                HStack(spacing: 20.0) {
                                    Image(element.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50.0, height: 50.0, alignment: .center)
                                        .clipped()
                                        .cornerRadius(5.0)
                                    
                                    VStack(alignment: .leading) {
                                        
                                        HStack {
                                            Text(element.brand)
                                                .fontWeight(.bold)
                                            .foregroundColor(Color.black)
                                            Text(element.model)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color.black)
                                        }
                                        
                                        
                                        
                                            
                                        HStack {
                                            Text(element.nickname ?? "")
                                                .foregroundColor(.gray)
                                            Spacer()
                                            Text(String(element.milage)+" km")
                                                .foregroundColor(.green)
                                                
                                        }
                                        
                                    }
                                    
                                }
                            })

                        }
                    }
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                }
                
                NavigationLink {
                    NewCarView()
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
                            .frame(height: 50.0)
                            .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                            .padding(.all)
                        Text("Add a new car")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                }
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
                
                .navigationTitle(Text("Car Fleet"))
                .navigationBarTitleDisplayMode(.large)
                
            }
        }
        
        
    }
}

struct FleetListView_Previews: PreviewProvider {
    static var previews: some View {
        FleetListView()
            .environmentObject(CarModel())
    }
}

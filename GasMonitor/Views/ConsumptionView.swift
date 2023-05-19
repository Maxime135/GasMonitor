//
//  ConsumptionView.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/03/2023.
//

import SwiftUI

struct ConsumptionView: View {
    
    @EnvironmentObject var model:CarModel
//    @State var place:String?

    
    var body: some View {
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
                        Text("230.23 €")
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
                        Text("230.23 km")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                    .padding(.all)
                }
            }
            
            ForEach(model.cars) { element in
                Text(element.model)
                    .font(.title3)
                    .padding(.top)
                ForEach(element.expenses ?? [Expense(0.0, 0.0, 0, "E95-E10")]) { expenseElement in
                    VStack {
                        HStack {
//                            Text(String(expense.traveledDistance) + " km")
                            Text(String(expenseElement.price) + " €")
                            Spacer()
                            Text(expenseElement.place ?? "")
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                            
                        }
                            
//                        HStack {
//                            Spacer()
//                            Text(expense.place ?? "")
//                                .font(.subheadline)
//                                .foregroundColor(Color.gray)
//                        }
                            
                    }.padding(.leading)
                }
            }
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ConsumptionView_Previews: PreviewProvider {
    static var previews: some View {
        ConsumptionView()
            .environmentObject(CarModel())
    }
}

//
//  MainView.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/03/2023.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var model: CarModel
    @State var tabIndex = 1
    
    var body: some View {
        TabView(selection: $tabIndex) {
            ScrollView{
                Text(model.cars[1].model)
            }
            .tabItem {
                VStack{
                    Image(systemName: "chart.bar.xaxis")
                    Text("Overview")
                }
            }
            FleetListView()
            .tabItem {
                VStack{
                    Image(systemName: "car.2")
                    Text("Fleet")
                }
            }
        
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(CarModel())
    }
}

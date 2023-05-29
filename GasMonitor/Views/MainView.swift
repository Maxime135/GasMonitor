//
//  MainView.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/03/2023.
//

import SwiftUI
import CoreData

struct MainView: View {
    //@ObservedObject var model = CarModel()
    //@EnvironmentObject var model: CarModel
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors:[SortDescriptor(\.brand)]) var car:FetchedResults<Car>
    
    @State private var tabIndex = 1
    
    
    var body: some View {
        TabView(selection: $tabIndex) {
            ConsumptionView()
            .tabItem {
                VStack{
                    Image(systemName: "chart.bar.xaxis")
                    Text("Overview")
                }.tag(1)
            }
            AddExpenseView()
                .tabItem {
                    VStack{
                        Image(systemName: "plus.circle.fill")
                        Text("Add")
                    }
                }.tag(2)
            FleetListView()
            .tabItem {
                VStack{
                    Image(systemName: "car.2")
                    Text("Fleet")
                }
            }.tag(3)
            
        
            
        }
//        .environmentObject(CarModel())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
//            .environmentObject(CarModel())
            .environment(\.managedObjectContext, DataController().container.viewContext)
            
    }
}

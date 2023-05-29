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
    
    @State var tabIndex = 3
    
    
    var body: some View {
        TabView(selection: $tabIndex) {
            ConsumptionView()
            .tabItem {
                VStack{
                    Image(systemName: "chart.bar.xaxis")
                    Text("Overview")
                }
            }
            AddExpenseView()
                .tabItem {
                    VStack{
                        Image(systemName: "plus.circle.fill")
                        Text("Add")
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

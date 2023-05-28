//
//  FleetListView.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/03/2023.
//

import SwiftUI

struct FleetListView: View {
    
//    @EnvironmentObject var model: CarModel
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors:[SortDescriptor(\.brand)]) var car:FetchedResults<Car>
    
    @State private var showingAddView = false
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                
 
                
                    List {
                        ForEach(car) { element in
                            NavigationLink(destination: CarDetailView(car: element), label: {
                                HStack(spacing: 20.0) {
//                                    Image(element.image!)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: 50.0, height: 50.0, alignment: .center)
//                                        .clipped()
//                                        .cornerRadius(5.0)
                                    
                                    VStack(alignment: .leading) {
                                        
                                        HStack {
//                                            Text(element.brand)
//                                                .fontWeight(.bold)
//                                            .foregroundColor(Color.black)
                                            Text(element.model!)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color.black)
                                            Spacer()
                                            Text(element.nickname ?? "")
                                                .foregroundColor(Color.gray)
                                        }
                                            
                                        HStack {
                                            Text(element.brand!)
                                                .foregroundColor(.gray)
                                                .fontWeight(.bold)
                                            Spacer()
                                            Text(String(element.milage)+" km")
                                                .foregroundColor(.green)
                                        }
                                    }
                                }
                                .padding(.bottom)
//                                .swipeActions {
//                                    Button("Delete") {
//                                        print("Awesome!")
//                                    }
//                                    .tint(.red)
//                                }
                            })
                        }
                            .onDelete(perform: deleteCar)
                    }.listStyle(.plain)
                    
                    
                
                
//                NavigationLink {
//                    NewCarView()
//                } label: {
//                    ZStack {
//                        Rectangle()
//                            .foregroundColor(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
//                            .frame(height: 50.0)
//                            .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
//                            .padding(.all)
//                        Text("Add a new car")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                            .foregroundColor(Color.white)
//                    }
//                }
//                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
                
                .navigationTitle(Text("Car Fleet"))
                .navigationBarTitleDisplayMode(.large)
                
            }
            
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Car", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                NewCarView()
            }
            
        }
        .navigationViewStyle(.stack)
        
        
    }
    
    private func deleteCar(offsets: IndexSet) {
        withAnimation {
            offsets.map { car[$0] }.forEach(managedObjectContext.delete)
            
            DataController().save(context: managedObjectContext)
        }
    }
}

struct FleetListView_Previews: PreviewProvider {
    static var previews: some View {
        FleetListView()
//            .environmentObject(CarModel())
    }
}

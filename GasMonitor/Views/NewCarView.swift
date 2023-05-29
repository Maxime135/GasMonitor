//
//  NewCarView.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 25/03/2023.
//

import SwiftUI
import PhotosUI

struct NewCarView: View {
    
//    @EnvironmentObject var model:CarModel
    @Environment(\.managedObjectContext) var managedObjectContext
////    var expense: FetchedResults<Expense>.Element
//    var car: FetchedResults<Car>.Element
    @Environment(\.dismiss) var dismiss
    
    
    @State var brand:String = ""
    @State var carModel:String = ""
    @State var nickname:String = ""
//    @State var carColorString:String?
    @State var energy:String = ""
//    @State var image:String = ""
    @State var milage:Int64 = 0
    @State var fuelConsumption:Float?
    @State var modelYear:Int64 = 0
    @State var tankCapacity:Int64 = 0
    @State var horsepower:Int64 = 0
    @State var engineSize:Float = 0
    
    // Color choice
    @State var carColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    
    
    @State var selectedCar:Int = 0
    @State var selectedFuelType:Int = 1
    @State var fuelPrice:Float = 1.0
    @State var drivenDistance:Float = 500.0
    @State var fuelQuantity:Float = 10.0
    
    @State var price:Float = 20.0
    
//    Variables related to the selected image:
//    @State private var selectedItem: PhotosPickerItem? = nil
//    @State private var selectedImageData: Data? = nil
    @StateObject private var imagePicker = ImagePicker()
//    @State private var image:UIImage?
    
    var body: some View {
        
        VStack {
            
            Form {
                Section {
                    HStack {
                        Text("Brand")
                        Spacer()
                        TextField("enter the brand", text: $brand)
                            .frame(width: 125)
                            .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    HStack {
                        Text("Model")
                        Spacer()
                        TextField("enter the model", text: $carModel)
                            .frame(width: 125)
                            .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    HStack {
                        Text("Nickname")
                        Spacer()
                        TextField("optional", text: $nickname)
                            .frame(width: 125)
                            .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    HStack {
                        Text("Color")
                            Spacer()
                            ColorPicker("", selection: $carColor)
                    }
                }
                
                Section {
                    HStack {
//                        Text("Energy")
//                        Spacer()
                        Picker("Energy", selection: $energy) {
                            Text("Gas").multilineTextAlignment(.leading).tag("gas")
                            Text("Diesel").tag("diesel")
                            Text("Flexfuel").tag("flexfuel")
                            Text("GPL").tag("gpl")
                            Text("Electric").tag("electric")
                        }
//                        .frame(width: 210.0)
                        .pickerStyle(MenuPickerStyle())
                    }
                    HStack {
                        Text("Milage")
                        Spacer()
                        TextField("", value: $milage, formatter: NumberFormatter())
                            .frame(width: 125.0)
                            .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                            .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    HStack {
                        Text("Model Year")
                        Spacer()
                        TextField("", value: $modelYear, formatter: NumberFormatter())
                            .frame(width: 125.0)
                            .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                            .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    HStack {
                        Text("Fuel Tank Capacity (L)")
                        Spacer()
                        TextField("", value: $tankCapacity, formatter: NumberFormatter())
                            .frame(width: 125.0)
                            .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                            .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                }
                
                Section {
                    HStack {
                        Text("Engine Power (HP)")
                        Spacer()
                        TextField("optional", value: $horsepower, formatter: NumberFormatter())
                            .frame(width: 125.0)
                            .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                            .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    HStack {
                        Text("Engine Size (L)")
                        Spacer()
                        TextField("optional", value: $engineSize, formatter: NumberFormatter())
                            .frame(width: 125.0)
                            .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                            .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                }
                
                Section {
                    HStack {
                        Text("Picture")
                        Spacer()
                        PhotosPicker("Picture", selection: $imagePicker.imageSelection, matching: .images, photoLibrary: .shared())
                            .buttonStyle(.plain)
                    }
                    
                    if (imagePicker.uiImage != nil) {
                        Image(uiImage: imagePicker.uiImage!)
        //                            .resizable()
        //                            .scaledToFit()
        //                            .frame(width: 250, height: 250)
                                    .resizable()
                                    .scaledToFill()
//        //                            .frame(width: 300, height: 300)
//                                    .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
//                                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
//                                    .padding(.bottom)
                    }
                    
                }
                
                
                
            }
        
            
            Button {
                DataController.shared.addCar(brand: brand, model: carModel, energy: energy, milage:milage, modelYear:modelYear, tankCapacity:tankCapacity, horsepower:horsepower, engineSize:engineSize, nickname:nickname, image: imagePicker.uiImage, color: DataController.shared.colorToString(color: carColor), context:managedObjectContext)
                dismiss()
                
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

            
            
            
            //Spacer()
        }
    }
}

struct NewCarView_Previews: PreviewProvider {
    static var previews: some View {
        NewCarView()
//            .environmentObject(CarModel())
    }
}

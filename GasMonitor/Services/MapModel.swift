////
////  MapModel.swift
////  GasMonitor
////
////  Created by Maxime BOULANGER on 28/05/2023.
////
//
//// https://www.youtube.com/watch?v=dJ6f2o92tKg
//
//import Foundation
//import MapKit
//
//struct Adress: Codable {
//    let data: [Datum]
//}
//
//struct Datum: Codable {
//    let lattitude, longitude: Double
//    let name:String?
//    let postalCode:String?
//    let region:String?
//    let country:String?
//
////                "latitude": 38.897675,
////                "longitude": -77.036547,
////                "label": "1600 Pennsylvania Avenue NW, Washington, DC, USA",
////                "name": "1600 Pennsylvania Avenue NW",
////                "type": "address",
////                "number": "1600",
////                "street": "Pennsylvania Avenue NW",
////                "postal_code": "20500",
////                "confidence": 1,
////                "region": "District of Columbia",
////                "region_code": "DC",
////                "administrative_area": null,
////                "neighbourhood": "White House Grounds",
////                "country": "United States",
////                "country_code": "US",
////                "map_url": "http://map.positionstack.com/38.897675,-77.036547"
//}
//
//struct Location: Identifiable {
//    let id = UUID()
//    let name:String
//    let coordinates: CLLocationCoordinate2D
//}
//
//
//class MapAPI: ObservableObject {
//    private let BASE_URL = "http: //api.positionstack.com/v1/forward"
//    private let API_KEY = "e1377abef7c4a48ec02b760ea20129b2"
//
//    @Published var region:MKCoordinateRegion
//    @Published var coordinates = []
//    @Published var locations: [Location] = []
//
//    init() {
//        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        self.locations.insert(Location(name: "Pin", coordinates: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.1275)), at: 0)
//    }
//
//    func getLocation(adress:String, delta:Double) {
//        let pAddress = adress.replacingOccurrences(of: " ", with: "%20")
//        let url_string = "\(BASE_URL)?access_key=\(API_KEY)&query=\(pAddress)"
//
//        guard let url = URL(string: url_string) else {
//            print("Invalid URL")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) {(data, response, error) in
//            guard let data = data else {
//                print(error!.localizedDescription)
//                return
//            }
//
//            guard let newCoordinates = try? JSONDecoder().decode(Adress.self, from: data) else { return }
//
//            if newCoordinates.data.isEmpty {
//                print("Could not find the adress")
//                return
//            }
//
//            DispatchQueue.main.async {
//                let details = newCoordinates.data[0]
//                let lat = details.lattitude
//                let lon = details.longitude
//                let name = details.name
//                let postal_code = details.postalCode
//                let region = details.region
//
//                self.coordinates = [lat, lon]
//                self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta))
//
//                let new_location = Location(name: name ?? "Pin", coordinates: CLLocationCoordinate2D(latitude: lat, longitude: lon))
//                self.locations.removeAll()
//                self.locations.insert(new_location, at: 0)
//
//                print("Succesfully loaded the location!")
//            }
//        }.resume()
//    }
//}


import Foundation
import MapKit

// Address Data Model
struct Address: Codable {
   let data: [Datum]
}

struct Datum: Codable {
   let latitude, longitude: Double
   let name: String?
}

// Our Pin Locations
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

class MapAPI: ObservableObject{
   private let BASE_URL = "http://api.positionstack.com/v1/forward"
   private let API_KEY = "e1377abef7c4a48ec02b760ea20129b2"
   
   @Published var region: MKCoordinateRegion
   @Published var coordinates = []
   @Published var locations: [Location] = []
   
   
   init() {
      // Defualt Info
       self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
      
      self.locations.insert(Location(name: "Pin", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)), at: 0)
   }
   
   // API request
   func getLocation(address: String, delta: Double) {
      let pAddress = address.replacingOccurrences(of: " ", with: "%20")
      let url_string = "\(BASE_URL)?access_key=\(API_KEY)&query=\(pAddress)"
   
      guard let url = URL(string: url_string) else {
         print("Invalid URL")
         return }
      
      URLSession.shared.dataTask(with: url) { (data, response, error) in
         guard let data = data else {
            print(error!.localizedDescription)
            return }
         
         guard let newCoordinates = try? JSONDecoder().decode(Address.self, from: data) else { return }
         
         if newCoordinates.data.isEmpty {
            print("Could not find address...")
            return
         }
         
         // Set the new data
         DispatchQueue.main.async {
            let details = newCoordinates.data[0]
            let lat = details.latitude
            let lon = details.longitude
            
            self.coordinates = [lat, lon]
            self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta))
            
            let new_location = Location(name: "\(details.name)", coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            self.locations.removeAll()
            self.locations.insert(new_location, at: 0)
            
            print("Successfully loaded location! \(details.name)")
         }
      }
      .resume()
   }
}

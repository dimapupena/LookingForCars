//
//  Car.swift
//  TestProject
//
//  Created by Dmytro Pupena on 25.03.2022.
//

import Foundation
import MapKit

struct Car: Codable {
    let id: String
    let modelIdentifier: String
    let modelName: String
    let name: String
    let make: String
    let group: String
    let color: String
    let series: String
    let fuelType: String
    let fuelLevel: Double
    let transmission: String
    let licensePlate: String
    let latitude: Double
    let longitude: Double
    let innerCleanliness: String
    let carImageUrl: String
}

class CarAnnotation: NSObject, MKAnnotation {
    let car: Car
    var coordinate: CLLocationCoordinate2D
    
    init(car: Car, coordinate: CLLocationCoordinate2D) {
        self.car = car
        self.coordinate = coordinate
    }
}


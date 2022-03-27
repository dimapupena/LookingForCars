//
//  AppNetworkingsService.swift
//  TestProject
//
//  Created by Dmytro Pupena on 25.03.2022.
//

import Foundation

protocol NetworkingService {
    func getCarsFromServer() -> [Car]?
}

class AppNetworkingsService: NetworkingService {
    
    func getCarsFromServer() -> [Car]? {
        let urlString = "https://cdn.sixt.io/codingtask/cars"

         if let url = URL(string: urlString) {
             if let data = try? Data(contentsOf: url) {
                 if let cars = try? JSONDecoder().decode([Car].self, from: data) {
                    return cars
                 }
             }
         }
        return nil
    }
    
}

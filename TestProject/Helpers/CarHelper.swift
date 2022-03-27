//
//  CarHelper.swift
//  TestProject
//
//  Created by Dmytro Pupena on 27.03.2022.
//

import Foundation
import UIKit

class CarHelper {
    static func getFuelLevelImage(_ car: Car?) -> UIImage? {
        guard let car = car else { return nil}
        if car.fuelLevel < 0.4 {
            return UIImage(named: "LowFuelLevel")
        } else if car.fuelLevel < 0.85 {
            return UIImage(named: "MediumFuelLevel")
        } else {
            return UIImage(named: "FullFuelLevel")
        }
    }
}

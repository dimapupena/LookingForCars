//
//  Presenter.swift
//  TestProject
//
//  Created by Dmytro Pupena on 25.03.2022.
//

import Foundation

protocol PresenterDelegate: AnyObject {
    func gotCarsFromServer(cars: [Car])
    func gettingCarsFromServerFailed()
}

class MainPresenter {
    
    private var networkingServce: NetworkingService
    private var dataManager: AppDataManager
    
    weak var delegate: PresenterDelegate?
    
    init(_ networkingServce: NetworkingService, _ dataManager: AppDataManager) {
        self.networkingServce = networkingServce
        self.dataManager = dataManager
    }
    
    func downloadCars() {
        if let cars = networkingServce.getCarsFromServer(), cars.count > 0 {
            dataManager.cars = cars
            delegate?.gotCarsFromServer(cars: cars)
        } else {
            delegate?.gettingCarsFromServerFailed()
        }
    }
    
    func getCars() -> [Car] {
        return dataManager.cars
    }
}

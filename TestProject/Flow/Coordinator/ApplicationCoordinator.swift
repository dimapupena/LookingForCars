//
//  ApplicationCoordinator.swift
//  TestProject
//
//  Created by Dmytro Pupena on 25.03.2022.
//

import Foundation
import UIKit

class ApplicationCoordinator {
    var router: UINavigationController
    var networkingservice: NetworkingService
    var dataManager: AppDataManager

    init(router : UINavigationController) {
        self.router = router
        self.networkingservice = AppNetworkingsService()
        self.dataManager = AppDataManager()
    }
    
    func start() {
        showMainFlow()
    }

    private func showMainFlow() {
        let vc = MainViewController(presenter: MainPresenter(networkingservice, dataManager))
        vc.openCarDetails = { [weak self] car in
            self?.openCarDetailsFlow(car: car)
        }
        router.pushViewController(vc, animated: true)
    }
    
    private func openCarDetailsFlow(car: Car) {
        let vc = CarDetailsViewController(car: car)
        vc.showCarOnTheMap = { [weak self] car in
            self?.router.dismiss(animated: true, completion: {
                if let vc = self?.router.visibleViewController as? MainViewController {
                    vc.showCarOnTheMap(car)
                }
            })
        }
        router.present(vc, animated: true, completion: nil)
    }
}

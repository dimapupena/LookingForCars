//
//  CarDetailsViewController.swift
//  TestProject
//
//  Created by Dmytro Pupena on 26.03.2022.
//

import Foundation
import UIKit
import Kingfisher

class CarDetailsViewController: UIViewController {
    
    var showCarOnTheMap: ((Car) -> Void)?
    
    private let car: Car
    
    private var carImageView: UIImageView = UIImageView()
    private var carNameLabel: UILabel = UILabel()
    private var fuelLevelTitle: UILabel = UILabel()
    private var fuelLevelImage: UIImageView = UIImageView()
    private var showCarButton: UIButton = UIButton()
    
    init(car: Car) {
        self.car = car
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        setupCarNameLabel()
        setupCarImageView()
        setupFuelLevelLabel()
        setupFuelLevelImage()
        setupShowCarButton()
    }
    
    private func setupCarNameLabel() {
        view.addSubview(carNameLabel)
        
        carNameLabel.translatesAutoresizingMaskIntoConstraints = false
        carNameLabel.text = car.name
        carNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        carNameLabel.textAlignment = .center
        
        carNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        carNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        carNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        carNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupCarImageView() {
        view.addSubview(carImageView)
        
        carImageView.translatesAutoresizingMaskIntoConstraints = false
        carImageView.kf.setImage(with: URL(string: car.carImageUrl), placeholder: UIImage(named: "DefaultCarImage"))
        carImageView.contentMode = .scaleAspectFill
        
        carImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        carImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        carImageView.topAnchor.constraint(equalTo: carNameLabel.bottomAnchor, constant: 10).isActive = true
        carImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 80).isActive = true
    }
    
    private func setupFuelLevelLabel() {
        view.addSubview(fuelLevelTitle)
        
        fuelLevelTitle.translatesAutoresizingMaskIntoConstraints = false
        fuelLevelTitle.text = "Fuel Level"
        fuelLevelTitle.font = UIFont.boldSystemFont(ofSize: 14)
        fuelLevelTitle.textAlignment = .center
        
        fuelLevelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        fuelLevelTitle.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 20).isActive = true
        fuelLevelTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupFuelLevelImage() {
        view.addSubview(fuelLevelImage)
        
        fuelLevelImage.translatesAutoresizingMaskIntoConstraints = false
        fuelLevelImage.image = CarHelper.getFuelLevelImage(car)
        fuelLevelImage.contentMode = .scaleAspectFit
        
        fuelLevelImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        fuelLevelImage.centerYAnchor.constraint(equalTo: fuelLevelTitle.centerYAnchor).isActive = true
        fuelLevelImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        fuelLevelImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupShowCarButton() {
        view.addSubview(showCarButton)
        
        showCarButton.backgroundColor = .systemBlue
        showCarButton.layer.cornerRadius = 25
        showCarButton.setTitle("Show on the map", for: .normal)
        showCarButton.translatesAutoresizingMaskIntoConstraints = false
        showCarButton.addTarget(self, action: #selector(showCarOnTheMapAction), for: .touchUpInside)
        
        showCarButton.topAnchor.constraint(equalTo: fuelLevelTitle.bottomAnchor, constant: 30).isActive = true
        showCarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        showCarButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        showCarButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func showCarOnTheMapAction() {
        self.showCarOnTheMap?(car)
    }
}


//
//  CarsTableViewCell.swift
//  TestProject
//
//  Created by Dmytro Pupena on 26.03.2022.
//

import Foundation
import UIKit

class CarsTableViewCell: UITableViewCell {
 
    private var car: Car?
    
    private var carImageView: UIImageView = UIImageView()
    private var carNameLabel: UILabel = UILabel()
    private var fuelLevelImage: UIImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        selectionStyle = .none
    }
    
    func setupWithData(_ car: Car) {
        self.car = car
        
        setupCarNameLabel()
        setupCarImageView()
        setupFuelLevelImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCarNameLabel() {
        addSubview(carNameLabel)
        
        carNameLabel.translatesAutoresizingMaskIntoConstraints = false
        carNameLabel.text = car?.name
        carNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        carNameLabel.textAlignment = .center
        
        carNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        carNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        carNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupCarImageView() {
        addSubview(carImageView)
        
        carImageView.translatesAutoresizingMaskIntoConstraints = false
        carImageView.kf.setImage(with: URL(string: car?.carImageUrl ?? ""), placeholder: UIImage(named: "DefaultCarImage"))
        carImageView.contentMode = .scaleAspectFill
        
        carImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        carImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        carImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        carImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupFuelLevelImage() {
        addSubview(fuelLevelImage)
        
        fuelLevelImage.translatesAutoresizingMaskIntoConstraints = false
        fuelLevelImage.image = CarHelper.getFuelLevelImage(car)
        fuelLevelImage.contentMode = .scaleAspectFit
        
        fuelLevelImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        fuelLevelImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        fuelLevelImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        fuelLevelImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
}

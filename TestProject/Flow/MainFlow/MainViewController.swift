//
//  ViewController.swift
//  TestProject
//
//  Created by Dmytro Pupena on 25.03.2022.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    var openCarDetails: ((Car) -> Void)?
    
    var standartCoordinate: CLLocationCoordinate2D?
    
    private var loaderView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        view.style = UIActivityIndicatorView.Style.medium
        view.backgroundColor = .gray
        view.alpha = 0.7
        
        view.color = .systemBlue
        return view
    }()
    
    private var mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var carsTableView: UITableView = {
        let view = UITableView()
        view.register(CarsTableViewCell.self, forCellReuseIdentifier: "CarsTableViewCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var resetCoordinateMapViewButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 25
        button.setTitle("Reset", for: .normal)
        button.alpha = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(resetMapCoordinateAction), for: .touchUpInside)
        return button
    }()
    
    private var presenter: MainPresenter
    
    init(presenter: MainPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        presenter.delegate = self
        presenter.downloadCars()
        
        setupMapView()
        setupLoaderView()
        setupCarsTableView()
        setupResetButton()
    }
    
    private func setupLoaderView() {
        view.addSubview(loaderView)
        
        loaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loaderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupMapView() {
        view.addSubview(mapView)
        
        mapView.delegate = self
        
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/3).isActive = true
    }
    
    private func setupCarsTableView() {
        view.addSubview(carsTableView)
        
        carsTableView.delegate = self
        carsTableView.dataSource = self
        
        carsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        carsTableView.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        carsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        carsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupResetButton() {
        view.addSubview(resetCoordinateMapViewButton)
        
        resetCoordinateMapViewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        resetCoordinateMapViewButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -20).isActive = true
        resetCoordinateMapViewButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        resetCoordinateMapViewButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    func showCarOnTheMap(_ car: Car) {
        let centerCoordinate = CLLocationCoordinate2D(latitude: car.latitude, longitude: car.longitude)
        mapView.setRegion(MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: 250, longitudinalMeters: 250), animated: true)
    }
    
    @objc private func resetMapCoordinateAction() {
        if let standartCoordinate = standartCoordinate {
            mapView.setRegion(MKCoordinateRegion(center: standartCoordinate, latitudinalMeters: 10000, longitudinalMeters: 10000), animated: true)
        }
    }
}

extension MainViewController: PresenterDelegate {
    func gotCarsFromServer(cars: [Car]) {
        for car in cars {
            let car = car
            let coordinate = CLLocationCoordinate2D(latitude: car.latitude, longitude: car.longitude)
            let carAnnotation = CarAnnotation(car: car, coordinate: coordinate)
            print(coordinate)
            mapView.addAnnotation(carAnnotation)
        }
        
        let centerCoordinate = CLLocationCoordinate2D(latitude: cars.first?.latitude ?? 48.134557, longitude: cars.first?.longitude ?? 11.576921)
        mapView.setRegion(MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: 10000, longitudinalMeters: 10000), animated: true)
        self.standartCoordinate = centerCoordinate
        carsTableView.reloadData()
        loaderView.stopAnimating()
        loaderView.isHidden = true
    }
    
    func gettingCarsFromServerFailed() {
        let alert = UIAlertController(title: "Error", message: "Can't get cars data", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { _ in
            print("pressed ok")
        }))
        alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { [weak self] _ in
            self?.presenter.downloadCars()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let carAnnotation = view.annotation as? CarAnnotation else { return }
        self.openCarDetails?(carAnnotation.car)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getCars().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarsTableViewCell", for: indexPath) as! CarsTableViewCell
        cell.setupWithData(presenter.getCars()[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openCarDetails?(presenter.getCars()[indexPath.row])
    }
    
}


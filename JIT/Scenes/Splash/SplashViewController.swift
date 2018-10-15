//
//  SplashViewController.swift
//  JIT
//
//  Created by Katerina on 16.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import UIKit
import CoreLocation

class SplashViewController: UIViewController {

    //UI
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var checkboxButton: NewUICheckbox!
    
    private let apiService = ApiService()
    private var locationManager: CLLocationManager!
    private var latitude: Double = 0.0
    private var longitude: Double = 0.0
    private var isSendLocation: Bool = false
    
    // MARK: View Controller lifecyle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        
        setupLocation()
        setupContinueButton()
        checkboxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        
        getDeviceID()
    }
    
    private func setupContinueButton() {
        
        continueButton.isEnabled = checkboxButton.isSelected
        continueButton.backgroundColor = checkboxButton.isSelected ? .primaryYellow : .gray
    }
    
    func setupLocation() {
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    private func getDeviceID() {
        
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
        UserDefaults.deviceID = deviceID
    }
    
    @objc
    func checkboxTapped() {
        
        setupContinueButton()
    }
    
    private func sendLocation() {
        
        apiService.sendLocation(longitude: String(longitude), latitude: String(latitude), time: String(Date().timeIntervalSince1970 * 1000)) { (result) in
            switch result {
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
}

// MARK: CLLocationManagerDelegate
extension SplashViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        
        if !isSendLocation {
            sendLocation()
            isSendLocation = true
        }
    }
}

// MARK: Actions
extension SplashViewController {
    
    @IBAction func showTerminalsButtonAction(_ sender: Any) {
        
        UserDefaults.isShowSplash = false
        let vc = ViewControllersFactory.getTerminals()
        ApplicationRouter.setWithTransition(vc, animation: .transitionFlipFromRight, duration: 0.5, completion: nil)
    }
    
    @IBAction func privacyPolicyButtonAction(_ sender: Any) {
        
        if let url = URL(string: Constants.URLs.privacyPolicy),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

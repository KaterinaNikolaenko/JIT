//
//  SplashViewController.swift
//  JIT
//
//  Created by Katerina on 16.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    //UI
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var checkboxButton: NewUICheckbox!
    
    // MARK: View Controller lifecyle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        
        setupContinueButton()
        checkboxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        
        getDeviceID()
        preauthorize()
    }
    
    private func setupContinueButton() {
        
        continueButton.isEnabled = checkboxButton.isSelected
        continueButton.backgroundColor = checkboxButton.isSelected ? .primaryYellow : .gray
    }
    
    private func getDeviceID() {
        
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
        UserDefaults.deviceID = deviceID
    }
    
    private func preauthorize() {
        
        let apiService = ApiService()
        apiService.preauthorize()
    }
    
    @objc
    func checkboxTapped() {
        
      setupContinueButton()
    }
}

// MARK: Actions
extension SplashViewController {
    
    @IBAction func showTerminalsButtonAction(_ sender: Any) {
        
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

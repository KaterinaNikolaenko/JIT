//
//  BaseNavigationController.swift
//  JIT
//
//  Created by Katerina on 23.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        
        super.viewDidLoad()

       setup()
    }
    
    private func setup() {
        graphicSetup()
    }
    
    private func graphicSetup() {
        
        navigationBar.tintColor = .black
        
        addShadow()
    }
    
    private func addShadow() {
        
        navigationBar.layer.shadowColor = UIColor.darkGray.cgColor
        navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        navigationBar.layer.shadowRadius = 4.0
        navigationBar.layer.shadowOpacity = 1.0
        navigationBar.layer.masksToBounds = false
    }
}

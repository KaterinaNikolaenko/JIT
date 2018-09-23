//
//  SendDataViewController.swift
//  JIT
//
//  Created by Katerina on 23.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import UIKit

class SendDataViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

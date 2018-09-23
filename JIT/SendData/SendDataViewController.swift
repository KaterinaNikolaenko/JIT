//
//  SendDataViewController.swift
//  JIT
//
//  Created by Katerina on 23.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import UIKit

class SendDataViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        setupNavigationBar()
    }
    
    private func setup() {
        
        self.view.backgroundColor = UIColor.darkWhite
        mainView.dropShadow(color: .darkGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 4, scale: true)
    }
    
    private func setupNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Some title"
    }
}

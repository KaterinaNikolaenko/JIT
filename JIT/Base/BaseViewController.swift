//
//  BaseViewController.swift
//  JIT
//
//  Created by Katerina on 10.10.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    func showMessageBase(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.view.tintColor = UIColor.primaryYellow
        alert.addAction(UIAlertAction(title: Constants.Messages.ok, style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}

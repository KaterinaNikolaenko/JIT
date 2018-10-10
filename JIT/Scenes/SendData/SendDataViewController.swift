//
//  SendDataViewController.swift
//  JIT
//
//  Created by Katerina on 23.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import UIKit

class SendDataViewController: BaseViewController, UITextFieldDelegate {

    //UI
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var orderNumber: UnderlinedFieldView!
    
    var terminal: Terminal?
    
    // MARK: View Controller lifecyle
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
        
        setupUI()
    }
    
    private func setupNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = terminal?.name ?? ""
    }
    
    private func setupUI() {
        
        address.text = terminal?.address ?? ""
        orderNumber.textField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: Actions
extension SendDataViewController {
    
    @IBAction func sendButtonAction(_ sender: Any) {
        
        if orderNumber.textField.text == "" {
            showMessageBase(title: "", message: Constants.Messages.no_order)
        }
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
    }
}

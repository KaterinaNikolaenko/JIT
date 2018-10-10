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
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    var terminal: Terminal?
    private var selectedDate: Date = Date()
    
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
        setupDatePicker()
        setupTimePicker()
    }
    
    private func setupNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = terminal?.name ?? ""
    }
    
    private func setupUI() {
        
        address.text = terminal?.address ?? ""
        orderNumber.textField.delegate = self
    }
    
    private func setupDatePicker() {
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        dateTextField.inputView = datePicker
        
        dateTextField.text = Date().createStringWithFormat(Constants.DateFormats.general)
    }
    
    private func setupTimePicker() {
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.time
        datePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: .valueChanged)
        timeTextField.inputView = datePicker
        
        timeTextField.text = Date().createStringWithFormat(Constants.DateFormats.graphsTimeLabel)
    }
    
    @objc
    func datePickerValueChanged(sender: UIDatePicker) {
        
        dateTextField.text = sender.date.createStringWithFormat(Constants.DateFormats.general)
        selectedDate = sender.date
    }
    
    @objc
    func timePickerValueChanged(sender: UIDatePicker) {

        timeTextField.text = sender.date.createStringWithFormat(Constants.DateFormats.graphsTimeLabel)
        selectedDate = sender.date
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
            return
        }
        
        if selectedDate <= Date() {
            showMessageBase(title: "", message: Constants.Messages.no_correct_data)
            return
        }
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
    }
}

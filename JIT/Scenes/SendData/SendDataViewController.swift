//
//  SendDataViewController.swift
//  JIT
//
//  Created by Katerina on 23.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import UIKit
import CoreLocation

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
    var locationManager: CLLocationManager!
    
    private let apiService = ApiService()
    private var selectedDate: Date = Date()
    private var selectedTime: Date = Date()
    private var latitude: Double = 0.0
    private var longitude: Double = 0.0
    private var orderNumberString: String = ""
    
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
        
        if UserDefaults.order == nil || UserDefaults.order == "" {
            setupUI()
        } else {
            setupUIAfterSendData() 
        }
        setupDatePicker()
        setupTimePicker()
        setupLocation()
    }
    
    private func setupNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        if UserDefaults.terminalTitle == nil || UserDefaults.terminalTitle == "" {
            self.title = terminal?.name ?? ""
        } else {
            self.title = UserDefaults.terminalTitle
        }
    }
    
    private func setupUI() {
        
        address.text = terminal?.address ?? ""
        orderNumber.textField.delegate = self
        
        sendButton.isUserInteractionEnabled = true
        confirmButton.isUserInteractionEnabled = false
        sendButton.backgroundColor = UIColor.primaryYellow
        confirmButton.backgroundColor = UIColor.lightGray
        
        orderNumber.isUserInteractionEnabled = true
        dateTextField.isUserInteractionEnabled = true
        timeTextField.isUserInteractionEnabled = true
        
        dateTextField.textColor = UIColor.black
        timeTextField.textColor = UIColor.black
        orderNumber.textColor = UIColor.black
        
        dateTextField.text = Date().createStringWithFormat(Constants.DateFormats.general)
        timeTextField.text = Date().createStringWithFormat(Constants.DateFormats.graphsTimeLabel)
        selectedDate = Date()
        selectedTime = Date()
        
        UserDefaults.terminalTitle = terminal?.name ?? ""
    }
    
    private func setupUIAfterSendData() {
        
        orderNumber.textField.text = UserDefaults.order
        
        selectedDate = UserDefaults.selectedDate ?? Date()
        selectedTime = UserDefaults.selectedTime ?? Date()
        dateTextField.text = selectedDate.createStringWithFormat(Constants.DateFormats.general)
        timeTextField.text = selectedTime.createStringWithFormat(Constants.DateFormats.graphsTimeLabel)
        
        sendButton.isUserInteractionEnabled = false
        confirmButton.isUserInteractionEnabled = true
        sendButton.backgroundColor = UIColor.lightGray
        confirmButton.backgroundColor = UIColor.primaryYellow
        
        orderNumber.isUserInteractionEnabled = false
        dateTextField.isUserInteractionEnabled = false
        timeTextField.isUserInteractionEnabled = false
        
        dateTextField.textColor = UIColor.lightGray
        timeTextField.textColor = UIColor.lightGray
        orderNumber.textColor = UIColor.lightGray
        
        addBackButton()
    }
    
    func addBackButton() {
        
        let backButton = UIButton(type: .custom)
        backButton.setTitle("", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc
    func backAction(_ sender: Any) {}
    
    private func setupDatePicker() {
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        dateTextField.inputView = datePicker
    }
    
    private func setupLocation() {
        
        locationManager = CLLocationManager()

        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    private func setupTimePicker() {
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.time
        datePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: .valueChanged)
        timeTextField.inputView = datePicker
    }
    
    @objc
    func datePickerValueChanged(sender: UIDatePicker) {
        
        dateTextField.text = sender.date.createStringWithFormat(Constants.DateFormats.general)
        selectedDate = sender.date
    }
    
    @objc
    func timePickerValueChanged(sender: UIDatePicker) {

        timeTextField.text = sender.date.createStringWithFormat(Constants.DateFormats.graphsTimeLabel)
        selectedTime = sender.date
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
}

// MARK: Network
extension SendDataViewController {
    
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
    
    private func sendOrder()  {
        
        apiService.sendTripData(order: gatherData()) { [weak self] (result) in
            switch result {
            case .success(_):
                UserDefaults.order = self?.orderNumberString
                UserDefaults.selectedDate = self?.selectedDate
                UserDefaults.selectedTime = self?.selectedTime
                
                self?.setupUIAfterSendData()
                break
            case .failure(let error):
                self?.showMessage(error)
                break
            }
        }
    }
    
    private func finishTrip() {
        
        let orderDate = Date.combineDate(date: selectedDate, withTime: selectedTime)
        let orderDateInt: Int = Int(orderDate?.timeIntervalSince1970 ?? 0) * 1000
            
        apiService.finishTrip(idOrder: UserDefaults.order ?? "", longitude: String(longitude), latitude: String(latitude), date_time: orderDateInt) { [weak self] (result) in
            switch result {
            case .success(_):
                UserDefaults.order = ""
                UserDefaults.selectedDate = nil
                UserDefaults.selectedTime = nil
                self?.navigationController?.popViewController(animated: true)
                break
            case .failure(let error):
                self?.showMessage(error)
                break
            }
        }
    }
    
    private func gatherData() -> Order {
        
        let currentOrder = Order()
        currentOrder.id = terminal?.id ?? 0
        currentOrder.latitude = latitude
        currentOrder.longitude = longitude
        
        let orderDate = Date.combineDate(date: selectedDate, withTime: selectedTime)
        currentOrder.date_time = Int(orderDate!.timeIntervalSince1970) * 1000
        currentOrder.order_number = orderNumber.textField.text ?? ""
        orderNumberString = orderNumber.textField.text ?? ""
        
        return currentOrder
    }
}

// MARK: CLLocationManagerDelegate
extension SendDataViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
}

// MARK: Actions
extension SendDataViewController {
    
    @IBAction func sendButtonAction(_ sender: Any) {
        
        if orderNumber.textField.text == "" {
            showMessageBase(title: "", message: Constants.Messages.no_order)
            return
        }
        
        if let orderDate = Date.combineDate(date: selectedDate, withTime: selectedTime) {
            if orderDate < Date() {
                showMessageBase(title: "", message: Constants.Messages.no_correct_data)
                return
            }
        } else {
            return
        }
        sendOrder()
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        
        finishTrip()
    }
}

// MARK: Private
extension SendDataViewController {
    
    private func showMessage(_ error: ApiError) {
        
        let errorMessage = error.code == .noInternet ? Constants.Messages.no_internet : error.message
        let alert = UIAlertController(title: Constants.Messages.error, message: errorMessage, preferredStyle: .alert)
        
        alert.view.tintColor = UIColor.primaryYellow
        alert.addAction(UIAlertAction(title: Constants.Messages.ok, style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}

//
//  TerminalsViewController.swift
//  JIT
//
//  Created by Katerina on 16.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import UIKit
//import CoreLocation

class TerminalsViewController: UIViewController {

    //UI
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var terminals = [Terminal]()
    private var refreshControl: UIRefreshControl!
    private let apiService = ApiService()
    
    // MARK: View Controller lifecyle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setupNavigationBar()
    }
    
    private func setup() {
        
        let authorizationToken = UIDevice.current.identifierForVendor?.uuidString //"WkEQcX2Gkkle4JOTMcOkAsT1y-Uw9FUK99MOasRiSoDucTnSYF"
        UserDefaults.token = authorizationToken
        //        getTerminals()
        preauthorize()
        setupRefreshControl()
        
        collectionView.backgroundColor = .clear
        
        let itemSize = UIScreen.main.bounds.width/2 - 20
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 15
        
        collectionView.collectionViewLayout = layout
    }
    
    private func setupRefreshControl() {
        
        self.refreshControl = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refreshControl.tintColor = UIColor.gray
        self.refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.collectionView!.addSubview(refreshControl)
    }
    
    @objc
    func loadData() {
        
        getTerminals()
    }
    
    private func setupNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetails" {
            let viewController = segue.destination as! SendDataViewController
            viewController.terminal = sender as? Terminal
        }
    }
}

// MARK: Network
extension TerminalsViewController {
    
    private func preauthorize() {
        
        apiService.preauthorize { [unowned self] (result) in
            switch result {
            case .success(_):
                self.getTerminals()
                return
            case .failure(let error):
                return
            }
        }
    }
    
    private func getTerminals() {
        
        refreshControl.beginRefreshing()
        apiService.getTerminals({ [unowned self] (result) in
            switch result {
            case .success(let json):
                if let terminalsJson = json?["terminals"] as? [[String : Any]] {
                    self.terminals = Terminal.parseModelArray(terminalsJson)
                }
                self.collectionView.reloadData()
                
                self.refreshControl.endRefreshing()
//                 self.sendLocation()
            case .failure(let error):
                
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                }
                self.delay(0.5, closure: {
                    self.showMessage(error)
                })
                
                self.terminals = []
                self.collectionView.reloadData()
            }
        })
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension TerminalsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return terminals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TerminalCollectionViewCell
        cell.backgroundColor = .white
        cell.config(terminals[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: Constants.Segues.showDetails, sender: terminals[indexPath.row])
    }
}

// MARK: Private
extension TerminalsViewController {
    
    private func delay(_ delay:Double, closure:@escaping ()->()) {
        
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    private func showMessage(_ error: ApiError) {
        
        let errorMessage = error.code == .noInternet ? Constants.Messages.no_internet : error.message
        let alert = UIAlertController(title: Constants.Messages.error, message: errorMessage, preferredStyle: .alert)
        
        alert.view.tintColor = UIColor.primaryYellow
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}

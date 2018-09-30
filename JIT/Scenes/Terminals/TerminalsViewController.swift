//
//  TerminalsViewController.swift
//  JIT
//
//  Created by Katerina on 16.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import UIKit

class TerminalsViewController: UIViewController {

    //UI
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: View Controller lifecyle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setupNavigationBar()
    }
    
    private func setup() {
        
        collectionView.backgroundColor = .clear
        
        let itemSize = UIScreen.main.bounds.width/2 - 20
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 15
        
        collectionView.collectionViewLayout = layout
    }
    
    private func setupNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension TerminalsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TerminalCollectionViewCell
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: Constants.Segues.showDetails, sender: nil)
    }
}

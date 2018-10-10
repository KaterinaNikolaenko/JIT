//
//  TerminalCollectionViewCell.swift
//  JIT
//
//  Created by Katerina on 23.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import UIKit

class TerminalCollectionViewCell: UICollectionViewCell {
    
    //UI
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var address: UILabel!
        
    func config(_ terminal: Terminal) {
        
        nameLabel.text = terminal.name
        address.text = terminal.address
    }
}

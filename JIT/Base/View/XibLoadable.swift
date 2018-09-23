//
//  XibLoadable.swift
//  JIT
//
//  Created by Katerina on 23.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import Foundation
import UIKit

protocol XibLoadable: class {
    
    var contentView: UIView? {get set}
    func setupXib(_ frame: CGRect)
}

extension XibLoadable where Self: UIView {
    
    func setupXib(_ frame: CGRect = CGRect(x: 0,y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)) {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        contentView?.frame = frame
        if let contentView = contentView {
            addSubview(contentView)
        }
    }
}


//
//  UnderlinedFieldView.swift
//  JIT
//
//  Created by Katerina on 23.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

final class UnderlinedFieldView: UIView, XibLoadable {
    
    @IBOutlet weak var textField: NewUITextField!
    @IBOutlet weak var underlineView: UIView!
    
    var contentView: UIView?
    
    
    var underlineColor: UIColor = .gray {
        didSet {
            underlineView.backgroundColor = underlineColor
        }
    }
    
    var placeholderColor: UIColor = .black {
        didSet {
            textField.placeholderColor = placeholderColor
            textField.floatingLabelTextColor = placeholderColor
            textField.floatingLabelActiveTextColor = placeholderColor
        }
    }
    
    var textColor: UIColor = .darkText {
        didSet {
            textField.textColor = textColor
        }
    }
    
    var underlineActiveColor: UIColor = .lightGray {
        didSet {
            textField.tintColor = underlineActiveColor
        }
    }
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupXib(bounds)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setupXib(bounds)
        setup()
    }
    
    private func setup() {
        
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        underlineView.backgroundColor = underlineColor
        textField.textColor = textColor
        textField.tintColor = underlineActiveColor
    }
}

extension UnderlinedFieldView {
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        
        editing()
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        
        notEditing()
    }
}

extension UnderlinedFieldView {
    
    private func editing() {
        
        underlineView.backgroundColor = underlineActiveColor
    }
    
    private func notEditing() {
        
        underlineView.backgroundColor = underlineColor
    }
}


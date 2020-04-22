//
//  InseTextField.swift
//  breakpoint
//
//  Created by Chris Mercer on 22/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import UIKit


class InsetTextField: UITextField {

    private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
    override func awakeFromNib() {
        setupView()
        super.awakeFromNib()
    }
    
    private func setupView() {
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        self.attributedPlaceholder = placeholder
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

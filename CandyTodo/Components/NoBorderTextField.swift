//
//  NoBorderTextField.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 06. 25..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

@IBDesignable
class NoBorderTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return bounds.inset(by: insets)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return bounds.inset(by: insets)
    }

}

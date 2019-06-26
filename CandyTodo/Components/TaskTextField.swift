//
//  TaskTextField.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 30..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

class TaskTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init 2")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textColor = kBASEBLUE_COLOR
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let insets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let insets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        return bounds.inset(by: insets)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let insets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        return bounds.inset(by: insets)
    }
}

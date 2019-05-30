//
//  EnterTextField.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 30..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

class EnterTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return self.bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return self.bounds.inset(by: insets)
    }
}

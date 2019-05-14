//
//  TitleLabel.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 14..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

@IBDesignable
class TitleLabel: UILabel {
    @IBInspectable
    var kern: Int = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func drawText(in rect: CGRect) {
        let text = self.text ?? ""
        let attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.kern : kern])
        self.attributedText = attributedText
        super.drawText(in: rect)
    }
}

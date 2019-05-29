//
//  HeaderView.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 29..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.1
        self.layer.shadowColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}

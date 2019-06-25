//
//  AddButton.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 29..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

class MiddleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let newBounds = self.bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 12, right: 10))
        return newBounds.contains(point)
    }
}

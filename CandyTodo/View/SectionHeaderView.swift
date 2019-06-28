//
//  SectionHeaderView.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 06. 28..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

class SectionHeaderView: UIView {
    
    //MARK: - vars
    var headerLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Avenir-Book", size: 14)
        lbl.textColor = kBASEBLUE_COLOR.withAlphaComponent(0.5)
        return lbl
    }()
    
    var date: Date? {
        didSet {
            guard let date = date else {return}
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .gregorian)
            formatter.dateStyle = .full
            if Calendar(identifier: .gregorian).isDateInToday(date) {
                headerLabel.text = "Today"
            } else if Calendar(identifier: .gregorian).isDateInTomorrow(date) {
                headerLabel.text = "Tomorrow"
            } else if Calendar(identifier: .gregorian).isDateInYesterday(date) {
                headerLabel.text = "Yesterday"
            } else {
                headerLabel.text = formatter.string(from: date)
            }
        }
    }
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 32).isActive = true
        headerLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  TaskCell.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 06. 27..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    //MARK: - var
    var title: String? {
        didSet {
            configure()
        }
    }
    
    //MARK: - vars
    var checkImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "info")
        return iv
    }()
    var titleLabel: UILabel! = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Book", size: 14)
        lbl.textColor = kBASEBLUE_COLOR
        lbl.text = "text"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - helpers
    func setupViewComponents() {
        addSubview(checkImageView)
        checkImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 32).isActive = true
        checkImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        checkImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: checkImageView.rightAnchor, constant: 24).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
    }
    
    func configure() {
        guard let title = title else {return}
        titleLabel.text = title
    }
}

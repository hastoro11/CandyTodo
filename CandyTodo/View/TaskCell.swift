//
//  TaskCell.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 06. 27..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    //MARK: - var
    var task: Task? {
        didSet {
            configure()
        }
    }
    
    //MARK: - vars
    var checkImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "checked")
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
    var priorityLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "●"
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
        addSubview(priorityLabel)
        titleLabel.leftAnchor.constraint(equalTo: checkImageView.rightAnchor, constant: 24).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: priorityLabel.leftAnchor, constant: 24).isActive = true
        addSubview(priorityLabel)

        priorityLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        priorityLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        priorityLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func configure() {
        guard let task = task else {return}
        titleLabel.text = task.title
        checkImageView.image = task.completed ? UIImage(named: "checked") : UIImage(named: "unchecked")
        switch task.priority {
        case "Low":
            priorityLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case "Medium":
            priorityLabel.textColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
        case "High":
            priorityLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        default:
            break
        }
    }
}

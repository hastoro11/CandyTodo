//
//  NewTaskVC.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 30..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    
    //MARK: - vars
    var addButton: MiddleButton = {
        let btn = MiddleButton()
        btn.setImage(UIImage(named: "check"), for: .normal)
        btn.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return btn
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.addSubview(addButton)
    }
    
    //MARK: - Actions
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addButton.frame = CGRect(x: (view.bounds.width - 80) / 2, y: view.bounds.height - 40 - 72, width: 80, height: 72)
    }
    
    @objc func addButtonTapped() {
        print("tapped")
    }
}

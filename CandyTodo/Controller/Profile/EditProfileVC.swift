//
//  NewTaskVC.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 30..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit
import SDWebImage

class EditProfileVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton! {
        didSet {
            addPhotoButton.layer.borderWidth = 3
            addPhotoButton.layer.borderColor = kBASEBLUE_COLOR.cgColor
            addPhotoButton.layer.cornerRadius = 90
            addPhotoButton.layer.masksToBounds = true
        }
    }
    
    //MARK: - vars
    var addButton: MiddleButton = {
        let btn = MiddleButton()
        btn.setImage(UIImage(named: "check"), for: .normal)
        btn.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return btn
    }()
    var user: User?

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addButton.frame = CGRect(x: (view.bounds.width - 80) / 2, y: view.bounds.height - 40 - 72, width: 80, height: 72)
    }
    
    func configure() {
        view.addSubview(addButton)
        nameTextField.text = user?.username
        emailTextField.text = user?.email
        guard let profileImageURL = user?.profileImageURL else {return}
        addPhotoButton.sd_setBackgroundImage(with: URL(string: profileImageURL), for: .normal, placeholderImage: UIImage(named: "add_photo"), options: [SDWebImageOptions.continueInBackground, .progressiveLoad], context: nil)
    }
    
    //MARK: - Actions
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addButtonTapped() {
        print("tapped")
    }
}

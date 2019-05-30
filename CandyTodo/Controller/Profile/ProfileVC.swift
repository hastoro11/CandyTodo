//
//  ProfileVC.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 29..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
            profileImageView.layer.masksToBounds = true
        }
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()     
    }
    
    //MARK: - Actions
    @IBAction func editButtonTapped() {
        if let editProfileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC {
            self.present(editProfileVC, animated: true, completion: nil)
        }
    }
}

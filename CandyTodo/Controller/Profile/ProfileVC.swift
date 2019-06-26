//
//  ProfileVC.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 29..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
            profileImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var usernameLabel: UILabel! {
        didSet {
            usernameLabel.text = ""
        }
    }
    @IBOutlet weak var emailLabel: UILabel! {
        didSet {
            emailLabel.text = ""
        }
    }
    
    //MARK: - vars
    var user: User? {
        didSet {
            configure()
        }
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
    }
    
    //MARK: - Actions
    @IBAction func editButtonTapped() {
        if let editProfileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC {
            self.present(editProfileVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func menuButtonTapped() {
        NotificationCenter.default.post(name: Notification.Name(kMENU_BUTTON_TAPPED), object: nil)
    }
    
    //MARK: - helpers
    func configure() {
        usernameLabel.text = user?.username
        emailLabel.text = user?.email
    }
    
    func fetchUser() {
        Firestore.getCurrentUser {[unowned self] (user, error) in
            if let error = error {
                print("Error fetching user:", error)
                return
            }
            self.user = user
        }
    }
}

//
//  MenuController.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 06. 26..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class MenuController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var usernameLabel: UILabel! {
        didSet {
            usernameLabel.text = ""
        }
    }
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
            profileImageView.layer.masksToBounds = true
            profileImageView.layer.borderWidth = 1
            profileImageView.layer.borderColor = kBASEBLUE_COLOR.cgColor
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - helpers
    func configure() {
        usernameLabel.text = user?.username
        guard let profileImageURL = user?.profileImageURL else {return}
        profileImageView.sd_setImage(with: URL(string: profileImageURL), placeholderImage: UIImage(named: "avatar"), options: [SDWebImageOptions.continueInBackground, .progressiveLoad], context: nil)

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

    //MARK: - Actions
    @IBAction func buttonTapped(_ sender: UIButton) {
        let tag = sender.tag
        if tag == 5 {
            do {
                try Auth.auth().signOut()
                if let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                    view.window?.rootViewController = UINavigationController(rootViewController: loginViewController)
                }
            } catch {
                print("Error signing out:", error.localizedDescription)
            }
            
        } else {
            dismiss(animated: true) {
                NotificationCenter.default.post(name: NSNotification.Name(kMENU_ITEM_BUTTON_TAPPED), object: tag)
            }
        }
        
    }

}

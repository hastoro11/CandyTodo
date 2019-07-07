//
//  LoginViewController.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 14..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    //MARK: - outlets
    @IBOutlet weak var forgotButton: UIButton! {
        didSet {
            let attributedTitle = NSAttributedString(string: "Forgot?", attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            forgotButton.setAttributedTitle(attributedTitle, for: .normal)
            forgotButton.contentHorizontalAlignment = .right
        }
    }
    @IBOutlet weak var registerButton: UIButton! {
        didSet {
            let attributedTitle = NSAttributedString(string: "New User? Register Here", attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor: kBASEBLUE_COLOR])
            registerButton.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    @IBAction func loginButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {return}
        guard let password = passwordTextField.text, !password.isEmpty else {return}
        Firestore.login(with: email, password: password) {[unowned self] (success, error) in
            if let error = error {                
                error.alert(with: self)
                return
            }
            if success {
                self.view.window?.rootViewController = MainViewController()
            }
        }
    }
}

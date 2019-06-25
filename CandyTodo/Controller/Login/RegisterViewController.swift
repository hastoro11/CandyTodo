//
//  RegisterViewController.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 14..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            let attributedTitle = NSAttributedString(string: "Have an Account? Log In", attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor: kBASEBLUE_COLOR])
            loginButton.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var termsAndConditionsTextView: UITextView! {
        didSet {            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.center
            let attributes = [
                NSAttributedString.Key.foregroundColor: kBASEBLUE_COLOR,
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: UIFont(name: "Avenir", size: 12)
            ]
            let attributedText = NSMutableAttributedString(string: "By registering, you automatically accept the Terms & Policies of candy app.", attributes: attributes as [NSAttributedString.Key : Any])
            
            let linkRange = (attributedText.string as NSString).range(of: "Terms & Policies")
            
            attributedText.addAttributes([
                NSAttributedString.Key.link : "http://index.hu"
                ], range: linkRange)
            
            termsAndConditionsTextView.linkTextAttributes = [
                NSAttributedString.Key.foregroundColor: kBASEBLUE_COLOR,
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
            ]
            termsAndConditionsTextView.attributedText = attributedText
        }
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    @IBAction func loginButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {return}
        guard let password = passwordTextField.text, !password.isEmpty else {return}
        
        Firestore.registerNewUser(email: email, password: password) {[unowned self] (success, error) in
            if let error = error {
                print("Error in registering:", error)
                return
            }
            if !success {
                print("Error in registering")
                return
            }
            
            let window = self.view.window
            window?.rootViewController = MainViewController()            
        }
    }

}

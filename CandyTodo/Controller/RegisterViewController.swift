//
//  RegisterViewController.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 14..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            let attributedTitle = NSAttributedString(string: "Have an Account? Log In", attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor: kBASEBLUE_COLOR])
            loginButton.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  LoginViewController.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 14..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - outlets
    @IBOutlet weak var forgotButton: UIButton! {
        didSet {
            let attributedTitle = NSAttributedString(string: "Forgot?", attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            forgotButton.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
    @IBOutlet weak var registerButton: UIButton! {
        didSet {
            let attributedTitle = NSAttributedString(string: "New User? Register Here", attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor: kBASEBLUE_COLOR])
            registerButton.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

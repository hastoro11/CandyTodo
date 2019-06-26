//
//  MenuController.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 06. 26..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit
import Firebase

class MenuController: UIViewController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
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

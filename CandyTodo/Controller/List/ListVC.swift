//
//  ListVC.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 29..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit
import Firebase

class ListVC: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    
    //MARK: - Actions
    @IBAction func menuButtonTapped() {
        NotificationCenter.default.post(name: Notification.Name(kMENU_BUTTON_TAPPED), object: nil)
    }
    

}

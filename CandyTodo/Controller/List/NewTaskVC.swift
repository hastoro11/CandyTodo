//
//  NewTaskVC.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 30..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

class NewTaskVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var taskTextField: UITextField!

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}

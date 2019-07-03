//
//  CandyError.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 07. 03..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

extension Error {
    
    func alert(with controller: UIViewController) {
        
        let alertController = UIAlertController(title: "Oops ❗️", message: "\(self.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}



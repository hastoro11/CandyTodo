//
//  Firestore+Ext.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 06. 25..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit
import Firebase

extension Firestore {
    static func registerNewUser(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(false, error)
                return
            }
            let values = ["email": email, "password": password]
            Firestore.firestore().collection("users").addDocument(data: values, completion: { (error) in
                if let error = error {
                    completion(false, error)
                    return
                }
                completion(true, nil)
            })
        }
        
        
    }
}

//
//  User.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 06. 26..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import Foundation

class User {
    var email: String
    var username: String
    var profileImageURL: String
    
    init(from dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? "(no username)"
        self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""
    }
}

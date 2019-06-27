//
//  Task.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 06. 27..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import Foundation

class Task {
    var uid: String
    var completed: Bool = false
    var dueDate: Date
    var priority: String
    var title: String
    
    init(from dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.priority = dictionary["priority"] as? String ?? "Low"
        self.title = dictionary["title"] as? String ?? ""
        let time = dictionary["dueDate"] as? Double ?? 0.0
        self.dueDate = Date(timeIntervalSince1970: time)
        self.completed = dictionary["completed"] as? Bool ?? false
    }
    
    func createDictionary() -> [String: Any] {
        return [
            "uid": self.uid,
            "title": self.title,
            "priority": self.priority,
            "dueDate": self.dueDate.timeIntervalSince1970,
            "completed": self.completed
        ]
    }
}

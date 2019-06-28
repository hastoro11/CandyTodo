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
    // Register
    static func registerNewUser(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(false, error)
                return
            }
            guard let uid = result?.user.uid else {return}
            let values = ["email": email, "uid": uid]
            Firestore.firestore().collection("users").document(uid).setData(values, completion: { (error) in
                if let error = error {
                    completion(false, error)
                    return
                }
                completion(true, nil)
            })               
        }
    }
    // Login
    static func login(with email: String, password: String, completion: @escaping(Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(false, error)
                return
            }
            completion(true, nil)
        }
    }
    
    // Get user
    static func getCurrentUser(completion: @escaping (User?, Error?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {return}
        Firestore.firestore().collection("users").document(currentUser.uid).getDocument { (snapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let dictionary = snapshot?.data() else {return}
            let user = User(from: dictionary)
            completion(user, nil)
        }
    }
    
    // Save user
    static func saveUser(user: User, completion: @escaping(Bool) -> Void) {
        let userRef = Firestore.firestore().collection("users").document(user.uid)
        userRef.setData(user.createDictionary()) { (error) in
            if let error = error {
                print("Error updating user:", error)
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    // Save task
    static func saveTask(userId: String, task: Task, completion: @escaping(Bool) -> Void) {
        let taskRef = Firestore.firestore().collection("users").document(userId).collection("tasks").document()
        task.uid = taskRef.documentID
        taskRef.setData(task.createDictionary()) { (error) in
            if let error = error {
                print("Error in saving task:", error)
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    // Fetch tasks
    static func fetchTasks(userId: String, completion: @escaping([Task], Error?) -> Void) {
        let tasksRef = Firestore.firestore().collection("users").document(userId).collection("tasks")
        tasksRef.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching tasks:", error)
                completion([], error)
                return
            }
            guard let documents = snapshot?.documents else {return}
            var taskArray = documents.map({$0.data()}).map({Task(from: $0)})
            taskArray.sort(by: {$0.dueDate < $1.dueDate})
            completion(taskArray, nil)
        }
    }
}

//
//  ListVC.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 29..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "datacell"

class ListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - vars
    var tasks = [Task]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TaskCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 56
        NotificationCenter.default.addObserver(self, selector: #selector(fetchTasks), name: NSNotification.Name(kTASK_SAVED_NOTIFICATION), object: nil)
        fetchTasks()
    }

    //MARK: - Actions
    @IBAction func menuButtonTapped() {
        NotificationCenter.default.post(name: Notification.Name(kMENU_BUTTON_TAPPED), object: nil)
    }
    
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TaskCell {
            let task = tasks[indexPath.row]
            cell.task = task
            cell.configure()
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    //MARK: - helpers
    @objc func fetchTasks() {
        guard let userId = Auth.auth().currentUser?.uid else {return}
        Firestore.fetchTasks(userId: userId) {[unowned self] (tasks, error) in
            if let error = error {
                print("Error", error)
                return
            }
            self.tasks = tasks.filter({Calendar(identifier: .gregorian).isDateInToday($0.dueDate)})
            self.tableView.reloadData()
        }
    }
}

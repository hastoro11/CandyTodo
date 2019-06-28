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
        NotificationCenter.default.addObserver(self, selector: #selector(fetchTasks), name: NSNotification.Name(kTODAYS_TASK_MODIFIED_IN_SCHEDULER_NOTIFICATION), object: nil)
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
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = tasks[indexPath.row]
        let completeModifyAction = UIContextualAction(style: .normal, title: task.completed ? "✕" : "✓") {(action, view, success) in
            guard let userId = Auth.auth().currentUser?.uid else {return}
            
            task.completed = !task.completed
            Firestore.setComplete(userId: userId, task: task, completion: { (ok) in
                if !ok {
                    print("Error in setting complete")
                }
                success(true)
                tableView.reloadRows(at: [indexPath], with: .automatic)                
                NotificationCenter.default.post(name: NSNotification.Name(kTODAYS_TASK_MODIFIED_IN_SCHEDULER_NOTIFICATION), object: nil)
            })
        }
        completeModifyAction.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [completeModifyAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            guard let userId = Auth.auth().currentUser?.uid else {return}
            let task = self.tasks[indexPath.row]
            Firestore.deleteTask(userId: userId, task: task, completion: {[unowned self] (ok) in
                if !ok {
                    print("Error deleting task")
                }
                success(true)
                self.tasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                NotificationCenter.default.post(name: NSNotification.Name(kTODAYS_TASK_MODIFIED_IN_SCHEDULER_NOTIFICATION), object: nil)
            })
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    //MARK: - helpers, selectors
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

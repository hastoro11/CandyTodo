//
//  ScheduleVC.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 29..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "datacell"

class SchedulerVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - vars
    var tasks = [Task]()
    var sortedTasks = [[Task]]()
    var dates = [Date]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 56
        tableView.register(TaskCell.self, forCellReuseIdentifier: reuseIdentifier)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchTasks), name: NSNotification.Name(kTASK_SAVED_NOTIFICATION), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchTasks), name: NSNotification.Name(kTODAYS_TASK_MODIFIED_IN_SCHEDULER_NOTIFICATION), object: nil)
        fetchTasks()
    }
    
    //MARK: - Actions
    @IBAction func menuButtonTapped() {
        NotificationCenter.default.post(name: Notification.Name(kMENU_BUTTON_TAPPED), object: nil)
    }
    
    //MARK: - Selectors
    
    //MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SectionHeaderView()
        headerView.date = dates[section]
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedTasks[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TaskCell {
            cell.task = sortedTasks[indexPath.section][indexPath.row]
            cell.configure()
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = sortedTasks[indexPath.section][indexPath.row]
        let completeModifyAction = UIContextualAction(style: .normal, title: task.completed ? "✕" : "✓") { (action, view, success) in
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
        let task = sortedTasks[indexPath.section][indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            guard let userId = Auth.auth().currentUser?.uid else {return}
            
            Firestore.deleteTask(userId: userId, task: task, completion: {[unowned self] (ok) in
                if !ok {
                    print("Error deleting task")
                }
                success(true)
                self.sortedTasks[indexPath.section].remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                NotificationCenter.default.post(name: NSNotification.Name(kTODAYS_TASK_MODIFIED_IN_SCHEDULER_NOTIFICATION), object: nil)
            })
        }
        let editAction = UIContextualAction(style: .normal, title: "Edit") {[unowned self] (action, view, success) in
            guard let editTaskVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewTaskVC") as? NewTaskVC else {return}
            editTaskVC.task = task
            self.present(editTaskVC, animated: true, completion: nil)
        }
        editAction.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    //MARK: - helpers
    @objc func fetchTasks() {
        guard let userId = Auth.auth().currentUser?.uid else {return}
        Firestore.fetchTasks(userId: userId) {[unowned self] (tasks, error) in
            if let error = error {
                print("Error fetching tasks:", error)
                return
            }
            self.tasks = tasks
            var dates = [Date]()
            
            let cal = Calendar(identifier: .gregorian)
            for task in tasks {
                let day = cal.startOfDay(for: task.dueDate)
                if !dates.contains(day) {
                    dates.append(day)
                }
            }
            dates = dates.sorted(by: {$0 > $1})
            var sortedTasks = Array(repeating: [Task](), count: dates.count)
            for task in tasks {
                let day = cal.startOfDay(for: task.dueDate)
                if let index = dates.firstIndex(of: day) {
                    sortedTasks[index].append(task)
                }
            }
            self.dates = dates
            self.sortedTasks = sortedTasks
            self.tableView.reloadData()
        }
    }
}

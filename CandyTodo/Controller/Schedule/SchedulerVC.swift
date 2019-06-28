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
        let headerView = UIView()
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont(name: "Avenir-Book", size: 14)
        headerLabel.textColor = kBASEBLUE_COLOR.withAlphaComponent(0.5)
        headerView.addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        headerLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 32).isActive = true
        headerLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateStyle = .full
        let date = dates[section]
        if Calendar(identifier: .gregorian).isDateInToday(date) {
            headerLabel.text = "Today"
        } else if Calendar(identifier: .gregorian).isDateInTomorrow(date) {
            headerLabel.text = "Tomorrow"
        } else if Calendar(identifier: .gregorian).isDateInYesterday(date) {
            headerLabel.text = "Yesterday"
        } else {
            headerLabel.text = formatter.string(from: dates[section])
        }
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
    
    //MARK: - helpers
    func fetchTasks() {
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

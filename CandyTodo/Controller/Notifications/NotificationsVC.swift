//
//  NotificationsVC.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 29..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit
import UserNotifications

private let reuseIdentifier = "datacell"

class NotificationsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    var notifications = [UNNotification]()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        fetchDeliveredRequests()
    }
    
    //MARK: - Actions
    @IBAction func menuButtonTapped() {
        NotificationCenter.default.post(name: Notification.Name(kMENU_BUTTON_TAPPED), object: nil)
    }
    
    //MARK: - TableView datasource, delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notifications.count == 0 {
            return 1
        }
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? NotificationCell {
            let notification = notifications[indexPath.row]
            
            cell.title = notification.request.content.body
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath)
        cell.textLabel?.attributedText = NSAttributedString(string: "You've read all of the notifications", attributes: [NSAttributedString.Key.font : UIFont(name: "Avenir-Book", size: 14) ?? UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: kBASEBLUE_COLOR])
        return cell
    }
    
    //MARK: - helpers
    func fetchDeliveredRequests() {
        UNUserNotificationCenter.current().getDeliveredNotifications(completionHandler: {[unowned self] (notifications) in
            DispatchQueue.main.async {
                self.notifications = notifications
                self.tableView.reloadData()
            }
        })        
    }
}

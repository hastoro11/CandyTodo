//
//  MainViewController.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 29..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    var addButton: MiddleButton = {
        let btn = MiddleButton()
        btn.setImage(UIImage(named: "add"), for: .normal)
        btn.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    
    func setupTabBarController() {
        // Tabbar setup
        self.tabBar.barTintColor = kBASEPINK_COLOR
        self.tabBar.tintColor = kBASEBLUE_COLOR
        
        // List Controller
        guard let listVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as? ListVC else {return}
        listVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "list"), tag: 0)
        
        // Scheduler Controller
        guard let schedulerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SchedulerVC") as? SchedulerVC else {return}
        let schedulerTabBarItem = UITabBarItem(title: "", image: UIImage(named: "clock"), tag: 1)
        schedulerTabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        schedulerVC.tabBarItem = schedulerTabBarItem
        
        
        // Notifications controller
        guard let notifocationsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else {return}
        let notificationsTabBarItem = UITabBarItem(title: "", image: UIImage(named: "bell"), tag: 1)
        notificationsTabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        notifocationsVC.tabBarItem = notificationsTabBarItem
        
        // Profile controller
        guard let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC else {return}
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "male-user"), tag: 3)
        
        view.insertSubview(addButton, aboveSubview: tabBar)
        self.viewControllers = [listVC, schedulerVC, notifocationsVC, profileVC]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addButton.frame = CGRect(x: (view.bounds.width - 80) / 2, y: view.bounds.height - 40 - 72, width: 80, height: 72)
    }
    
    @objc func addButtonTapped() {
        guard let newTaskVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewTaskVC") as? NewTaskVC else {return}
        present(newTaskVC, animated: true, completion: nil)
    }

}

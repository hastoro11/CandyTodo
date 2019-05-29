//
//  MainViewController.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 29..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    var addButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "add"), for: .normal)
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
        schedulerVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "clock"), tag: 1)
        
        // Notifications controller
        guard let notifocationsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else {return}
        notifocationsVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "bell"), tag: 2)
        
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

}

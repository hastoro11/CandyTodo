//
//  MainViewController.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 29..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit
import SideMenu

class MainViewController: UITabBarController {
    
    //MARK: - vars
    var addButton: MiddleButton = {
        let btn = MiddleButton()
        btn.setImage(UIImage(named: "add"), for: .normal)
        btn.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return btn
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(menuButtonTapped), name: NSNotification.Name(kMENU_BUTTON_TAPPED), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(menuItemButtonTapped), name: NSNotification.Name(kMENU_ITEM_BUTTON_TAPPED), object: nil)
        configureTabBarController()
        configureSideMenu()
    }
    
    //MARK: - Configure
    func configureTabBarController() {
        // Tabbar setup
        self.tabBar.barTintColor = kBASEPINK_COLOR
        self.tabBar.tintColor = kBASEBLUE_COLOR
        
        // List Controller
        guard let listVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as? ListVC else {return}
        listVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "list"), tag: 1)
        
        // Scheduler Controller
        guard let schedulerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SchedulerVC") as? SchedulerVC else {return}
        let schedulerTabBarItem = UITabBarItem(title: "", image: UIImage(named: "clock"), tag: 2)
        schedulerTabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        schedulerVC.tabBarItem = schedulerTabBarItem
        
        
        // Notifications controller
        guard let notifocationsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else {return}
        let notificationsTabBarItem = UITabBarItem(title: "", image: UIImage(named: "bell"), tag: 3)
        notificationsTabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        notifocationsVC.tabBarItem = notificationsTabBarItem
        
        // Profile controller
        guard let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC else {return}
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "male-user"), tag: 4)
        
        view.insertSubview(addButton, aboveSubview: tabBar)
        self.viewControllers = [listVC, schedulerVC, notifocationsVC, profileVC]
    }
    
    func configureSideMenu() {
        guard let menuController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuController") as? MenuController else {return}
        SideMenuManager.default.menuLeftNavigationController = UISideMenuNavigationController(rootViewController: menuController)
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuWidth = view.frame.width - 75
        SideMenuManager.default.menuShadowRadius = 1
    }
  
    //MARK: - Helpers
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addButton.frame = CGRect(x: (view.bounds.width - 80) / 2, y: view.bounds.height - 40 - 72, width: 80, height: 72)
    }
    
    //MARK: - Selectors
    @objc func addButtonTapped() {
        guard let newTaskVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewTaskVC") as? NewTaskVC else {return}
        present(newTaskVC, animated: true, completion: nil)
    }
    
    @objc func menuButtonTapped() {
        guard let leftMenu = SideMenuManager.default.menuLeftNavigationController else {return}
        present(leftMenu, animated: true, completion: nil)
    }
    
    @objc func menuItemButtonTapped(_ sender: NSNotification) {
        guard let tag = sender.object as? Int else {return}
        if let tabBarController = view.window!.rootViewController as? UITabBarController {
            tabBarController.selectedIndex = tag - 1
        }
    }

}

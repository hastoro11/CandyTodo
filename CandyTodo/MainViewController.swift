//
//  MainViewController.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 29..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

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
        
        // 
        
        self.viewControllers = [listVC]
        self.selectedIndex = 0
    }

}

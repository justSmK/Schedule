//
//  ViewController.swift
//  Schedule
//
//  Created by justSmK on 22.01.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTabBar()
    }
    
    func setupTabBar() {
        let scheduleViewController = createNavController(vc: ScheduleViewController(),
                                                         itemName: "Schedule",
                                                         ItemImage: "calendar.badge.clock")
        let tasksViewController = createNavController(vc: TasksViewController(),
                                                      itemName: "Tasks",
                                                      ItemImage: "text.badge.checkmark")
        let contactsViewController = createNavController(vc: ContactsViewController(),
                                                         itemName: "Contacts",
                                                         ItemImage: "rectangle.stack.person.crop")
        
        viewControllers = [scheduleViewController, tasksViewController, contactsViewController]
        
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 5
        
        self.tabBar.backgroundColor = UIColor.systemBackground
    }

    func createNavController(vc: UIViewController, itemName: String, ItemImage: String) -> UINavigationController {
        
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: ItemImage), tag: 0)
        
//        let item = UITabBarItem(title: itemName, image: UIImage(systemName: ItemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
//
//        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        
        
        
        return navController
    }
}


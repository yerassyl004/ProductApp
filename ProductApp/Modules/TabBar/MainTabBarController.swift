//
//  MainTabBarController.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 03.06.2024.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .white
        let tabBarItemAppearance = UITabBarItemAppearance()
        
        tabBarItemAppearance.normal.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        tabBarItemAppearance.selected.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        
        tabBar.standardAppearance = tabBarAppearance
        
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .systemBackground
        self.tabBar.barTintColor = .systemBackground
        
        self.delegate = self
        
        let mainViewController = ProductViewController()
        let tabOneBarItem = UITabBarItem(title: "Продкты",
                                         image: UIImage(systemName: "cart"),
                                         selectedImage: UIImage(systemName: "cart.fill"))
        
        mainViewController.tabBarItem = tabOneBarItem
        
        let ordersController = CoursesViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "Курсы",
                                          image: UIImage(systemName: "lightbulb.circle"),
                                          selectedImage: UIImage(systemName: "lightbulb.circle.fill"))
        
        ordersController.tabBarItem = tabTwoBarItem2

        self.viewControllers = [
            mainViewController,
            ordersController
        ]
    }
    
    // MARK: - Actions
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        print("Selected \(viewController)")
    }
}

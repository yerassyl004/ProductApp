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
        
        let productVC = ProductViewController()
        let mainViewController = UINavigationController(rootViewController: productVC)
        let tabOneBarItem = UITabBarItem(title: "Продукты",
                                         image: UIImage(systemName: "cart"),
                                         selectedImage: UIImage(systemName: "cart.fill"))
        
        mainViewController.tabBarItem = tabOneBarItem
        
        let favoritesVC = FavoritesViewController()
        let favVC = UINavigationController(rootViewController: favoritesVC)
        let tabTwoBarItem2 = UITabBarItem(title: "Избранные",
                                          image: UIImage(systemName: "heart"),
                                          selectedImage: UIImage(systemName: "heart.fill"))
        favVC.tabBarItem = tabTwoBarItem2
        
        let coursesVC = CoursesViewController()
        let coursesController = UINavigationController(rootViewController: coursesVC)
        let tabThreeBarItem3 = UITabBarItem(title: "Курсы",
                                          image: UIImage(systemName: "lightbulb.circle"),
                                          selectedImage: UIImage(systemName: "lightbulb.circle.fill"))
        
        coursesController.tabBarItem = tabThreeBarItem3

        self.viewControllers = [
            mainViewController,
            favVC,
            coursesController
        ]
    }
    
    // MARK: - Actions
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        print("Selected \(viewController)")
    }
}

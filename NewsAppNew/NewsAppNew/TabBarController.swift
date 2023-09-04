//
//  TabBarController.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 03.09.2023.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewControllers()
        setUpTabBar()
    }
    
    //MARK: Private methods
    private func setUpTabBar() {
        let appereance = UITabBarAppearance()
        appereance.configureWithOpaqueBackground()
        tabBar.scrollEdgeAppearance = appereance
        view.tintColor = .black
    }
    private func setUpViewControllers() {
        viewControllers = [
            setUpNavigationController(rootViewController: GeneralViewController(), title: "General", image: UIImage(systemName: "newspaper") ?? UIImage.add),
            setUpNavigationController(rootViewController: BusinessViewController(), title: "Business", image: UIImage(systemName: "briefcase") ?? UIImage.add),
            setUpNavigationController(rootViewController: TechnologyViewController(), title: "Technology", image: UIImage(systemName: "briefcase") ?? UIImage.add)
        ]
    }
    private func setUpNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        navigationController.navigationItem.title = title
        navigationController.tabBarItem.image = image
        rootViewController.title = title
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}

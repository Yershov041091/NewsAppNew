//
//  AppDelegate.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 03.09.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            window.rootViewController = TabBarController()
            window.makeKeyAndVisible()
        }
        return true
    }
}


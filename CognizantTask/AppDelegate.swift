//
//  AppDelegate.swift
//  CognizantTask
//
//  Created by Barath on 20/06/20.
//  Copyright © 2020 Barath. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = ViewController()
        homeViewController.view.backgroundColor = .white
        let navigationController = UINavigationController(rootViewController: homeViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}



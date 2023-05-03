//
//  AppDelegate.swift
//  Binet
//
//  Created by Al Stark on 29.04.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = CollectionViewController()
        let navcontroller = UINavigationController(rootViewController: vc)
        CollectionAssembly.init(navigationController: navcontroller).assembly(viewController: vc)
        window?.rootViewController = navcontroller
        window?.makeKeyAndVisible()
        return true
    }
    
}


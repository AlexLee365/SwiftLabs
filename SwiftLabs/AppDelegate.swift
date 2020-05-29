//
//  AppDelegate.swift
//  SwiftLabs
//
//  Created by AlexLee_Dev on 2020/03/18.
//  Copyright © 2020 AlexLee_Dev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = injectRootViewController()
        self.window = window

        window.makeKeyAndVisible()

        return true
    }
}

private extension AppDelegate {
    private func injectRootViewController() -> UIViewController {
        var viewController: UIViewController!
//        let viewController = AppleLoginTestViewController()

        let parchmentTest = UINavigationController(rootViewController: ParchmentViewController())
        parchmentTest.navigationBar.barStyle = .black
        viewController = parchmentTest

//        viewController = PinterestViewController()

//        viewController = BasicViewController()

        return viewController
    }
}

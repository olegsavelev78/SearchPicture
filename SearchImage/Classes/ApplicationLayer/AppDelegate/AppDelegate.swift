//
//  AppDelegate.swift
//  SearchImage
//
//  Created by Олег Савельев on 13.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let coordinator = MainAppCoordinator()
        MainAppCoordinator.shared = coordinator
        coordinator.start()
        return true
    }
}

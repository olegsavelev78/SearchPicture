//
//  MainAppCoordinator.swift
//  SearchImage
//
//  Created by Олег Савельев on 14.07.2022.
//

import UIKit

final class MainAppCoordinator {
    private let appCoordinator: AppCoordinator!
    
    public static var shared: MainAppCoordinator!
    
    init() {
        appCoordinator = AppCoordinator()
    }
    
    func start() {
        MainTheme.shared.apply()
        appCoordinator.start()
    }
}

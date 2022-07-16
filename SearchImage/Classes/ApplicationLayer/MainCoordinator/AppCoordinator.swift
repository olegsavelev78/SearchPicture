//
//  AppCoordinator.swift
//  SearchImage
//
//  Created by Олег Савельев on 13.07.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var window: UIWindow!
    
    override func start() {
        let mainCoordinator = MainCoordinator(window: createWindow())
        coordinate(to: mainCoordinator)
    }
    
    private func createWindow() -> UIWindow {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window.backgroundColor = .white
        return self.window
    }
}

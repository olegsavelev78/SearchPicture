//
//  MainAssembly.swift
//  SearchImage
//
//  Created by Олег Савельев on 15.07.2022.
//

import Foundation

final class MainAssembly {
    class func createModule() -> MainViewController {
        let moduleViewController = MainViewController()
        let viewModel = MainViewModel()
        moduleViewController.viewModel = viewModel
        return moduleViewController
    }
}

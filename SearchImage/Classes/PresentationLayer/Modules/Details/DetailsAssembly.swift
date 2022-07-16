//
//  DetailsAssembly.swift
//  SearchImage
//
//  Created by Олег Савельев on 15.07.2022.
//

import UIKit

final class DetailsAssembly {
    class func createModule(pictures: [PictureModel], handleIndex: Int) -> DetailsViewController {
        let moduleViewController = DetailsViewController()
        
        let viewModel = DetailsViewModel()
        viewModel.pictures = pictures
        viewModel.output.handleIndex = handleIndex
        
        moduleViewController.viewModel = viewModel
        
        return moduleViewController
    }
}

//
//  DetailsAssembly.swift
//  SearchImage
//
//  Created by Олег Савельев on 15.07.2022.
//

import UIKit

final class DetailsAssembly {
    class func createModule(picture: PictureModel) -> DetailsViewController {
        let moduleViewController = DetailsViewController()
        
        let viewModel = DetailsViewModel()
        viewModel.picture = picture
        
        moduleViewController.viewModel = viewModel
        
        return moduleViewController
    }
}

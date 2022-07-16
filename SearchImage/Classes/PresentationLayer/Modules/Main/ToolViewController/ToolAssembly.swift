import UIKit

final class ToolAssembly {
    class func createModule(_ mainVM: MainViewModel) -> ToolViewController {
        let viewController = ToolViewController()
        let viewModel = ToolViewModel()
        viewModel.input.country = mainVM.country
        viewModel.input.language = mainVM.language
        viewModel.input.size = mainVM.size

        viewController.viewModel = viewModel
        return viewController
    }
}

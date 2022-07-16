import UIKit

final class WebAssembly {
    class func createModule(_ link: URL) -> WebViewController {
        let viewController = WebViewController()
        
        let viewModel = WebViewModel()
        viewModel.url = link
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}

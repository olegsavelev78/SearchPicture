import UIKit

class MainCoordinator: Coordinator {
    let rootViewController: UIViewController
    
    private var window: UIWindow
    private var bag = CancelBag()
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = MainViewController()
    }
    
    override func start() {
        guard let viewController = rootViewController as? MainViewController else { return }
        let viewModel = MainViewModel()
        viewController.viewModel = viewModel
        
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
        
        viewController.viewModel.output.openPicture.publisher
            .sink { [weak self] in
                self?.openPicture(id: $0)
            }
            .store(in: &bag)
    }
    
    private func openPicture(id: Int) {
        let coordinator = DetailsCoordinator(pictureID: id)
        rootViewController.navigationController?.pushViewController(coordinator.rootViewController, animated: true)
    }
}

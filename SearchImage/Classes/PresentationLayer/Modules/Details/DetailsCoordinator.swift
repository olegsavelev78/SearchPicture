import Combine
import UIKit

class DetailsCoordinator: Coordinator {
    let rootViewController: DetailsViewController
    
    private var bag = CancelBag()
    
    init(pictures: [PictureModel], handleIndex: Int) {
        self.rootViewController = DetailsAssembly.createModule(pictures: pictures,
                                                               handleIndex: handleIndex)
    }
    
    override func start() {
        rootViewController.viewModel.output.openLink.publisher
            .sink { [weak self] in
                self?.openLink($0)
            }
            .store(in: &bag)
    }
    
    private func openLink(_ url: URL) {
        let coordinator = WebCoordinator(url)
        coordinator.rootViewController.modalPresentationStyle = .formSheet
        rootViewController.present(coordinator.rootViewController, animated: true)
        coordinate(to: coordinator)
    }
}

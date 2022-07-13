import Combine
import UIKit

class DetailsCoordinator: Coordinator {
    let rootViewController: UIViewController
    
    private var bag = CancelBag()
    
    init(pictureID: Int) {
        self.rootViewController = DetailsViewController()
    }
    
    override func start() {}
}

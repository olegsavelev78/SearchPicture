import Combine
import UIKit

class DetailsCoordinator: Coordinator {
    let rootViewController: DetailsViewController
    
    private var bag = CancelBag()
    
    init(picture: PictureModel) {
        self.rootViewController = DetailsAssembly.createModule(picture: picture)
    }
    
    override func start() {}
}

import UIKit
import FittedSheets

class MainCoordinator: Coordinator {
    var rootViewController: MainViewController
    
    private var window: UIWindow
    private var bag = CancelBag()
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = MainAssembly.createModule()
    }
    
    override func start() {
        window.rootViewController = UINavigationController(rootViewController: rootViewController)
        window.makeKeyAndVisible()
        
        rootViewController.viewModel.output.openPicture.publisher
            .sink { [weak self] in
                self?.openPicture(picture: $0)
            }
            .store(in: &bag)
        
        rootViewController.viewModel.input.openTool.publisher
            .sink { [weak self] in
                self?.openTool()
            }
            .store(in: &bag)
    }
    
    private func openPicture(picture: PictureModel) {
        let coordinator = DetailsCoordinator(picture: picture)
        rootViewController.navigationController?.pushViewController(coordinator.rootViewController, animated: true)
        coordinate(to: coordinator)
    }
    
    private func openTool() {
        let coordinator = ToolCoordinator(mainVM: rootViewController.viewModel) {
            print("asdfasdfadf")
        }
        let options = SheetOptions(pullBarHeight: 0,
                                   setIntrinsicHeightOnNavigationControllers: false,
                                   shrinkPresentingViewController: false,
                                   useInlineMode: false)
        
        let initialSize: SheetSize = .fixed(500)
        let sheetController = SheetViewController(controller: coordinator.rootViewController,
                                                  sizes: [initialSize],
                                                  options: options)
        sheetController.cornerRadius = 20
        sheetController.dismissOnPull = true
        sheetController.autoAdjustToKeyboard = false
        
        rootViewController.present(sheetController, animated: true)
        coordinate(to: coordinator)
    }
}

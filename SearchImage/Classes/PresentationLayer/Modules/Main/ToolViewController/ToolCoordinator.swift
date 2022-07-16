import Foundation

class ToolCoordinator: Coordinator {
    let rootViewController: ToolViewController
    
    private var bag = CancelBag()
    
    init(mainVM: MainViewModel) {
        self.rootViewController = ToolAssembly.createModule(mainVM)

        rootViewController.viewModel.input.$country
            .sink {
                mainVM.country = $0
            }
            .store(in: &bag)
        
        rootViewController.viewModel.input.$language
            .sink {
                mainVM.language = $0
            }
            .store(in: &bag)
        
        rootViewController.viewModel.input.$size
            .sink {
                mainVM.size = $0
            }
            .store(in: &bag)
    }
    
    override func start() {
        rootViewController.viewModel.output.back.publisher
            .sink { [weak self] in
                self?.rootViewController.dismiss(animated: true)
            }
            .store(in: &bag)
    }
}

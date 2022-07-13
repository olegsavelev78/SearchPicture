import UIKit
import Combine

// MARK: - View Controller

final class DetailsViewController: UIViewController {
    
    // MARK: - UI
        
    var viewModel: DetailsViewModel!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        view.backgroundColor = .green
//        viewModel.input.didLoad.send(())
    }
    
    // MARK: - SetUp Bindings
    
    private func setupBindings() {
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    private func bindViewToViewModel() {}
    
    private func bindViewModelToView() {}
}

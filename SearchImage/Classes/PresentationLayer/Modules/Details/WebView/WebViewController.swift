import UIKit
import Combine
import WebKit

// MARK: - View Controller

final class WebViewController: UIViewController {
    
    // MARK: - UI
    private lazy var webView = WKWebView()
        
    private var bag = CancelBag()
    var viewModel: WebViewModel!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupViews()
        setupBindings()
        layoutConstraints()
        viewModel.input.didLoad.send(())
    }
    
    // MARK: - SetUp Bindings
    
    private func setupBindings() {
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    private func bindViewToViewModel() {}
    
    private func bindViewModelToView() {
        viewModel.output.load.publisher
            .sink { [weak self] in
                self?.load(url: $0)
            }
            .store(in: &bag)
    }
    
    private func load(url: URL?) {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func setupViews() {}
    
    private func addSubviews() {
        [webView].forEach {
            view.addSubview($0)
        }
    }
    
    private func layoutConstraints() {
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

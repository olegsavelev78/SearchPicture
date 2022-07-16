import UIKit
import Combine
import Kingfisher

// MARK: - View Controller

final class DetailsViewController: UIViewController {
    
    // MARK: - UI
    private lazy var imageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    private var bag = CancelBag()
    var viewModel: DetailsViewModel!
    
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
        viewModel.output.picture.publisher
            .sink { [weak self] picture in
                print(picture.thumbnail)
                guard let url = URL(string: picture.original) else { return }
                self?.imageView.kf.setImage(with: url)
            }
            .store(in: &bag)
    }
    
    private func setupViews() {

    }
    
    private func addSubviews() {
        [imageView].forEach {
            view.addSubview($0)
        }
    }
    
    private func layoutConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

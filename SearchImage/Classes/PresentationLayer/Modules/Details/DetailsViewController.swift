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
    
    private lazy var stackView = UIStackView().apply {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 20
    }
    
    private lazy var nextButton = UIButton(type: .system).apply {
        $0.setTitle("Next", for: .normal)
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(self.nextPicture), for: .touchUpInside)
    }
    
    private lazy var backButton = UIButton(type: .system).apply {
        $0.setTitle("Back", for: .normal)
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(self.backPicture), for: .touchUpInside)
    }
    
    private lazy var openLinkButton = UIButton(type: .system).apply {
        $0.setTitle("Open", for: .normal)
        $0.backgroundColor = .secondaryLabel
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(self.openLink), for: .touchUpInside)
    }
    
    private lazy var activityIndicator = UIActivityIndicatorView().apply {
        $0.style = .large
        $0.hidesWhenStopped = true
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
        viewModel.output.state = .loading
    }
    
    override func loadView() {
        super.loadView()
        view = UIView().apply {
            $0.backgroundColor = .white
        }
    }
    
    // MARK: - SetUp Bindings
    
    private func setupBindings() {
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    private func bindViewToViewModel() {}
    
    private func bindViewModelToView() {
        viewModel.output.$state
            .sink { [weak self] state in
                switch state {
                case .loading:
                    self?.activityIndicator.startAnimating()
                case .loaded:
                    self?.activityIndicator.stopAnimating()
                default: break
                }
            }
            .store(in: &bag)
        
        viewModel.output.$picture
            .sink { [weak self] picture in
                guard let url = URL(string: picture.original) else { return }
                self?.imageView.kf.setImage(with: url) { [weak self] _ in
                    self?.viewModel.output.state = .loaded
                }
            }
            .store(in: &bag)
    }
    
    @objc private func openLink() {
        viewModel.input.openLinkTapped.send(())
    }
    
    @objc private func nextPicture() {
        viewModel.input.next.send(())
    }
    
    @objc private func backPicture() {
        viewModel.input.back.send(())
    }
    
    private func setupViews() {}
    
    private func addSubviews() {
        [backButton,
         openLinkButton,
         nextButton].forEach {
            stackView.addArrangedSubview($0)
        }
        [imageView, stackView, activityIndicator].forEach {
            view.addSubview($0)
        }
    }
    
    private func layoutConstraints() {
        imageView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(30)
            $0.left.right.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(50)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

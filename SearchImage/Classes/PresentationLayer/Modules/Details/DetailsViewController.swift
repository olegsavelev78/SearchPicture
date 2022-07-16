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
//        $0.addTarget(self, action: #selector(self.openTool), for: .touchUpInside)
    }
    
    private lazy var backButton = UIButton(type: .system).apply {
        $0.setTitle("Back", for: .normal)
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        $0.setTitleColor(.white, for: .normal)
//        $0.addTarget(self, action: #selector(self.openTool), for: .touchUpInside)
    }
    
    private lazy var openLinkButton = UIButton(type: .system).apply {
        $0.setTitle("Open", for: .normal)
        $0.backgroundColor = .secondaryLabel
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(self.openLink), for: .touchUpInside)
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
        viewModel.output.picture.publisher
            .sink { [weak self] picture in
                print(picture.thumbnail)
                guard let url = URL(string: picture.thumbnail) else { return }
                self?.imageView.kf.setImage(with: url)
            }
            .store(in: &bag)
    }
    
    @objc private func openLink() {
        viewModel.input.openLinkTapped.send(())
    }
    
    private func setupViews() {}
    
    private func addSubviews() {
        [backButton,
         openLinkButton,
         nextButton].forEach {
            stackView.addArrangedSubview($0)
        }
        [imageView, stackView].forEach {
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
    }
}

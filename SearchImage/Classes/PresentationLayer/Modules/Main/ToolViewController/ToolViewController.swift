import UIKit
import Combine

// MARK: - View Controller

final class ToolViewController: UIViewController {
    
    // MARK: - UI
    private lazy var countrySegmentView = SegmentView()
    
    private lazy var languageSegmentView = SegmentView()
    
    private lazy var sizeSegmentView = SegmentView()
    
    private lazy var okButton = UIButton(type: .system).apply {
        $0.setTitle("OK", for: .normal)
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        $0.backgroundColor = .gray
        $0.addTarget(self, action: #selector(self.back), for: .touchUpInside)
    }

    var viewModel: ToolViewModel!
    private var bag = CancelBag()
    
    private let sizeFont: CGFloat = 15
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupViews()
        setupBindings()
        layoutConstraints()
    }
    
    // MARK: - SetUp Bindings
    
    private func setupBindings() {
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    private func bindViewToViewModel() {
        countrySegmentView.changeValue.publisher
            .sink { [weak self] value in
                guard let type = CountryType.init(rawValue: value) else { return }
                self?.viewModel.input.country = type
            }
            .store(in: &bag)
        
        languageSegmentView.changeValue.publisher
            .sink { [weak self] value in
                guard let type = LanguageType.init(rawValue: value) else { return }
                self?.viewModel.input.language = type
            }
            .store(in: &bag)
        
        sizeSegmentView.changeValue.publisher
            .sink { [weak self] value in
                guard let type = SizeType.init(rawValue: value) else { return }
                self?.viewModel.input.size = type
            }
            .store(in: &bag)
    }
    
    private func bindViewModelToView() {}
    
    @objc
    public func back() {
        viewModel.output.back.send(())
    }
    
    private func setupViews() {
        countrySegmentView.configure(type: .country(viewModel.input.country.rawValue))
        languageSegmentView.configure(type: .language(viewModel.input.language.rawValue))
        sizeSegmentView.configure(type: .size(viewModel.input.size.rawValue))
    }
    
    private func addSubviews() {
        [countrySegmentView,
        languageSegmentView,
        sizeSegmentView,
        okButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func layoutConstraints() {
        countrySegmentView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(countrySegmentView.layout())
        }
        
        languageSegmentView.snp.makeConstraints {
            $0.top.equalTo(countrySegmentView.snp.bottom).offset(45)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(languageSegmentView.layout())
        }
        
        sizeSegmentView.snp.makeConstraints {
            $0.top.equalTo(languageSegmentView.snp.bottom).offset(45)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(languageSegmentView.layout())
        }
        
        okButton.snp.makeConstraints {
            $0.top.equalTo(sizeSegmentView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(40)
        }
    }
}

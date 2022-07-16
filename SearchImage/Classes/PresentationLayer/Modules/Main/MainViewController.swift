import UIKit
import Combine
import SnapKit

final class MainViewController: UIViewController {
    
    // MARK: - UI
    private lazy var searchControl = UISearchController().apply {
        $0.searchBar.placeholder = "Search..."
        $0.definesPresentationContext = false
        $0.searchBar.delegate = self
    }
    
    private lazy var collectionFlowLayout = UICollectionViewFlowLayout().apply {
        let sizeItem = UIScreen.main.bounds.width / 3 - offset
        $0.itemSize = CGSize(width: sizeItem, height: sizeItem)
        $0.minimumLineSpacing = 3
        $0.minimumInteritemSpacing = 3
        $0.scrollDirection = .vertical
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout).apply {
        $0.dataSource = self
        $0.delegate = self
        $0.register(ImageCell.self, forCellWithReuseIdentifier: "picture")
        $0.backgroundColor = .clear
    }
    
    private lazy var activityIndicator = UIActivityIndicatorView().apply {
        $0.style = .large
        $0.hidesWhenStopped = true
    }
    
    private lazy var emptyLabel = UILabel().apply {
        $0.textAlignment = .center
        $0.font = UIFont.font(ofSize: 20, weight: .bold)
        $0.isHidden = true
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    private lazy var toolButton = UIButton(type: .system).apply {
        $0.setTitle("Tool", for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(self.openTool), for: .touchUpInside)
    }

    private let offset: CGFloat = 4
    private var bag = CancelBag()
    private var items: [PictureModel] = []
    
    var viewModel: MainViewModel!
    
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
    
    private func bindViewToViewModel() {}
    
    private func bindViewModelToView() {
        viewModel.output.$pictures
            .sink { [weak self] items in
                self?.emptyLabel.isHidden = true
                self?.items = items
                self?.collectionView.reloadData()
            }
            .store(in: &bag)
        
        viewModel.output.$state
            .sink { [weak self] state in
                switch state {
                case .loading:
                    self?.activityIndicator.startAnimating()
                case .loaded:
                    self?.activityIndicator.stopAnimating()
                case .error(let message):
                    self?.emptyLabel.isHidden = false
                    self?.emptyLabel.text = message
                default: break
                }
            }
            .store(in: &bag)
    }
    
    // MARK: - Private
    @objc
    public func openTool() {
        viewModel.input.openTool.send(())
    }
    
    private func loadMore() {
        viewModel.input.loadMore.send(())
    }
    
    private func setupViews() {
        title = "Search Picture"
        navigationItem.searchController = searchControl
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func addSubviews() {
        [collectionView,
         activityIndicator,
         emptyLabel,
         toolButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func layoutConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        toolButton.snp.makeConstraints {
            $0.top.equalTo(collectionView)
            $0.right.equalToSuperview().inset(10)
            $0.height.equalTo(40)
            $0.width.equalTo(70)
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "picture", for: indexPath) as? ImageCell else { fatalError() }
        cell.configure(model: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        viewModel.output.openPicture.send(item.position)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.input.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.input.searchTap.send(())
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.input.searchText = ""
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        
        if distance < 300 {
            self.loadMore()
        }
    }
}

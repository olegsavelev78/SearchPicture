import UIKit
import Combine
import SnapKit

final class MainViewController: UIViewController {
    
    // MARK: - UI
    private lazy var searchControl = UISearchController().apply {
        $0.searchBar.placeholder = "Search..."
        $0.definesPresentationContext = false
    }
    
    private lazy var collectionFlowLayout = UICollectionViewFlowLayout().apply {
        $0.scrollDirection = .vertical
        let sizeItem = UIScreen.main.bounds.width / 3 - offset
        $0.itemSize = CGSize(width: sizeItem, height: sizeItem)
        $0.minimumLineSpacing = 15
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout).apply {
        $0.dataSource = self
        $0.delegate = self
        $0.register(ImageCell.self, forCellWithReuseIdentifier: "picture")
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
    }

    private let offset: CGFloat = 8
    var viewModel: MainViewModel = MainViewModel()
    
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
    
    private func bindViewModelToView() {}
    
    // MARK: - Private
    private func setupViews() {
        title = "Search Picture"
        navigationItem.searchController = searchControl
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func layoutConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "picture", for: indexPath) as? ImageCell else { fatalError() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.output.openPicture.send(indexPath.row)
    }
}

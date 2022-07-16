import UIKit
import Combine

// MARK: - View Model

final class MainViewModel {
    private var bag = CancelBag()
    
    let input = Input()
    let output = Output()
    
    private let pictureService: PictureService!
    
    private var numberPage: Int = 0
    private var searchText: String = .init()
    var country: CountryType = .initial
    var size: SizeType = .initial
    var language: LanguageType = .initial
    
    init() {
        self.pictureService = PictureServiceImp()
        self.setUpBindings()
    }
    
    // MARK: - SetUp Bindings
    
    private func setUpBindings() {
        input.searchTap.publisher
            .sink { [weak self] _ in
                guard let text = self?.input.searchText,
                      text != "" else { return }
                self?.output.pictures = []
                self?.output.state = .loading
                self?.numberPage = 0
                self?.fetchPicture()
            }
            .store(in: &bag)
        
        input.$searchText
            .sink { [weak self] text in
                self?.searchText = text
                guard text == "" else { return }
                self?.output.pictures = []
            }
            .store(in: &bag)
        
        input.loadMore.publisher
            .sink { [weak self] in
                self?.numberPage += 1
                self?.fetchPicture()
            }
            .store(in: &bag)
        
        input.$country
            .sink { [weak self] in
                self?.country = $0
            }
            .store(in: &bag)
        
        input.$language
            .sink { [weak self] in
                self?.language = $0
            }
            .store(in: &bag)
        
        input.$size
            .sink { [weak self] in
                self?.size = $0
            }
            .store(in: &bag)
    }
    
    private func fetchPicture() {
        pictureService.fetchPicture(page: numberPage,
                                    searchLine: searchText,
                                    country: country,
                                    language: language,
                                    size: size)
            .sink { [weak self] completion in
                self?.output.state = .loaded
                if case let .failure(error) = completion {
                    self?.output.state = .error(message: error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] pictureData in
                guard let self = self else { return }
                self.output.state = .loaded
                switch self.numberPage {
                case 0:
                    self.output.pictures = pictureData.imagesResults
                case 1...:
                    self.output.pictures += pictureData.imagesResults
                default: break
                }
            }
            .store(in: &bag)
    }
}

extension MainViewModel {
    class Input {
        @PublishedProperty var country: CountryType = .initial
        @PublishedProperty var language: LanguageType = .initial
        @PublishedProperty var size: SizeType = .initial
        @PublishedProperty var searchText: String = .init()
        var searchTap = PublishedAction<Void>()
        var loadMore = PublishedAction<Void>()
        var openTool = PublishedAction<Void>()
    }
    
    class Output {
        @PublishedProperty var pictures: [PictureModel] = []
        @PublishedProperty var state: ViewState = .initial
        var openPicture = PublishedAction<Int>()
    }
}

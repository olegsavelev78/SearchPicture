import UIKit
import Combine

// MARK: - View Model

final class MainViewModel {
    private var bag = CancelBag()
    
    let input = Input()
    let output = Output()
    
    let pictureService: PictureService1!
        
    init() {
        self.pictureService = PictureServiceImp()
        self.setUpBindings()
    }
    
    // MARK: - SetUp Bindings
    
    private func setUpBindings() {        
        input.didLoad.publisher
            .sink { [weak self] _  in
                print("Did Load")
                self?.fetchPicture()
            }
            .store(in: &bag)
    }
    
    private func fetchPicture() {
        pictureService.fetchPicture(page: 1, searchLine: "apple")
            .sink { [weak self] completion in
                guard case let .failure(error) = completion else { return }

                 print(error)
            } receiveValue: { response in
                print(response.description)
            }
            .store(in: &bag)
    }
}

extension MainViewModel {
    class Input {
        var didLoad = PublishedAction<Void>()
    }
    
    class Output {
        var openPicture = PublishedAction<Int>()
    }
}

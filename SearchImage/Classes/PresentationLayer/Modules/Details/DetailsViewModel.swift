import UIKit
import Combine

// MARK: - View Model

final class DetailsViewModel {
    private var bag = CancelBag()
    
    let input = Input()
    let output = Output()
    
    var picture: PictureModel?
        
    init() {
        self.setUpBindings()
    }
    
    // MARK: - SetUp Bindings
    
    private func setUpBindings() {        
        input.didLoad.publisher
            .sink { [weak self] _  in
                guard let picture = self?.picture else { return }
                self?.output.picture.send(picture)
            }
            .store(in: &bag)
    }
}

extension DetailsViewModel {
    class Input {
        var didLoad = PublishedAction<Void>()
    }
    
    class Output {
        var picture = PublishedAction<PictureModel>()
    }
}

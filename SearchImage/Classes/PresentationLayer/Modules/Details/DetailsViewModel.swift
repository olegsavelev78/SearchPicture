import UIKit
import Combine

// MARK: - View Model

final class DetailsViewModel {
//    private var bag = CancelBag()
    
    let input = Input()
    let output = Output()
        
    init() {
        self.setUpBindings()
    }
    
    // MARK: - SetUp Bindings
    
    private func setUpBindings() {        
//        input.didLoad.publisher
//            .sink { [weak self] _  in
//                self?.log(.debug, "Did load")
//            }
//            .store(in: &bag)
    }
}

extension DetailsViewModel {
    class Input {
//        var didLoad = PublishedAction<Void>()
    }
    
    class Output {
    }
}

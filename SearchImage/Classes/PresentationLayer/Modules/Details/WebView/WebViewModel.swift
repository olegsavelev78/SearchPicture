import UIKit
import Combine

// MARK: - View Model

final class WebViewModel {
    private var bag = CancelBag()
    
    let input = Input()
    let output = Output()
    
    var url: URL?
        
    init() {
        self.setUpBindings()
    }
    
    // MARK: - SetUp Bindings
    
    private func setUpBindings() {        
        input.didLoad.publisher
            .sink { [weak self] _ in
                self?.output.load.send(self?.url)
            }
            .store(in: &bag)
    }
}

extension WebViewModel {
    class Input {
        var didLoad = PublishedAction<Void>()
    }
    
    class Output {
        var load = PublishedAction<URL?>()
    }
}

import UIKit
import Combine

// MARK: - View Model

final class ToolViewModel {
    private var bag = CancelBag()
    
    let input = Input()
    let output = Output()
        
    init() {
        self.setUpBindings()
    }
    
    // MARK: - SetUp Bindings
    
    private func setUpBindings() {}
}

extension ToolViewModel {
    class Input {
        @PublishedProperty var country: CountryType = .initial
        @PublishedProperty var language: LanguageType = .initial
        @PublishedProperty var size: SizeType = .initial
    }
    
    class Output {
        var back = PublishedAction<Void>()
    }
}

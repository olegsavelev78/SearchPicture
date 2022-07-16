import UIKit
import Combine

// MARK: - View Model

final class DetailsViewModel {
    private var bag = CancelBag()
    
    let input = Input()
    let output = Output()
    
    var pictures: [PictureModel] = []
        
    init() {
        self.setUpBindings()
    }
    
    // MARK: - SetUp Bindings
    
    private func setUpBindings() {        
        input.didLoad.publisher
            .sink { [weak self] _ in
                guard let picture = self?.pictures.first(where: { item in
                    item.position == self?.output.handleIndex
                }) else { return }
                self?.output.picture = picture
            }
            .store(in: &bag)
        
        input.openLinkTapped.publisher
            .sink { [weak self] _ in
                guard let urlString = self?.output.picture.link,
                      let url = URL(string: urlString) else { return }
                self?.output.openLink.send(url)
            }
            .store(in: &bag)
        
        output.$handleIndex
            .sink { [weak self] index in
                guard let picture = self?.pictures.first(where: { item in
                    item.position == index
                }) else { return }
                self?.output.picture = picture
            }
            .store(in: &bag)
        
        input.next.publisher
            .sink { [weak self] _ in
                guard let self = self,
                      self.output.handleIndex < self.pictures.count else { return }
                self.output.state = .loading
                self.output.handleIndex += 1
            }
            .store(in: &bag)
        
        input.back.publisher
            .sink { [weak self] _ in
                guard let self = self,
                      self.output.handleIndex > 0 else { return }
                self.output.state = .loading
                self.output.handleIndex -= 1
            }
            .store(in: &bag)
    }
}

extension DetailsViewModel {
    class Input {
        var didLoad = PublishedAction<Void>()
        var openLinkTapped = PublishedAction<Void>()
        var next = PublishedAction<Void>()
        var back = PublishedAction<Void>()
    }
    
    class Output {
        @PublishedProperty var picture: PictureModel = .init()
        var openLink = PublishedAction<URL>()
        @PublishedProperty var state: ViewState = .initial
        @PublishedProperty var handleIndex: Int = 0
    }
}

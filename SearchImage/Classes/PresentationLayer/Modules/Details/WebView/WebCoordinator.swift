import Foundation

class WebCoordinator: Coordinator {
    let rootViewController: WebViewController
    
    init(_ link: URL) {
        rootViewController = WebAssembly.createModule(link)
    }
    
    override func start() {}
}

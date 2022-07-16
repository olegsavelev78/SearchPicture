import Combine

typealias CancelBag = Set<AnyCancellable>

extension CancelBag {
    func cancel() {
        self.forEach { $0.cancel() }
    }
}

import Combine

@propertyWrapper
public struct PublishedProperty<Value> {
    private let subject = PassthroughSubject<Value, Never>()
    public var wrappedValue: Value {
        didSet {
            subject.send(wrappedValue)
        }
    }
    
    public var projectedValue: AnyPublisher<Value, Never> {
        subject.eraseToAnyPublisher()
    }
    
    public init(wrappedValue: Value = ()) where Value == Void {
        self.wrappedValue = wrappedValue
    }
    
    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}

public struct PublishedAction<Value> {
    private var subject = PassthroughSubject<Value, Never>()
    public var publisher: AnyPublisher<Value, Never> {
        subject.eraseToAnyPublisher()
    }
    
    public func send(_ value: Value) {
        subject.send(value)
    }
    
    public func send(_ value: Value = ()) where Value == Void {
        subject.send(value)
    }
}

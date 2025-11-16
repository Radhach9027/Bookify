//
//  EventState.swift
//  BookifySharedSystem
//
//  Created by radha chilamkurthy on 07/11/25.
//

import Combine
import Foundation

@propertyWrapper
public final class EventState<E: AppEvent> {
    private var cancellable: AnyCancellable?
    private let bus: EventBusType
    private let subject = PassthroughSubject<E, Never>()

    public private(set) var wrappedValue: E? = nil {
        didSet { if let v = wrappedValue { subject.send(v) } }
    }

    public var projectedValue: AnyPublisher<E, Never> { subject.eraseToAnyPublisher() }

    public init(bus: EventBusType) {
        self.bus = bus
        self.cancellable = bus.publisher(E.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.wrappedValue = $0 }
    }

    deinit { cancellable?.cancel() }
}

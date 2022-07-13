//
//  Coordinator.swift
//  SearchImage
//
//  Created by Олег Савельев on 13.07.2022.
//

import Foundation

open class Coordinator: NSObject {

    private let identifier = UUID()
    private var childCoordinators = [UUID: Any]()

    private func store(coordinator: Coordinator) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    private func release(coordinator: Coordinator) {
        childCoordinators[coordinator.identifier] = nil
    }

    open func coordinate(to coordinator: Coordinator) {
        store(coordinator: coordinator)
        return coordinator.start()
    }

    open func start(){
        fatalError("start() method must be implemented")
    }
}

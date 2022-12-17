//
//  Coordinator.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 17/12/2022.
//

import Foundation

public protocol Coordinator : AnyObject {
    var childCoordinators : [Coordinator] { get set }
    var isCompleted: (() -> Void)? { get set }
    func start()
}

extension Coordinator {

    public func add(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    public func remove(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    
}

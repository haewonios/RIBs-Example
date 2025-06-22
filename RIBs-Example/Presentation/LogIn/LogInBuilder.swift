//
//  LogInBuilder.swift
//  RIBs-Example
//
//  Created by hyewon on 2025/06/22.
//

import RIBs

protocol LogInDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class LogInComponent: Component<LogInDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LogInBuildable: Buildable {
    func build(withListener listener: LogInListener) -> LogInRouting
}

final class LogInBuilder: Builder<LogInDependency>, LogInBuildable {

    override init(dependency: LogInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LogInListener) -> LogInRouting {
        let component = LogInComponent(dependency: dependency)
        let viewController = LogInViewController()
        let interactor = LogInInteractor(presenter: viewController)
        interactor.listener = listener
        return LogInRouter(interactor: interactor, viewController: viewController)
    }
}

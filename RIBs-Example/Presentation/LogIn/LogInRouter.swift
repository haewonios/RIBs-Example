//
//  LogInRouter.swift
//  RIBs-Example
//
//  Created by hyewon on 2025/06/22.
//

import RIBs

protocol LogInInteractable: Interactable {
    var router: LogInRouting? { get set }
    var listener: LogInListener? { get set }
}

protocol LogInViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class LogInRouter: ViewableRouter<LogInInteractable, LogInViewControllable>, LogInRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: LogInInteractable, viewController: LogInViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

//
//  RootRouter.swift
//  RIBs-Example
//
//  Created by hyewon on 2025/06/21.
//

import RIBs

protocol RootInteractable: Interactable, LogInListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(_ viewControllable: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    private let loginBuilder: LogInBuildable
    private var loginRouter: LogInRouting?
    
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        loginBuilder: LogInBuildable
    ) {
        self.loginBuilder = loginBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension RootRouter {
    func attachLogin() {
        guard loginRouter == nil else {
            return
        }
        let router = loginBuilder.build(withListener: interactor)
        self.loginRouter = router
        attachChild(router)
        
        viewController.present(router.viewControllable)
    }
    
    func detachLogin() {
        guard let loginRouter else {
            return
        }
        detachChild(loginRouter)
        loginRouter.viewControllable.uiviewController.dismiss(animated: true)
        self.loginRouter = nil
    }
}

//
//  RootViewController.swift
//  RIBs-Example
//
//  Created by hyewon on 2025/06/21.
//

import RIBs
import RxSwift
import UIKit
import RxCocoa
import SnapKit
import Then

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func didTapLoginButton()
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
    
    private var loginButton = UIButton().then {
        $0.setTitle("로그인 화면 이동", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }

    weak var listener: RootPresentableListener?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupControl()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setupControl() {
        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                print("button tapped")
                self?.listener?.didTapLoginButton()
            })
            .disposed(by: disposeBag)
    }
}

extension RootViewController {
    func present(_ viewControllable: ViewControllable) {
        viewControllable.uiviewController.modalPresentationStyle = .fullScreen
        self.present(viewControllable.uiviewController, animated: true)
    }
}

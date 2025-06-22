//
//  LogInViewController.swift
//  RIBs-Example
//
//  Created by hyewon on 2025/06/22.
//

import RIBs
import RxSwift
import UIKit
import RxCocoa
import SnapKit
import Then

protocol LogInPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func didTapBackButton()
}

final class LogInViewController: UIViewController, LogInPresentable, LogInViewControllable {
    
    private let backButton = UIButton().then {
        $0.setTitle("뒤로 가기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }

    weak var listener: LogInPresentableListener?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupControl()
    }
    
    func setupUI() {
        view.backgroundColor = .yellow
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setupControl() {
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                print("backButton tapped")
                self?.listener?.didTapBackButton()
            })
            .disposed(by: disposeBag)
    }
}

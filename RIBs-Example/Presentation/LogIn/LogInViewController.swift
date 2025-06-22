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
    func didTapRecordButton() async
}

final class LogInViewController: UIViewController, LogInPresentable, LogInViewControllable {
    
    private let backButton = UIButton().then {
        $0.setTitle("뒤로 가기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    private let recordButton = UIButton().then {
        $0.setTitle("녹음 시작", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
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
        view.addSubview(recordButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
        }
        
        recordButton.snp.makeConstraints {
            $0.top.equalTo(backButton).offset(200)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setupControl() {
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                print("backButton tapped")
                self?.listener?.didTapBackButton()
            })
            .disposed(by: disposeBag)
        
        recordButton.rx.tap
            .subscribe(onNext: { [weak self] in
                Task {
                    await self?.listener?.didTapRecordButton()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func updateRecordButtonTitle(_ title: String) {
        DispatchQueue.main.async { [weak self] in
            self?.recordButton.setTitle(title, for: .normal)
        }
    }
}

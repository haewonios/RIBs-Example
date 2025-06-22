//
//  LogInInteractor.swift
//  RIBs-Example
//
//  Created by hyewon on 2025/06/22.
//

import RIBs
import RxSwift

protocol LogInRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LogInPresentable: Presentable {
    var listener: LogInPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func updateRecordButtonTitle(_ title: String)
}

protocol LogInListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didTapBackButton()
}

final class LogInInteractor: PresentableInteractor<LogInPresentable>, LogInInteractable, LogInPresentableListener {

    weak var router: LogInRouting?
    weak var listener: LogInListener?
    
    private let useCase: RecordAudioUseCaseProtocol

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(
        presenter: LogInPresentable,
        recordAudioUseCase: RecordAudioUseCaseProtocol
    ) {
        self.useCase = recordAudioUseCase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

extension LogInInteractor {
    func didTapBackButton() {
        listener?.didTapBackButton()
    }
    
    func didTapRecordButton() async {
        let permission = await useCase.checkPermission()
        if !permission {
            print("denied :(")
            return
        }
        
        if useCase.isRecoring {
            let state = useCase.stopRecording()
            presenter.updateRecordButtonTitle("녹음 완료")
            print("state: \(state)")
        } else {
            do {
                try useCase.startRecording()
                presenter.updateRecordButtonTitle("녹음중...")
            } catch {
                print("error! \(error)")
                presenter.updateRecordButtonTitle("녹음중 오류가 발생했습니다.")
            }
        }
        
    }
}

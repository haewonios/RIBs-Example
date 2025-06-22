//
//  RecordAudioUseCase.swift
//  RIBs-Example
//
//  Created by hyewon on 2025/06/23.
//

import Foundation

protocol RecordAudioUseCaseProtocol {
    func checkPermission() async -> Bool
    func startRecording() throws
    func stopRecording() -> URL?
    var isRecoring: Bool { get }
}

class RecordAudioUseCase: RecordAudioUseCaseProtocol {
    
    private let recorder: RecordAudioManager
    
    init(recorder: RecordAudioManager) {
        self.recorder = recorder
    }
    
    func checkPermission() async -> Bool {
        await recorder.checkPermission()
    }
    
    func startRecording() throws {
        try recorder.startRecording()
    }
    
    func stopRecording() -> URL? {
        recorder.stopRecording()
    }
    
    var isRecoring: Bool {
        recorder.isRecording
    }
}

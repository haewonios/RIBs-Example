//
//  RecordAudioManager.swift
//  RIBs-Example
//
//  Created by hyewon on 2025/06/23.
//

import Foundation
import AVFoundation

enum RecordAudioError: Error {
    case permissionDenied
    case startFail(String)
    case etc
}

class RecordAudioManager: NSObject, AVAudioRecorderDelegate {
    
    static let shared = RecordAudioManager()
    
    private var audioRecorder: AVAudioRecorder?
    private(set) var isRecording = false
    
    private override init() {
        super.init()
    }
    
    func checkPermission() async -> Bool {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .undetermined:
            return await withCheckedContinuation { continuation in
                AVAudioSession.sharedInstance().requestRecordPermission { granted in
                    if granted {
                        continuation.resume(returning: true)
                    } else {
                        continuation.resume(returning: false)
                    }
                }
            }
        case .granted:
            return true
        default:
            return false
        }
    }
    
    func startRecording() throws {
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(.record)
            try session.setActive(true)
        } catch {
            print("session error throws")
            print("====================")
            print(error)
        }
        
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        let url = generateFileURL()
        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            isRecording = true
        } catch {
            print("recorder error throws")
            print("====================")
            print(error)
        }
        
        print("--> startRecording... \(url)")
    }
    
    func stopRecording() -> URL? {
        audioRecorder?.stop()
        let recordingFileURL = audioRecorder?.url
        audioRecorder = nil
        isRecording = false
        print("--> stopRecording...")
        
        return recordingFileURL
    }
    
    private func generateFileURL() -> URL {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss"
        let fileName = "recording_\(formatter.string(from: Date())).m4a"
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        return documentPath.appendingPathComponent(fileName)
    }
    
}

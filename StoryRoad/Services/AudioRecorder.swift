import AVFoundation
import Foundation

/// 마이크 녹음 — Documents/audio 폴더에 m4a로 저장
@MainActor
final class AudioRecorder: NSObject, ObservableObject {
    @Published var isRecording = false
    @Published var elapsed: TimeInterval = 0
    @Published var permissionDenied = false

    private var recorder: AVAudioRecorder?
    private var timer: Timer?
    private(set) var currentFileName: String?

    func startRecording() {
        Task {
            let granted = await AVAudioApplication.requestRecordPermission()
            if granted {
                beginRecording()
            } else {
                permissionDenied = true
            }
        }
    }

    private func beginRecording() {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
        try? session.setActive(true)

        let fileName = "rec-\(UUID().uuidString).m4a"
        let url = AppStore.audioDirectory.appendingPathComponent(fileName)
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        guard let newRecorder = try? AVAudioRecorder(url: url, settings: settings) else { return }
        newRecorder.record()
        recorder = newRecorder
        currentFileName = fileName
        elapsed = 0
        isRecording = true

        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                guard let self else { return }
                self.elapsed = self.recorder?.currentTime ?? self.elapsed
            }
        }
    }

    /// 녹음을 끝내고 저장된 파일 이름을 돌려준다
    @discardableResult
    func stopRecording() -> String? {
        recorder?.stop()
        recorder = nil
        timer?.invalidate()
        timer = nil
        isRecording = false
        return currentFileName
    }

    /// 저장하지 않고 취소
    func discardRecording() {
        let fileName = stopRecording()
        if let fileName {
            try? FileManager.default.removeItem(at: AppStore.audioDirectory.appendingPathComponent(fileName))
        }
        currentFileName = nil
    }

    var elapsedLabel: String {
        let seconds = Int(elapsed)
        return String(format: "%d:%02d", seconds / 60, seconds % 60)
    }
}

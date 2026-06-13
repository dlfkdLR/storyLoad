import AVFoundation
import Foundation

/// 오디오 스토리 재생기
/// - 내가 녹음한 스토리: 파일 재생 (AVAudioPlayer)
/// - 타사용자 스토리: transcript를 한국어 음성 합성으로 재생 (데모용)
final class StoryPlayer: NSObject, ObservableObject {
    @Published var playingID: UUID?

    private var player: AVAudioPlayer?
    private let synthesizer = AVSpeechSynthesizer()

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    func toggle(_ story: AudioStory) {
        if playingID == story.id {
            stop()
            return
        }
        stop()

        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.playback, mode: .spokenAudio)
        try? session.setActive(true)

        if let fileName = story.fileName {
            let url = AppStore.audioDirectory.appendingPathComponent(fileName)
            guard let newPlayer = try? AVAudioPlayer(contentsOf: url) else { return }
            newPlayer.delegate = self
            newPlayer.play()
            player = newPlayer
        } else {
            let utterance = AVSpeechUtterance(string: story.transcript)
            utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
            utterance.rate = 0.48
            synthesizer.speak(utterance)
        }
        playingID = story.id
    }

    func stop() {
        player?.stop()
        player = nil
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        playingID = nil
    }

    /// 재생이 자연 종료됐을 때만 상태를 비운다 (새 재생과의 경합 방지)
    private func clearIfIdle() {
        DispatchQueue.main.async {
            if self.player?.isPlaying != true && !self.synthesizer.isSpeaking {
                self.playingID = nil
            }
        }
    }
}

extension StoryPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        clearIfIdle()
    }
}

extension StoryPlayer: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        clearIfIdle()
    }
}

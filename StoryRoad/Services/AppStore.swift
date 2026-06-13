import Foundation
import SwiftUI
import UIKit

/// 앱 전역 상태 — 스탬프, 추억, 오디오 스토리, 피드
@MainActor
final class AppStore: ObservableObject {
    @Published private(set) var regions: [Region] = SampleData.regions
    /// 지역 ID → 잠금 해제(스탬프 획득) 시각
    @Published private(set) var unlockedAt: [String: Date] = [:]
    @Published private(set) var memories: [Memory] = []
    @Published private(set) var audioStories: [AudioStory] = []
    @Published var posts: [FeedPost] = []
    @Published var following: Set<String> = ["바다소년", "안동토박이"]

    /// 데모 모드 — 실제 GPS 없이도 잠금 해제 가능 (심사·시연용)
    @Published var demoMode: Bool {
        didSet { UserDefaults.standard.set(demoMode, forKey: "demoMode") }
    }

    init() {
        demoMode = UserDefaults.standard.object(forKey: "demoMode") as? Bool ?? true
        try? FileManager.default.createDirectory(at: Self.audioDirectory, withIntermediateDirectories: true)
        try? FileManager.default.createDirectory(at: Self.photoDirectory, withIntermediateDirectories: true)
        load()
    }

    // MARK: - 스탬프 / 잠금

    func isUnlocked(_ regionID: String) -> Bool {
        unlockedAt[regionID] != nil
    }

    func unlockDate(_ regionID: String) -> Date? {
        unlockedAt[regionID]
    }

    func unlock(_ region: Region) {
        guard unlockedAt[region.id] == nil else { return }
        unlockedAt[region.id] = Date()
        save()
    }

    func region(for id: String) -> Region? {
        regions.first { $0.id == id }
    }

    var unlockedCount: Int {
        unlockedAt.count
    }

    var stampProgress: Double {
        guard !regions.isEmpty else { return 0 }
        return Double(unlockedAt.count) / Double(regions.count)
    }

    // MARK: - 오디오 스토리

    func stories(in regionID: String) -> [AudioStory] {
        audioStories.filter { $0.regionID == regionID }
    }

    func story(id: UUID) -> AudioStory? {
        audioStories.first { $0.id == id }
    }

    func addStory(regionID: String, title: String, fileName: String, durationText: String) {
        let story = AudioStory(
            id: UUID(), regionID: regionID, author: "나",
            title: title.isEmpty ? "나의 오디오 스토리" : title,
            transcript: "", durationText: durationText,
            fileName: fileName, isMine: true
        )
        audioStories.append(story)
        posts.insert(Self.makePost(from: story), at: 0)
        save()
    }

    /// 내 녹음을 피드 게시물 형태로 변환
    nonisolated private static func makePost(from story: AudioStory) -> FeedPost {
        FeedPost(
            id: story.id.uuidString, author: "나", authorBadge: "여행자",
            regionID: story.regionID, text: story.title,
            timeAgo: "방금 전", likes: 0, comments: 0,
            audioStoryID: story.id, photo: nil
        )
    }

    // MARK: - 지역 피드

    func posts(in regionID: String) -> [FeedPost] {
        posts.filter { $0.regionID == regionID }
    }

    // MARK: - 내 추억

    func memories(in regionID: String) -> [Memory] {
        memories.filter { $0.regionID == regionID }
    }

    func addMemory(_ memory: Memory) {
        memories.insert(memory, at: 0)
        save()
    }

    // MARK: - 사진 캐시

    private let photoCache = NSCache<NSString, UIImage>()

    /// 추억 사진을 표시 크기로 다운샘플링해 로드 (캐시 우선)
    func photo(named fileName: String, maxPixelSize: CGFloat) -> UIImage? {
        let key = "\(fileName)#\(Int(maxPixelSize))" as NSString
        if let cached = photoCache.object(forKey: key) { return cached }

        let url = Self.photoDirectory.appendingPathComponent(fileName)
        guard let image = UIImage.downsampled(at: url, maxPixelSize: maxPixelSize) else { return nil }
        photoCache.setObject(image, forKey: key)
        return image
    }

    /// 지도에 표시할 대표 사진 — 해당 지역에서 찍은 가장 최근 추억 사진
    func coverPhoto(for regionID: String) -> UIImage? {
        for memory in memories(in: regionID) {
            if let fileName = memory.photoFileName,
               let image = photo(named: fileName, maxPixelSize: 240) {
                return image
            }
        }
        return nil
    }

    func deleteMemory(_ memory: Memory) {
        if let photo = memory.photoFileName {
            try? FileManager.default.removeItem(at: Self.photoDirectory.appendingPathComponent(photo))
        }
        if let audio = memory.audioFileName {
            try? FileManager.default.removeItem(at: Self.audioDirectory.appendingPathComponent(audio))
        }
        memories.removeAll { $0.id == memory.id }
        photoCache.removeAllObjects()
        save()
    }

    // MARK: - 팔로우 (단방향)

    func toggleFollow(_ author: String) {
        if following.contains(author) {
            following.remove(author)
        } else {
            following.insert(author)
        }
    }

    // MARK: - 저장 / 불러오기

    nonisolated static var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    nonisolated static var audioDirectory: URL {
        documentsDirectory.appendingPathComponent("audio", isDirectory: true)
    }

    nonisolated static var photoDirectory: URL {
        documentsDirectory.appendingPathComponent("photos", isDirectory: true)
    }

    private struct SavedState: Codable {
        var unlockedAt: [String: Date]
        var memories: [Memory]
        var myStories: [AudioStory]
    }

    nonisolated private static var stateURL: URL {
        documentsDirectory.appendingPathComponent("storyroad-state.json")
    }

    private func save() {
        let state = SavedState(
            unlockedAt: unlockedAt,
            memories: memories,
            myStories: audioStories.filter(\.isMine)
        )
        if let data = try? JSONEncoder().encode(state) {
            try? data.write(to: Self.stateURL, options: .atomic)
        }
    }

    private func load() {
        var myStories: [AudioStory] = []
        if let data = try? Data(contentsOf: Self.stateURL),
           let state = try? JSONDecoder().decode(SavedState.self, from: data) {
            unlockedAt = state.unlockedAt
            memories = state.memories
            myStories = state.myStories
        }
        audioStories = SampleData.audioStories + myStories
        let myPosts = myStories.reversed().map(Self.makePost(from:))
        posts = myPosts + SampleData.posts
    }
}

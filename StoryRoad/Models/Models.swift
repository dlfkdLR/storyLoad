import Foundation
import CoreLocation
import SwiftUI

// MARK: - 지역

struct Region: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let subtitle: String
    let latitude: Double
    let longitude: Double
    let unlockRadiusMeters: Double
    /// 방문 전에 보이는 대략적인 소개
    let teaser: String
    /// 잠금 해제 후 보이는 지역 특색
    let fullDescription: String
    let symbol: String
    let colorHex: String
    let events: [RegionEvent]
    let localTips: [LocalTip]

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var color: Color { Color(hex: colorHex) }
}

struct RegionEvent: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let period: String
    let detail: String
}

/// 현지인이 올린 "우리 동네 좋은 점"
struct LocalTip: Identifiable, Codable, Hashable {
    let id: String
    let author: String
    let content: String
}

// MARK: - 오디오 스토리

struct AudioStory: Identifiable, Codable, Hashable {
    let id: UUID
    let regionID: String
    let author: String
    let title: String
    /// 타사용자 스토리는 이 텍스트를 음성 합성으로 재생한다
    let transcript: String
    let durationText: String
    /// 내가 직접 녹음한 파일 이름 (Documents/audio 폴더)
    let fileName: String?
    let isMine: Bool
}

// MARK: - 피드 (단방향 SNS)

/// 게시물에 첨부된 사진 (데모용 — 그라데이션 풍경 카드로 렌더링)
struct PostPhoto: Codable, Hashable {
    let symbol: String
    let caption: String
    let topColorHex: String
    let bottomColorHex: String
}

struct FeedPost: Identifiable, Hashable {
    let id: String
    let author: String
    let authorBadge: String
    let regionID: String
    let text: String
    let timeAgo: String
    let likes: Int
    let comments: Int
    let audioStoryID: UUID?
    let photo: PostPhoto?
}

// MARK: - 내 추억 (비공개 다이어리)

struct Memory: Identifiable, Codable, Hashable {
    let id: UUID
    let regionID: String
    var text: String
    let createdAt: Date
    var photoFileName: String?
    var audioFileName: String?
}

// MARK: - 헬퍼

extension Color {
    /// 브랜드 팔레트 — 스탬프 찍은 지역 표시용
    static let stampLight = Color(hex: "EA7B7B")
    static let stampMid = Color(hex: "D25353")
    static let stampDeep = Color(hex: "9E3B3B")
    static let stampCream = Color(hex: "FFEAD3")

    init(hex: String) {
        var value: UInt64 = 0
        Scanner(string: hex.replacingOccurrences(of: "#", with: "")).scanHexInt64(&value)
        self.init(
            red: Double((value >> 16) & 0xFF) / 255,
            green: Double((value >> 8) & 0xFF) / 255,
            blue: Double(value & 0xFF) / 255
        )
    }
}

extension Date {
    var stampLabel: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: self)
    }

    var memoryLabel: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일 (E)"
        return formatter.string(from: self)
    }
}

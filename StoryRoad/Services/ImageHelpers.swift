import UIKit
import ImageIO

extension UIImage {
    /// ImageIO 썸네일 API로 디코딩 비용을 줄여 디스크 이미지를 표시 크기로 로드
    static func downsampled(at url: URL, maxPixelSize: CGFloat) -> UIImage? {
        let sourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let source = CGImageSourceCreateWithURL(url as CFURL, sourceOptions) else { return nil }

        let thumbnailOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixelSize
        ] as [CFString: Any] as CFDictionary

        guard let cgImage = CGImageSourceCreateThumbnailAtIndex(source, 0, thumbnailOptions) else { return nil }
        return UIImage(cgImage: cgImage)
    }

    /// 저장용 — 긴 변을 maxPixelSize 이하로 줄여 JPEG 인코딩
    func jpegDataResized(maxPixelSize: CGFloat, quality: CGFloat) -> Data? {
        let maxSide = max(size.width * scale, size.height * scale)
        guard maxSide > maxPixelSize else { return jpegData(compressionQuality: quality) }

        let ratio = maxPixelSize / maxSide
        let newSize = CGSize(width: size.width * scale * ratio, height: size.height * scale * ratio)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let resized = UIGraphicsImageRenderer(size: newSize, format: format).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
        return resized.jpegData(compressionQuality: quality)
    }
}

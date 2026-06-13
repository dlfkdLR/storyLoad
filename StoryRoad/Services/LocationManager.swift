import CoreLocation
import Foundation

/// 현재 위치 추적 및 지역 도착 판정
final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var location: CLLocation?
    @Published var status: CLAuthorizationStatus = .notDetermined

    private let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    func request() {
        manager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        status = manager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}

    // MARK: - 지역 판정

    func distance(to region: Region) -> CLLocationDistance? {
        guard let location else { return nil }
        let target = CLLocation(latitude: region.latitude, longitude: region.longitude)
        return location.distance(from: target)
    }

    /// 해당 지역 잠금 해제 반경 안에 있는지
    func isInside(_ region: Region) -> Bool {
        guard let distance = distance(to: region) else { return false }
        return distance <= region.unlockRadiusMeters
    }

    /// 현재 위치가 속한 지역 (가장 가까운 곳 우선)
    func currentRegion(from regions: [Region]) -> Region? {
        regions
            .compactMap { region -> (Region, CLLocationDistance)? in
                guard let d = distance(to: region), d <= region.unlockRadiusMeters else { return nil }
                return (region, d)
            }
            .min { $0.1 < $1.1 }?
            .0
    }

    func distanceLabel(to region: Region) -> String? {
        guard let distance = distance(to: region) else { return nil }
        if distance >= 1000 {
            return String(format: "약 %.0fkm", distance / 1000)
        }
        return String(format: "약 %.0fm", distance)
    }
}

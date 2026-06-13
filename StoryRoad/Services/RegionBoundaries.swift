import Foundation
import MapKit

/// 번들된 GeoJSON에서 시·군 행정구역 경계 폴리곤을 읽는다
final class RegionBoundaries {
    static let shared = RegionBoundaries()

    /// 지역 ID → 폴리곤(좌표 배열) 목록. 포항(북구+남구), 울릉(섬들)처럼 여러 개일 수 있다.
    private(set) var polygons: [String: [[CLLocationCoordinate2D]]] = [:]

    private init() {
        guard let url = Bundle.main.url(forResource: "RegionBoundaries", withExtension: "geojson"),
              let data = try? Data(contentsOf: url),
              let objects = try? MKGeoJSONDecoder().decode(data) else { return }

        for case let feature as MKGeoJSONFeature in objects {
            guard let propsData = feature.properties,
                  let props = try? JSONSerialization.jsonObject(with: propsData) as? [String: String],
                  let id = props["id"] else { continue }

            for geometry in feature.geometry {
                if let polygon = geometry as? MKPolygon {
                    polygons[id, default: []].append(polygon.coordinateList)
                } else if let multiPolygon = geometry as? MKMultiPolygon {
                    for polygon in multiPolygon.polygons {
                        polygons[id, default: []].append(polygon.coordinateList)
                    }
                }
            }
        }
    }

    func polygons(for regionID: String) -> [[CLLocationCoordinate2D]] {
        polygons[regionID] ?? []
    }
}

private extension MKPolygon {
    var coordinateList: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](
            repeating: CLLocationCoordinate2D(),
            count: pointCount
        )
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        return coords
    }
}

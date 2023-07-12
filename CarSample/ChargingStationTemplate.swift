//
//  ChargingStationTemplate.swift
//  CarSample
//
//  Created by 杨以皓 on 2023/6/29.
//

import Foundation
import CarPlay
import MapKit

class ChargingStationController {
    enum StationType {
        case porsche
        case thirdParty
    }
    
    var template: CPPointOfInterestTemplate = .init(title: "附近充电站",
                                                    pointsOfInterest: [],
                                                    selectedIndex: 0)
    
    private var type: StationType = .porsche
    private weak var scene: UIScene?
    
    var currentPOIs: [CPPointOfInterest] {
        let stations = type == .porsche ? Station.porsche : Station.thirdParty
        let image = type == .porsche ? UIImage(named: "porsche-owned-station") : UIImage(named: "third-party-station")
        return stations.map { station in
            let poi = CPPointOfInterest(location: .init(placemark: .init(coordinate: station.coordinate)),
                                     title: station.name,
                                        subtitle: station.address,
                                     summary: nil,
                                     detailTitle: station.name,
                                     detailSubtitle: station.address,
                                     detailSummary: nil,
                                     pinImage: image)
            poi.primaryButton = .init(title: "导航", textStyle: .normal, handler: { [weak self] button in
                guard let self else { return }
                let dest = CLLocationCoordinate2D(latitude: station.coordinate.latitude,
                                                  longitude: station.coordinate.longitude)
                let destLocation = MKMapItem(placemark: MKPlacemark(coordinate: dest))
                destLocation.name = station.name
                guard let scene = self.scene else { return }
                MKMapItem.openMaps(with: [MKMapItem.forCurrentLocation(), destLocation],
                                   launchOptions: [
                                       MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                       MKLaunchOptionsShowsTrafficKey: 1
                                   ],
                                   from: scene)
            })
            return poi
        }
    }
    
    var toggleButton: CPBarButton {
        let title = type == .porsche ? "第三方" : "保时捷尊享"
        return CPBarButton(title: title) { [weak self] button in
            guard let self else { return }
            if self.type == .porsche {
                self.type = .thirdParty
            } else {
                self.type = .porsche
            }
            self.refresh()
        }
    }
    
    init(scene: UIScene) {
        self.scene = scene
    }
    
    func refresh() {
        template.setPointsOfInterest(currentPOIs, selectedIndex: 0)
        template.trailingNavigationBarButtons = [toggleButton]
    }
}

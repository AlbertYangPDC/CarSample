//
//  Dr. Ing. h.c. F. Porsche AG confidential. This code is protected by intellectual property rights.
//  The Dr. Ing. h.c. F. Porsche AG owns exclusive legal rights of use.
//

import Foundation
import CarPlay

class CarPlayUtils {
    static func getActionSheetTemplate() -> CPActionSheetTemplate {
        return CPActionSheetTemplate(title: "选择地图", message: nil, actions: [
            .init(title: "苹果地图", style: .default, handler: { _ in }),
            .init(title: "高德地图", style: .default, handler: { _ in })
        ])
    }
    
    static func getInfoTemplate() -> CPInformationTemplate {
        let template = CPInformationTemplate(title: "天气", layout: CPInformationTemplateLayout.twoColumn, items: [], actions: [])
        template.items.append(CPInformationItem(title: "城市", detail: "上海"))
        template.items.append(CPInformationItem(title: "温度", detail: "26℃"))
        template.items.append(CPInformationItem(title: "空气质量", detail: "80%"))
        return template
    }

    static func getListTemplate() -> CPListTemplate {
        let items = Station.porsche.map { station in
            let item = CPListItem(text: station.name,
                                  detailText: station.address,
                                  image: UIImage(systemName: "bolt.car"),
                                  accessoryImage: UIImage(systemName: "bolt.batteryblock"),
                                  accessoryType: .cloud)
            
            item.handler = { item, completion in
                completion()
            }
            return item
        }
        let section = CPListSection(items: items)
        return CPListTemplate(title: "尊享充电", sections: [section])
    }
}

class Station {
    static var porsche: [Station] {
        [
            .init(name: "上海大融城保时捷Turbo充电站",
               address: "上海市静安区沪太路1111弄,地面103-105车位",
               coordinate: .init(latitude: 31.279852,
                                 longitude: 121.427231)),
            .init(name: "上海尚嘉中心保时捷超级充电站",
                  address: "上海市长宁区仙霞路99号(近遵义路)，B3层141,143车位。",
                  coordinate: .init(latitude: 31.205688,
                                    longitude: 121.407135)),
            .init(name: "上海兴业太古汇保时捷超级充电站",
                  address: "上海市静安区石门一路288弄，P1层，C区，C078,C080车位",
                  coordinate: .init(latitude: 31.229506,
                                    longitude: 121.463448)),
            .init(name: "上海明天广场保时捷超级充电站",
                  address: "上海市黄浦区南京西路341号上海明天广场地面停车场入口",
                  coordinate: .init(latitude: 31.230398,
                                    longitude: 121.469124))
        ]
    }
    
    static var thirdParty: [Station] {
        [
            .init(name: "上海市普陀区新村路充电站",
               address: "上海市普陀区万里街道新村路663号柯桐商务",
               coordinate: .init(latitude: 31.265265,
                                 longitude: 121.420044)),
            .init(name: "天汇广场",
                  address: "曹杨路2021号",
                  coordinate: .init(latitude: 31.255634,
                                    longitude: 121.401665))
        ]
    }
    
    let name: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    
    init(name: String,
         address: String,
         coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.address = address
        self.coordinate = coordinate
    }
}

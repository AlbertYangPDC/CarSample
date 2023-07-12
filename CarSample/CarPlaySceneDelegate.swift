//
//  Dr. Ing. h.c. F. Porsche AG confidential. This code is protected by intellectual property rights.
//  The Dr. Ing. h.c. F. Porsche AG owns exclusive legal rights of use.
//

import UIKit
import MapKit
// CarPlay App Lifecycle

import CarPlay
import os.log

class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
    var interfaceController: CPInterfaceController?
    var dashboardController: CPDashboardController?
    let logger = Logger()
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                  didConnect interfaceController: CPInterfaceController) {
        
        self.interfaceController = interfaceController
        
        let gridButton = CPGridButton(titleVariants: ["地图选择"],
                                      image: UIImage(systemName: "map")!)
        { button in
            self.interfaceController?.presentTemplate(CarPlayUtils.getActionSheetTemplate(), animated: true, completion: nil)
        }
        
        
        let gridButton1 = CPGridButton(titleVariants: ["尊享充电"],
                                       image: UIImage(named: "chat")!)
        { button in
            self.interfaceController?.pushTemplate(CarPlayUtils.getListTemplate(),
                                                   animated: true,
                                                   completion: nil)
            
        }
        
        let gridButton2 = CPGridButton(titleVariants: ["天气"],
                                       image: UIImage(systemName: "cloud.sun.fill")!)
        { button in
            self.interfaceController?.pushTemplate(CarPlayUtils.getInfoTemplate(),
                                                   animated: true,
                                                   completion: nil)
            
        }
        
        let gridButton3 = CPGridButton(titleVariants: ["警报"],
                                       image: UIImage(systemName: "alarm")!)
        { button in
            self.interfaceController?.presentTemplate(CPAlertTemplate(titleVariants: ["Alarm1"], actions: [
                .init(title: "Cancel", style: .destructive, handler: { action in
                    self.interfaceController?.dismissTemplate(animated: true)
                })
            ]),
                                                      animated: true,
                                                      completion: nil)
            
        }
        
        let controller = ChargingStationController(scene: templateApplicationScene)
        controller.refresh()
        let gridButton4 = CPGridButton(titleVariants: ["电站"],
                                       image: UIImage(systemName: "mappin")!)
        { button in
            self.interfaceController?.pushTemplate(controller.template,
                                                   animated: true,
                                                   completion: nil)
        }
        
        let gridTemplate = CPGridTemplate(title: "保时捷", gridButtons: [gridButton,
                                                                      gridButton1,
                                                                      gridButton2,
                                                                      gridButton3,
                                                                      gridButton4])
        
        // SwiftC apparently requires the explicit inclusion of the completion parameter,
        // otherwise it will throw a warning
        interfaceController.setRootTemplate(gridTemplate,
                                            animated: true,
                                            completion: nil)
    }
}

extension CarPlaySceneDelegate: CPTemplateApplicationDashboardSceneDelegate,
                                CPTemplateApplicationInstrumentClusterSceneDelegate {
    func templateApplicationDashboardScene(_ templateApplicationDashboardScene: CPTemplateApplicationDashboardScene,
                                           didConnect dashboardController: CPDashboardController,
                                           to window: UIWindow) {
        self.dashboardController = dashboardController
        let button = CPDashboardButton(titleVariants: ["Test"],
                                       subtitleVariants: ["hahahaha"],
                                       image: UIImage(named: "chat")!)
        dashboardController.shortcutButtons = [button]
        
    }
}

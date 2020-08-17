//
//  UIDevice+utils.swift
//  Later
//
//  Created by tree on 2020/4/12.
//  Copyright © 2020 jiazifa. All rights reserved.
//

import UIKit

extension UIDevice {
    var isNotchScreen: Bool {
        guard let window = UIApplication.shared.delegate?.window else { return false}
        if window?.safeAreaInsets.bottom ?? 0.0 > 0.0 { return true }
        return false
    }
    
    var isPad: Bool {
        return UIDevice.current.model == "iPad"
    }
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror.init(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}


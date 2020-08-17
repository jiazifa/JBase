//
//  UIApplication+utils.swift
//  Later
//
//  Created by tree on 2020/4/12.
//  Copyright © 2020 jiazifa. All rights reserved.
//

import UIKit

public extension UIApplication {
    static let statusBarStyleChangeNotification: Notification.Name = {
        return Notification.Name("statusBarStyleChangeNotification")
    }()

    @objc func updateStatusBarForCurrentControllerAnimated(_ animated: Bool) {
        updateStatusBarForCurrentControllerAnimated(animated, onlyFullScreen: true)
    }

    @objc func updateStatusBarForCurrentControllerAnimated(_ animated: Bool, onlyFullScreen: Bool) {
        let statusBarHidden: Bool
        let statusBarStyle: UIStatusBarStyle

        if let topContoller = self.topMostController(onlyFullScreen: onlyFullScreen) {
            statusBarHidden = topContoller.prefersStatusBarHidden
            statusBarStyle = topContoller.preferredStatusBarStyle
        } else {
            statusBarHidden = true
            statusBarStyle = .lightContent
        }

        var changed = false

        if self.isStatusBarHidden != statusBarHidden {
            if #available(iOS 9.0, *) {} else {
                self.setStatusBarHidden(statusBarHidden, with: animated ? .fade : .none)
                changed = true
            }
        }

        if self.statusBarStyle != statusBarStyle {
            if #available(iOS 9.0, *) {} else {
                self.setStatusBarStyle(statusBarStyle, animated: animated)
                changed = true
            }
        }

        if changed {
            let notificationName = type(of: self).statusBarStyleChangeNotification
            NotificationCenter.default.post(name: notificationName, object: self)
        }
    }

    func topMostViewController() -> UIViewController? {
        return topMostController()
    }

    /// return the visible window on the top most which fulfills these conditions:
    /// 1. the windows has rootViewController
    /// 3. the window's rootViewController is AppRootViewController
    var topMostVisibleWindow: UIWindow? {
        let orderedWindows = self.windows.sorted { win1, win2 in
            win1.windowLevel < win2.windowLevel
        }

        let visibleWindow = orderedWindows.filter {
            guard $0.rootViewController != nil else {
                return false
            }
            return true
        }
 
        return visibleWindow.last
    }

    func topMostController(onlyFullScreen: Bool = true) -> UIViewController? {

        guard let window = topMostVisibleWindow,
            var topController = window.rootViewController else {
                return .none
        }

        while let presentedController = topController.presentedViewController,
            (!onlyFullScreen || presentedController.modalPresentationStyle == .fullScreen) {
            topController = presentedController
        }

        return topController
    }
}


extension UIViewController {
    @objc var supportedOrientations: UIInterfaceOrientationMask {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            switch self.traitCollection.horizontalSizeClass {
            case .compact:
                return .portrait
            case .regular:
                return .all
            default:
                return .all
            }
        case .phone:
            return .portrait
        default:
            return .portrait
        }
    }
}

extension UIApplication {
    public var appBundleID: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String
    }
    
    public var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    public var appBuildVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
    
    public var appBundleName: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    
    public var displayName: String? {
        guard let dictionary = Bundle.main.localizedInfoDictionary else {
            return nil
        }
        return dictionary["CFBundleDisplayName"] as? String
    }
}

//
//  UIImage+utils.swift
//  Later
//
//  Created by tree on 2020/7/21.
//  Copyright © 2020 jiazifa. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func renderTintColor(_ color: UIColor) -> UIImage {
        if #available(iOS 13.0, *) {
            return withTintColor(color, renderingMode: .automatic)
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: size.height)
        context?.scaleBy(x: 1.0, y: -0.1)
        
        let rect = CGRect.init(origin: .zero, size: size)
        
        context?.setBlendMode(.normal)
        context?.draw(cgImage!, in: rect)
        
        context?.setBlendMode(.sourceIn)
        color.setFill()
        context?.fill(rect)
        
        let renderedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return renderedImage ?? self
    }
    
    func renderRoundRadius(radius: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect.init(origin: .zero, size: size)
        let bezierPath = UIBezierPath.init(roundedRect: rect, cornerRadius: radius)
        context?.addPath(bezierPath.cgPath)
        context?.clip()
        self.draw(in: rect)
        let renderImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return renderImage ?? self
    }
}

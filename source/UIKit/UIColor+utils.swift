//
//  UIColor+utils.swift
//  HuBeiECarSalerClient
//
//  Created by tree on 2018/12/21.
//  Copyright © 2018 tree. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    public class func randomColor() -> UIColor {
        let R = arc4random() % 256
        let B = arc4random() % 256
        let G = arc4random() % 256
        return UIColor.init(red: CGFloat(R)/255.0,
                            green: CGFloat(G)/255.0,
                            blue: CGFloat(B)/255.0,
                            alpha: 1.0)
    }
    
    public class func color(_ hex: String) -> UIColor {
        return self.color(hex, alpha: 1.0)
    }
    
    public class func color(_ hex: String, alpha: CGFloat) -> UIColor {
        var cleanString = hex.replacingOccurrences(of: "#", with: "")
        if cleanString.count == 3 {
            
            let startIndex = cleanString.startIndex
            
            func offsetBy(offset: Int) -> String.Index {
                return cleanString.index(startIndex, offsetBy: offset)
            }
            
            let first = String(cleanString.prefix(1))
            let second = cleanString.substring(with: Range.init(uncheckedBounds: (1, 2)))
            let third = cleanString.suffix(1)
            cleanString =  first + first + second + second + third + third
            
        } else if cleanString.count == 6 {
            
            cleanString = cleanString.appending("ff")
            
        }
        
        var baseValue: UInt32 = 0
        Scanner.init(string: cleanString).scanHexInt32(&baseValue)
        let red = CGFloat(((baseValue >> 24) & 0xFF))/255.0
        let green = CGFloat(((baseValue >> 16) & 0xFF))/255.0
        let blue = CGFloat(((baseValue >> 8) & 0xFF))/255.0
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// Color to Image
    func toImage(size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect:CGRect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        self.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image! // was image
    }
    
    /// SwifterSwift: https://github.com/SwifterSwift/SwifterSwift
    /// RGB components for a Color (between 0 and 255).
    ///
    ///        UIColor.red.rgbComponents.red -> 255
    ///        UIColor.green.rgbComponents.green -> 255
    ///        UIColor.blue.rgbComponents.blue -> 255
    ///
    public var rgbComponents: (red: Int, green: Int, blue: Int) {
        var components: [CGFloat] {
            let c = cgColor.components!
            if c.count == 4 {
                return c
            }
            return [c[0], c[0], c[0], c[1]]
        }
        let r = components[0]
        let g = components[1]
        let b = components[2]
        return (red: Int(r * 255.0), green: Int(g * 255.0), blue: Int(b * 255.0))
    }
    
    /// SwifterSwift: https://github.com/SwifterSwift/SwifterSwift
    /// RGB components for a Color represented as CGFloat numbers (between 0 and 1)
    ///
    ///        UIColor.red.rgbComponents.red -> 1.0
    ///        UIColor.green.rgbComponents.green -> 1.0
    ///        UIColor.blue.rgbComponents.blue -> 1.0
    ///
    public var cgFloatComponents: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var components: [CGFloat] {
            let c = cgColor.components!
            if c.count == 4 {
                return c
            }
            return [c[0], c[0], c[0], c[1]]
        }
        let r = components[0]
        let g = components[1]
        let b = components[2]
        return (red: r, green: g, blue: b)
    }
    
    /// SwifterSwift: https://github.com/SwifterSwift/SwifterSwift
    /// Get components of hue, saturation, and brightness, and alpha (read-only).
    public var hsbaComponents: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    /// Random color.
    public static var random: UIColor {
        let r = Int(arc4random_uniform(255))
        let g = Int(arc4random_uniform(255))
        let b = Int(arc4random_uniform(255))
        return UIColor(red: r, green: g, blue: b)
    }
}

// MARK: - Initializers
public extension UIColor {
    
    convenience init(hex: Int, alpha: CGFloat) {
        let r = CGFloat((hex & 0xFF0000) >> 16)/255
        let g = CGFloat((hex & 0xFF00) >> 8)/255
        let b = CGFloat(hex & 0xFF)/255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    /**
     Creates an UIColor from HEX String in "#363636" format
     
     - parameter hexString: HEX String in "#363636" format
     - returns: UIColor from HexString
     */
    convenience init(hexString: String) {
        
        let hexString: String       = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner                 = Scanner(string: hexString as String)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    /// Create UIColor from RGB values with optional transparency.
    ///
    /// - Parameters:
    ///   - red: red component.
    ///   - green: green component.
    ///   - blue: blue component.
    ///   - transparency: optional transparency value (default is 1)
    convenience init(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        var trans: CGFloat {
            if transparency > 1 {
                return 1
            } else if transparency < 0 {
                return 0
            } else {
                return transparency
            }
        }
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
}

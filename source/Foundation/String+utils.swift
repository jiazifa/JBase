//
//  String+utils.swift
//  HuBeiECarSalerClient
//
//  Created by tree on 2018/12/21.
//  Copyright © 2018 tree. All rights reserved.
//

import Foundation
import UIKit
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func md5Data() -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = self.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
    
    func md5() -> String {
        let data = self.md5Data()
        let hex = data.map { String(format: "%02hhx", $0) }.joined()
        return hex
    }
    
    func jwtDecode()->[String: Any] {
        /**分割为数组*/
        let segments = components(separatedBy: ".")
        /**获取第二个元素Payload负载元素(有意义的key就在里面解析的)*/
        var base64String = segments[1]
        /** base64解码*/
        let requiredLength = (4 * ceil((Float)(base64String.count)/4.0))
        let nbrPaddings = Int(requiredLength) - base64String.count
        if nbrPaddings > 0 {
            let pading = "".padding(toLength: nbrPaddings,withPad: "=",startingAt: 0)
            base64String = base64String + pading
        }
        base64String = base64String.replacingOccurrences(of: "-",with: "+")
        base64String = base64String.replacingOccurrences(of: "_",with: "/")
        let decodeData = Data(base64Encoded: base64String,options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
        let decodeString = String.init(data: decodeData!,encoding: String.Encoding.utf8)
        /**转为字典*/
        let jsonDict:[String : Any]? = try? JSONSerialization.jsonObject(with:(decodeString?.data(using: String.Encoding.utf8))!,options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any]
        /**返回jwt */
        return jsonDict ?? [:]
    }
}

extension String {
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? self
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? self
    }
}

extension String {
    func date(fromFormat: String = "yyyy-MM-dd HH:mm:ss", toFormat: String) -> String {
        let f = DateFormatter()
        f.dateFormat = fromFormat
        guard let date = f.date(from: self) else { return self}
        return date.string(formatString: toFormat)
    }
}

extension String {
    func size(font: UIFont, size: CGSize) -> CGSize {
        let attribute = NSAttributedString(string: self, attributes: [NSAttributedString.Key.font : font])
        let rect = attribute.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return rect.size
    }
    
    func width(font: UIFont, maxWidth: CGFloat) -> CGFloat {
        let size = self.size(font: font, size: CGSize(width: maxWidth, height: CGFloat(Int.max)))
        return ceil(size.width)
    }
    
    func height(font: UIFont, maxWidth: CGFloat) -> CGFloat {
        let size = self.size(font: font, size: CGSize(width: maxWidth, height: CGFloat(Int.max)))
        return ceil(size.height)
    }
}

extension NSAttributedString {
    func size(maxWidth: CGFloat) -> CGSize {
        let s = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = boundingRect(with: s, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return rect.size
    }
    
    func width() -> CGFloat {
        let s = size(maxWidth: CGFloat.greatestFiniteMagnitude)
        return ceil(s.width)
    }
    
    func height(maxWidth: CGFloat) -> CGFloat {
        let s = size(maxWidth: maxWidth)
        return ceil(s.height)
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
    
    var containsAlphabets: Bool {
        //Checks if all the characters inside the string are alphabets
        let set = CharacterSet.letters
        return self.utf16.contains {
            guard let unicode = UnicodeScalar($0) else { return false }
            return set.contains(unicode)
        }
    }
}

// MARK: - NSAttributedString extensions
public extension String {
    
    /// Regular string.
    var regular: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Bold string.
    var bold: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Underlined string
    var underline: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    /// Strikethrough string.
    var strikethrough: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
    }
    
    /// Italic string.
    var italic: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Add color to string.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    func colored(with color: UIColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
    }
}

extension Array where Element: NSAttributedString {
    func joined(separator: NSAttributedString) -> NSAttributedString {
        var isFirst = true
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if isFirst {
                isFirst = false
            } else {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }
    
    func joined(separator: String) -> NSAttributedString {
        return joined(separator: NSAttributedString(string: separator))
    }
}

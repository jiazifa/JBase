//
// Wire
// Copyright (C) 2018 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import Foundation
import UIKit
// MARK: - Avatar

extension UIFont {
    class var avatarInitial: UIFont {
        if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: 11, weight: .light)
        } else {
            return UIFont.systemFont(ofSize: 11)
        }
    }
}

// Objective-C compatiblity layer for the Swift only FontSpec

@objc
extension UIFont {

    // MARK: - Small 11 用户辅助信息

    class var smallRegularFont: UIFont {
        return UIFont.systemFont(ofSize: 11, weight: .regular)
    }
    
    class var smallBlodFont: UIFont {
        return UIFont.systemFont(ofSize: 11, weight: .bold)
    }
    // MARK: - Medium 14 大部分文字，正文内容
    
    class var mediumRegularFont: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .regular)
        
    }
    
    class var mediumBoldFont: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .bold)
        
    }
    
    // MARK: - Normal 16 用户二级标题

    class var normalRegularFont: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    class var normalBoldFont: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    // MARK: - Standard 18 用户一级标题， 重点文字
    class var standardRegularFont: UIFont {
        return UIFont.systemFont(ofSize: 18, weight: .regular)
    }
    
    class var standardBoldFont: UIFont {
        return UIFont.systemFont(ofSize: 18, weight: .bold)
    }

    // MARK: - Large 24
    class var largeRegularFont: UIFont {
        return UIFont.systemFont(ofSize: 24, weight: .regular)
    }

    class var largeBoldFont: UIFont {
        return UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    
}

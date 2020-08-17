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


@objc
extension UIFont {

    class func ultraLightFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .ultraLight)
    }


    class func thinFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .thin)
    }


    class func lightFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)
    }


    class func regularFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }


    class func mediumFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }


    class func semiboldFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }


    class func boldFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }


    class func heavyFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .heavy)
    }


    class func blackFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .black)
    }

}

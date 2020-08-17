//
//  HUD.swift
//  Later
//
//  Created by tree on 2020/4/13.
//  Copyright © 2020 jiazifa. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    
    private func getIndicator() -> UIActivityIndicatorView {
        var finalIndicator = self.view.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView
        if (finalIndicator == nil) {
            let indicator = UIActivityIndicatorView.init(style: .whiteLarge)
            indicator.color = UIColor.white
            indicator.backgroundColor = UIColor.gray
            indicator.layer.cornerRadius = 10
            indicator.clipsToBounds = true
            indicator.hidesWhenStopped = true
            view.addSubview(indicator)
            indicator.size = CGSize.init(width: 100, height: 100)
            indicator.center = view.center
            finalIndicator = indicator
        }
        return finalIndicator!
    }
    
    func startIndicator(_ content: String? = nil) {
        DispatchQueue.main.async {
            self.getIndicator().startAnimating()
        }
    }
    
    func stopIndicator() {
        DispatchQueue.main.async {
            self.getIndicator().stopAnimating()
        }
    }
}

final class _NotifyLabel: UILabel {}
public extension UIViewController {
    private func getToasLabel() -> UILabel {
        let label = _NotifyLabel.init()
        label.font = .normalRegularFont
        label.numberOfLines = 3
        label.textAlignment = .center
        
        if #available(iOS 13.0, *) {
            label.textColor = UIColor.darkText
            label.backgroundColor = UIColor.systemBackground
        } else {
            label.textColor = UIColor.black
            label.backgroundColor = UIColor.white
        }
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        return label
    }
    
    func toast(content: String) {
        guard let view = UIApplication.shared.keyWindow else { return }
        let label = getToasLabel()
        view.addSubview(label)
        label.text = content
        let size = content.size(font: label.font, size: self.view.bounds.size)
        label.size = CGSize.init(width: size.width + 30, height: size.height + 20)
        label.y = view.height - 100 - label.size.height
        label.x = view.width / 2.0 - label.size.width
        let second = min(ceil(0.3 + Double(content.count) * 0.1), 4)
        delayAtMain(second, closure: {
            label.removeFromSuperview()
        })
    }
}

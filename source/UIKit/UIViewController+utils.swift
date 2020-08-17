//
//  UIViewController+utils.swift
//  Later
//
//  Created by tree on 2020/4/12.
//  Copyright © 2020 jiazifa. All rights reserved.
//

import UIKit

extension UIViewController {
    /// add a child view controller to self and add its view as view paramenter's subview
    ///
    /// - Parameters:
    ///   - viewController: the view controller to add
    ///   - view: the viewController parameter's view will be added to this view
    @objc(addViewController:toView:)
    func add(_ viewController: UIViewController?, to view: UIView) {
        guard let viewController = viewController else { return }

        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }

    /// Add a view controller as self's child viewController and add its view as self's subview
    ///
    /// - Parameter viewController: viewController to add
    func addToSelf(_ viewController: UIViewController) {
        add(viewController, to: self.view)
    }
}

protocol StoryBoardable {}

extension StoryBoardable where Self: UIViewController {
    static func loadFromStoryboard<T: UIViewController>(name: String) -> T {
        let storyboard = UIStoryboard.init(name: name, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "\(self)") as? T else { fatalError() }
        return viewController
    }
}


extension UIViewController {
    @objc(alertWithMessage:OkString:OkAction:)
    func alert(message: String, okString: String, okAction: ((UIAlertAction)->())?) {
        alertConfirm(title: nil,
                     message: message,
                     cancelString: nil,
                     okString: okString,
                     cancelAction: nil,
                     okAction: okAction)
    }
    
    @discardableResult
    @objc(alertWithTitle:Message:CancelString:OkString:CancelBlock:OkBlock:)
    func alertConfirm(title: String?, message: String?, cancelString: String?, okString: String?, cancelAction: ((UIAlertAction)->())?, okAction: ((UIAlertAction)->())?) -> UIAlertController? {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let cancel = cancelString {
            alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: { (action) in
                cancelAction?(action)
            }))
        }
        
        if let ok = okString {
            alert.addAction(UIAlertAction(title: ok, style: .default, handler: { (action) -> Void in
                okAction?(action)
            }))
        }
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    @discardableResult
    func alertInput(title: String?,
                    text: String?,
                    placeholder: String?,
                    keyboardType: UIKeyboardType = .default,
                    cancelString: String?,
                    okString: String?,
                    cancelAction: ((UIAlertAction)->())?,
                    okAction: ((String?)->())?) -> UIAlertController? {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = text
            textField.placeholder = placeholder
            textField.keyboardType = keyboardType
        }
        alert.addAction(UIAlertAction(title: okString, style: .default, handler: { (_) -> Void in
            if let textField = alert.textFields?.first {
                okAction?(textField.text)
            }
        }))
        alert.addAction(UIAlertAction(title: cancelString, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        return alert
    }
    
}

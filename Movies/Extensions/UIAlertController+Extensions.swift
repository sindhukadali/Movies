//
//  UIAlertController+Extensions.swift
//  Movies
//
//  Created by Sindhu on 01/06/22.
//

import UIKit

extension UIAlertController {
    class func showAlert(
        from viewController: UIViewController?,
        title: String?, msg: String?) {

        guard let viewController = viewController else { return }

        let okAction = UIAlertAction(
            title: "Ok",
            style: .default)

        let alertController = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .alert)

        alertController.addAction(okAction)

        viewController.present(alertController, animated: true)
    }
}


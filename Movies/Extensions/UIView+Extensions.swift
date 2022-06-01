//
//  UIView+Extensions.swift
//  Movies
//
//  Created by Sindhu on 01/06/22.
//

import UIKit

extension UIView {
    func disableAutoResize() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}

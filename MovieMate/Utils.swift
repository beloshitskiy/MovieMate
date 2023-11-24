//
//  Utils.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 12.11.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }

    func roundCorners(radius: CGFloat, corners: UIRectCorner = .allCorners) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: .init(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    func roundCorners() {
        roundCorners(radius: bounds.height / 2.0)
    }
}

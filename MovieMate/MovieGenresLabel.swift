//
//  MovieGenresLabel.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 03.12.2023.
//

import UIKit

final class MovieGenresLabel: UILabel {
    func setup(with viewModel: MovieCardViewModel) {
        let attrStr = NSMutableAttributedString()

        let attrs: [NSAttributedString.Key : Any]

        if #available(iOS 16.0, *) {
            attrs = [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 17, weight: .medium, width: .expanded),
            ]
        } else {
            attrs = [
                .foregroundColor: UIColor.white,
                .font: UIFont.boldSystemFont(ofSize: 17),
            ]
        }

        let divider = NSAttributedString(string: " • ", attributes: attrs)

        viewModel.genres.forEach { genre in
            attrStr.append(NSAttributedString(string: genre, attributes: attrs))
            attrStr.append(divider)
        }

        attrStr.deleteCharacters(in: NSRange(location: attrStr.length - 3, length: 3))

        self.attributedText = attrStr
    }
}

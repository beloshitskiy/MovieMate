//
//  MovieRatingView.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 24.11.2023.
//

import UIKit

final class MovieRatingView: UIView {
    var ratings: [Rating]? {
        didSet {
            updateStack()
        }
    }

    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stackView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateStack() {
        stackView.arrangedSubviews.forEach { stackView.removeArrangedSubview($0) }

        let segments = ratings?.map { MovieRatingSegment(rating: $0) }
        segments?.forEach { stackView.addArrangedSubview($0) }
    }
}

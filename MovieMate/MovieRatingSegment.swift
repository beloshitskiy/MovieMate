//
//  MovieRatingSegment.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 24.11.2023.
//

import SnapKit
import UIKit

final class MovieRatingSegment: UIView {
    private let rating: Rating

    private let ratingLabel = UILabel()
    private let providerLabel = UILabel()

    init(rating: Rating) {
        self.rating = rating
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MovieRatingSegment {
    // MARK: - Setup UI

    func setupUI() {
        self.addSubviews([
            ratingLabel,
            providerLabel,
        ])

        setupConstraints()

        ratingLabel.text = rating.rating
        ratingLabel.font = .preferredFont(forTextStyle: .footnote) // add bold
        ratingLabel.textColor = Color.main

        providerLabel.text = rating.provider
        providerLabel.font = .preferredFont(forTextStyle: .footnote)
        providerLabel.textColor = Color.secondary
    }

    func setupConstraints() {
        ratingLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(providerLabel.snp.top).inset(kLabelInset)
        }

        providerLabel.snp.makeConstraints { $0.horizontalEdges.bottom.equalToSuperview() }
    }
}

private let kLabelInset: CGFloat = 5.0

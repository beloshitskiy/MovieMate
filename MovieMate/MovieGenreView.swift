//
//  MovieGenreView.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 24.11.2023.
//

import UIKit

final class MovieGenreView: UIView {
    var genres: [Genre]? {
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

    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners()
    }
}

private extension MovieGenreView {
    func updateStack() {
        stackView.arrangedSubviews.forEach { stackView.removeArrangedSubview($0) }

        let pills = genres?.map { makePill(genre: $0) }
        pills?.forEach { stackView.addArrangedSubview($0) }
    }

    func makePill(genre: Genre) -> UILabel {
        let label = UILabel()
        label.text = genre.name
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = Color.main
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1.0
        label.backgroundColor = Color.surface
        return label
    }
}

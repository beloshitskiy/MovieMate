//
//  MovieDurationView.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 24.11.2023.
//

import SnapKit
import UIKit

final class MovieDurationView: UIView {
    var duration: String?

    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    private let imageView = UIImageView(image: UIImage(systemName: "clock"))
    private let durationLabel = UILabel()

    // MARK: - Overrides

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners(radius: LayoutConfig.cornerRadius)
    }
}

private extension MovieDurationView {
    // MARK: - Setup UI

    func setupUI() {
        self.clipsToBounds = true

        self.addSubviews([
            blurView,
            imageView,
            durationLabel,
        ])

        setupConstraints()

        setupLengthLabel()
    }

    func setupConstraints() {
        blurView.snp.makeConstraints { $0.edges.equalToSuperview() }

        imageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(LayoutConfig.horizontalInset)
            make.trailing.equalTo(durationLabel.snp.leading).offset(LayoutConfig.horizontalInset)
        }

        durationLabel.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview().inset(LayoutConfig.horizontalInset)
        }
    }

    func setupLengthLabel() {
        durationLabel.text = duration
        durationLabel.textColor = .white
        durationLabel.font = .preferredFont(forTextStyle: .footnote)
    }

    // MARK: - Layout config

    enum LayoutConfig {
        static let cornerRadius: CGFloat = 50.0
        static let horizontalInset: CGFloat = 5.0
    }
}

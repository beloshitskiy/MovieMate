//
//  BlurredButton.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 24.11.2023.
//

import HandlersKit
import SnapKit
import UIKit

final class BlurredButton: UIView {
    var onTap: (() -> Void)?
    var image: UIImage?

    private let button = UIButton()
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))

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
        self.roundCorners()
    }
}

private extension BlurredButton {
    // MARK: - Setup UI

    func setupUI() {
        self.clipsToBounds = true

        self.addSubviews([
            blurView,
            button,
        ])

        setupConstraints()

        setupButton()
    }

    func setupConstraints() {
        blurView.snp.makeConstraints { $0.edges.equalToSuperview() }
        button.snp.makeConstraints { $0.edges.equalToSuperview().inset(LayoutConfig.buttonInset) }
    }

    func setupButton() {
        var configuration = UIButton.Configuration.plain()
        configuration.image = image
        configuration.imagePlacement = .all

        button.configuration = configuration
    }

    // MARK: - Layout config

    enum LayoutConfig {
        static let buttonInset: CGFloat = 5.0
    }
}

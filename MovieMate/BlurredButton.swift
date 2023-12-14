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
    var image: UIImage? {
        didSet {
            button.setImage(image, for: .normal)
        }
    }

    private let button = UIButton(configuration: .plain())
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))

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

    private func setupUI() {
        self.clipsToBounds = true

        self.addSubviews([
            blurView,
            button,
        ])

        button.tintColor = .white

        blurView.snp.makeConstraints { $0.edges.equalToSuperview() }
        button.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

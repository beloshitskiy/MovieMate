//
//  MovieActionsView.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 02.12.2023.
//

import HandlersKit
import SnapKit
import UIKit

final class MovieActionsView: UIView {
    var onLikeTap: (() -> Void)?
    var onDislikeTap: (() -> Void)?

    private let dislikeButton = UIButton(configuration: .filled())
    private let likeButton = UIButton(configuration: .filled())

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
        dislikeButton.roundCorners()
        likeButton.roundCorners()
    }
}

private extension MovieActionsView {

    // MARK: - Setup UI

    func setupUI() {
        self.addSubviews([
            dislikeButton,
            likeButton,
        ])
        setupConstraints()

        setupButtons()
    }

    func setupConstraints() {
        dislikeButton.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
            make.size.equalTo(LayoutConfig.buttonSize)
        }

        likeButton.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(dislikeButton.snp.trailing)
            make.trailing.verticalEdges.equalToSuperview()
            make.size.equalTo(LayoutConfig.buttonSize)
        }
    }

    func setupButtons() {
        likeButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        dislikeButton.setImage(UIImage(systemName: "xmark"), for: .normal)

        likeButton.tintColor = .systemGreen
        dislikeButton.tintColor = .systemRed

        likeButton.onTap { [weak self] in self?.onLikeTap?() }
        dislikeButton.onTap { [weak self] in self?.onDislikeTap?() }
    }

    enum LayoutConfig {
        static let buttonSize = CGSize(width: 100.0, height: 60.0)
    }
}

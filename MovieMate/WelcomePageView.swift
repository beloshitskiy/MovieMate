//
//  WelcomePageView.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 12.11.2023.
//

import HandlersKit
import SnapKit
import UIKit

final class WelcomePageView: UIView {
    private var viewModel: WelcomePageViewModel?

    private let createLobbyButton = UIButton()
    private let joinLobbyButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: WelcomePageViewModel) {
        guard self.viewModel == nil else { return }
        self.viewModel = viewModel
    }
}

private extension WelcomePageView {
    // MARK: - Setup UI

    func setupUI() {
        setupConstraints()

        setupCreateLobbyButton()
        setupJoinLobbyButton()
    }

    func setupConstraints() {}

    func setupCreateLobbyButton() {
        createLobbyButton.onTap { [weak viewModel] in
            viewModel?.moveToCreateLobbyPage()
        }
    }

    func setupJoinLobbyButton() {
        joinLobbyButton.onTap { [weak viewModel] in
            viewModel?.moveToJoinLobbyPage()
        }
    }

    // MARK: - Layout config

    enum LayoutConfig {}
}

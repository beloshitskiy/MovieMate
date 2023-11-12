//
//  LobbyPageView.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 30.10.2023.
//

import HandlersKit
import SnapKit
import UIKit

final class LobbyPageView: UIView {
    private var viewModel: LobbyPageViewModel?

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
}

private extension LobbyPageView {
    // MARK: - Setup UI

    func setupUI() {
        setupCreateLobbyButton()
        setupJoinLobbyButton()

        setupContraints()
    }

    func setupContraints() {
        
    }

    func setupCreateLobbyButton() {
        createLobbyButton.onTap {
            Router.shared.navigate(to: .createLobbyPage)
        }
    }

    func setupJoinLobbyButton() {
        joinLobbyButton.onTap {
            Router.shared.navigate(to: .joinLobbyPage)
        }
    }


    // MARK: - Layout config

    enum LayoutConfig {

    }
}

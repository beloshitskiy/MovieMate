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

    private let headerLabel = UILabel()
    private lazy var textField = UITextField()

    private let continueButton = UIButton()

    func configure(with viewModel: LobbyPageViewModel) {
        guard self.viewModel == nil else { return }
        self.viewModel = viewModel
        configureLobby()
    }
}

private extension LobbyPageView {
    // MARK: - Setup UI

    func configureLobby() {
        configureHierarchy()
        configureUI()
    }

    func configureHierarchy() {
        guard let action = viewModel?.action else { return }

        self.addSubviews([
            headerLabel,
            continueButton,
        ])

        if action == .join {
            self.addSubview(textField)
        }
    }

    func configureUI() {
        guard let viewModel else { return }

        headerLabel.text = viewModel.headerText
        continueButton.setTitle(viewModel.continueButtonTitle, for: .normal)

        continueButton.isEnabled = viewModel.canStart

        if viewModel.action == .join {
            textField.placeholder = viewModel.textFieldPlaceholder
            continueButton.onTap { [weak self] in
                guard let self else { return }
                self.viewModel?.joinLobby(lobbyId: self.textField.text ?? "")
            }
        } else {
            continueButton.onTap { [weak viewModel] in
                viewModel?.createLobby()
            }
        }
    }

    // MARK: - Layout config

    enum LayoutConfig {}
}

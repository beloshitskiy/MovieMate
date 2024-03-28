//
//  LobbyPageViewController.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 30.10.2023.
//

import SnapKit
import UIKit

final class LobbyPageViewController: UIViewController {
    let lobbyView = LobbyPageView()
    let viewModel: LobbyPageViewModel

    init(with viewModel: LobbyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.vc = self
        lobbyView.configure(with: viewModel)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lobbyView)
        lobbyView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if isMovingFromParent {
            viewModel.cancelRoomCreation()
        }
    }
}

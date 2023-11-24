//
//  LobbyPageViewController.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 30.10.2023.
//

import UIKit
import SnapKit

final class LobbyPageViewController: UIViewController {
    private let lobbyView = LobbyPageView()
    private let viewModel: LobbyPageViewModel

    init(with viewModel: LobbyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        lobbyView.configure(with: viewModel)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lobbyView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        if viewModel.action == .create {
//            do {
//                try viewModel.createLobby()
//            } catch {
//                guard let errorInfo = (error as? ApiError)?.errorInfo else { return }
//                AlertController.showAlert(vc: self, errorInfo: errorInfo)
//            }
//        }
    }
}

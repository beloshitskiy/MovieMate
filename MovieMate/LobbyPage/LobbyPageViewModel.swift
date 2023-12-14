//
//  LobbyPageViewModel.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 30.10.2023.
//

import Foundation
import UIKit

final class LobbyPageViewModel {
    enum LobbyAction {
        case create
        case join
    }

    weak var vc: UIViewController?

    let action: LobbyAction
    let headerText: String
    let continueButtonTitle: String

    @Published
    private(set) var roomID: String?
    private(set) var textFieldPlaceholder: String?

    init(action: LobbyAction) {
        self.action = action

        switch action {
        case .create:
            headerText = "Ваш Lobby ID"
            continueButtonTitle = "Начать игру!"
        case .join:
            headerText = "Введите Lobby ID"
            continueButtonTitle = "Присоединиться"
            textFieldPlaceholder = "Ваш Lobby ID"
        }

        createLobbyIfNeeded()
    }

    func createLobbyIfNeeded() {
        guard action == .create else { return }
        Task {
            do {
                roomID = try await ApiClient.shared.createLobby().uppercased()
            } catch {
                await AlertController.showAlert(vc: vc, error: error)
            }
        }
    }

    func joinLobby(lobbyId: String) {
        guard action == .join else { return }
        Task {
            do {
                try await ApiClient.shared.joinLobby(lobbyId: lobbyId)
                // redirect to waiting room (???)
            } catch {
                await AlertController.showAlert(vc: vc, error: error)
            }
        }
    }

    @MainActor func cancelRoomCreation() {
        guard action == .create else { return }
        Task {
            try? await ApiClient.shared.deleteLobby()
        }
        Router.shared.navigateBack(in: vc?.navigationController)
    }

    func startLobby() {
        guard action == .create else { return }
        Task {
            do {
                if try await ApiClient.shared.startLobby() {
                    await Router.shared.navigate(in: vc?.navigationController, to: .genresChoosingPage, makeRoot: true)
                }
            } catch {
                await AlertController.showAlert(vc: vc, error: error)
            }
        }
    }

    func canContinue(_ str: String) -> Bool {
        action == .create && ApiClient.shared.lobbyInfo?.appState == .readyToStart || action == .join && !str.isEmpty
    }
}

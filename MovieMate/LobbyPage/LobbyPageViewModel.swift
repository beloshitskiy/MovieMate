//
//  LobbyPageViewModel.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 30.10.2023.
//

import Foundation

final class LobbyPageViewModel {
    enum LobbyAction {
        case create
        case join
    }

    let action: LobbyAction

    let headerText: String
    let continueButtonTitle: String
    private(set) var roomID: String?
    private(set) var textFieldPlaceholder: String?

    private let apiClient = ApiClient.shared

    init(action: LobbyAction) {
        self.action = action

        switch action {
        case .create: 
            headerText = "Ваш Lobby ID"
            roomID = "3QEY7O" // fetch
            continueButtonTitle = "Начать игру!"
        case .join:
            headerText = "Введите Lobby ID"
            continueButtonTitle = "Присоединиться"
            textFieldPlaceholder = "Ваш Lobby ID"
        }
    }

    func canContinue(_ str: String) -> Bool {
        action == .create && AppState.currentState == .readyToStart || action == .join && !str.isEmpty
    }

    func createLobby() {
        // либо делать attibuted string, либо еще один label

//        let lobbyId = try await apiClient.createLobby()
//        headerText.append(lobbyId)
    }

    func joinLobby(lobbyId: String) {
//        try await apiClient.joinLobby(lobbyId: lobbyId)
    }

    func cancelRoomCreation() {
        guard action == .create else { return }
    }
}

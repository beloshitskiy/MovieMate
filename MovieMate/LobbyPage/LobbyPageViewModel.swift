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

    // паблишер, который раз в n секунд обращается к серверу, получает ответ и обновляет значение
    private(set) var canStart = false

    let action: LobbyAction

    private(set) var headerText: String
    let continueButtonTitle: String
    let textFieldPlaceholder: String?

    private let apiClient = ApiClient.shared

    init(action: LobbyAction) {
        self.action = action

        switch action {
        case .create: 
            headerText = "Ваш Lobby ID"
            continueButtonTitle = "Начать игру!"
            textFieldPlaceholder = nil
        case .join:
            headerText = "Введите Lobby ID"
            continueButtonTitle = "Присоединиться"
            textFieldPlaceholder = "Ваш Lobby ID"
        }
    }

    func createLobby() {
        // либо делать attibuted string, либо еще один label

//        let lobbyId = try await apiClient.createLobby()
//        headerText.append(lobbyId)
    }

    func joinLobby(lobbyId: String) {
//        try await apiClient.joinLobby(lobbyId: lobbyId)
    }
}

//
//  Page.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 12.11.2023.
//

import UIKit

enum Page {
    case welcomePage
    case createLobbyPage(LobbyPageViewModel)
    case joinLobbyPage(LobbyPageViewModel)
    case genresChoosingPage
    case deckPage
    case goodResultPage
    case badResultPage
}

extension Page {
    func vc() -> UIViewController {
        switch self {
        case .welcomePage:
            return WelcomePageViewController()

        case let .createLobbyPage(vm), let .joinLobbyPage(vm):
            return LobbyPageViewController(with: vm)

        case .genresChoosingPage:
            return GenrePageViewController()


        default:
            return UIViewController()
        }
    }
}

//
//  DeckPageViewController.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 30.10.2023.
//

import Combine
import Shuffle_iOS
import SnapKit
import UIKit

final class DeckPageViewController: UIViewController {
    private let deckView = SwipeCardStack()
    private let dataSource = DeckPageDataSource()
    private var cancellables: Set<AnyCancellable> = []

    init() {
        super.init(nibName: nil, bundle: nil)
        dataSource.stack = deckView
        dataSource.vc = self
        deckView.dataSource = dataSource
        deckView.delegate = self

        dataSource.$movies
            .sink { [weak self] _ in
                self?.deckView.reloadData()
            }.store(in: &cancellables)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(deckView)
        deckView.cardStackInsets = .zero
        deckView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

extension DeckPageViewController: SwipeCardStackDelegate {
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        guard let movie = dataSource.movies[safe: index], direction == .right else { return }
        Task {
            await ApiClient.shared.like(movie: movie)
        }
    }

    func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
        guard let movie = dataSource.movies[safe: index], direction == .right else { return }
        Task {
            await ApiClient.shared.undoLike(movie: movie)
        }
    }

    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        ApiClient.shared.$lobbyInfo
            .receive(on: DispatchQueue.main)
            .filter { $0?.appState == .finished }
            .sink { info in
                Router.shared.navigate(from: self, to: info?.matchedMovie != nil ? .goodResultPage : .badResultPage)
                // remove subscription 🤔
            }.store(in: &cancellables)
    }
}

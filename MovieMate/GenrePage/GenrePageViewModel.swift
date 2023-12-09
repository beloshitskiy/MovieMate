//
//  GenrePageViewModel.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 30.10.2023.
//

import Combine
import Foundation
import UIKit

final class GenrePageViewModel: NSObject {
    private var genres: [Genre] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map { Genre(title: "\($0)") }
    @Published private(set) var selectedPaths: [IndexPath] = []

//    override init() {
//        super.init()
//    }

    func chooseGenreRandomly() {
        guard let random = genres.randomElement() else { return }
        ApiClient.shared.confirmSelected([random])
    }

    func confirmSelected(_ tableView: UITableView) {
        let genres: [Genre] = selectedPaths.compactMap {
            (tableView.cellForRow(at: $0) as? GenreCell)?.genre
        }

        ApiClient.shared.confirmSelected(genres)
    }
}

extension GenrePageViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? GenreCell else { return }

        if !cell.isChosen {
            selectedPaths.append(indexPath)
        } else {
            selectedPaths.removeAll { $0 == indexPath }
        }

        cell.isChosen.toggle()
    }
}

extension GenrePageViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let genre = genres[safe: indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withClass: GenreCell.self, for: indexPath)
        cell.configure(with: genre)
        return cell
    }
}

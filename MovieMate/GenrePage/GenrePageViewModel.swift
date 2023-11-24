//
//  GenrePageViewModel.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 30.10.2023.
//

import Foundation
import UIKit

final class GenrePageViewModel {
    let genres: [Genre]

    private var chosenGenres: Set<Genre> = []

    weak var vc: (UIViewController & UITableViewDelegate & UITableViewDataSource)?

    private let apiClient = ApiClient.shared

    init() {
        genres = apiClient.getGenres()
    }

    func confirmChosenGenres() {
        apiClient.confirmChosen(genres: chosenGenres)
    }

}

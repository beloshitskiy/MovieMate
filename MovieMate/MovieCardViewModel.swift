//
//  MovieCardViewModel.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 24.11.2023.
//

import UIKit

final class MovieCardViewModel {
    static var onLikeTap: (() -> Void)?
    static var onDislikeTap: (() -> Void)?
    static var onUndoTap: (() -> Void)?

    let title: String
    let description: String
    let posterURL: URL?
    let rating: String
    let releaseYear: Int
    let duration: String
    let genres: [String]

    let canUndo: Bool
    let undoImage: UIImage?

    init(with movie: Movie) {
        title = movie.name
        description = movie.description
        posterURL = movie.posterURL
        rating = movie.rating
        releaseYear = movie.releaseYear
        duration = movie.duration
        genres = movie.genres

        undoImage = UIImage(systemName: "arrow.uturn.backward.circle")
        canUndo = true
    }
}

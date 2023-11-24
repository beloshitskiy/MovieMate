//
//  MovieCardViewModel.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 24.11.2023.
//

import UIKit

final class MovieCardViewModel {
    let title: String
    let description: String
    let posterImage: UIImage?
    let rating: Double
    let releaseYear: Int
    let duration: String
    let genres: [Genre]

    let canUndo: Bool
    let undoImage: UIImage?

    private let imageManager = ImageManager.shared

    init(with movie: Movie) {
        title = movie.name
        description = movie.description
        posterImage = imageManager.loadImage(url: movie.posterURL) // ?? placeholder
        rating = movie.rating
        releaseYear = movie.releaseYear
        duration = movie.duration
        genres = movie.genres

        undoImage = UIImage(systemName: "arrow.uturn.backward.circle")
        canUndo = false
    }


}

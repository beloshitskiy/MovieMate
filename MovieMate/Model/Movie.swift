//
//  Movie.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 30.10.2023.
//

import Foundation

struct Rating: Decodable {
    let provider: String
    let rating: String
}

struct Genre: Hashable, Decodable {
    let name: String
}

struct Movie {
    let id: UUID // or str
    let name: String
    let description: String
    let posterURL: URL?
    let releaseYear: Int
    let duration: String
    let genres: [Genre]
    let ratings: [Rating]
}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case posterURL = "poster_url"
        case releaseYear = "release_year"
        case duration
        case genres
        case ratings
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        posterURL = URL(string: try container.decode(String.self, forKey: .posterURL))
        releaseYear = try container.decode(Int.self, forKey: .releaseYear)
        duration = try container.decode(String.self, forKey: .duration)
        genres = try container.decode([Genre].self, forKey: .genres)
        ratings = try container.decode([Rating].self, forKey: .ratings)
    }
}

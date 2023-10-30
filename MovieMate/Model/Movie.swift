//
//  Movie.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 30.10.2023.
//

import Foundation

struct Movie {
    let id: UUID // or str
    let name: String
    let description: String
    let posterURL: URL?
    let rating: Double
    let releaseYear: Int
    let duration: Int // а duration в чем меряем
}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case posterURL = "poster_url"
        case rating = "rating_kp"
        case releaseYear = "release_year"
        case duration
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        posterURL = URL(string: try container.decode(String.self, forKey: .posterURL))
        rating = try container.decode(Double.self, forKey: .rating)
        releaseYear = try container.decode(Int.self, forKey: .releaseYear)
        duration = try container.decode(Int.self, forKey: .duration)
    }
}

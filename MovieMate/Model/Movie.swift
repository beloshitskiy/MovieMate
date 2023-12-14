//
//  Movie.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 30.10.2023.
//

import Foundation

struct Movie {
    let id: String
    let name: String
    let description: String
    let posterURL: URL?
    let releaseYear: Int
    let duration: String
    let genres: [String]
    let rating: String
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
        case rating
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        posterURL = URL(string: try container.decode(String.self, forKey: .posterURL))
        releaseYear = try container.decode(Int.self, forKey: .releaseYear)

        let durationInMinutes = try container.decode(TimeInterval.self, forKey: .duration) * 60
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        formatter.allowedUnits = [.hour, .minute]
        duration = formatter.string(from: durationInMinutes) ?? ""

        genres = try container.decode([String].self, forKey: .genres)
        rating = try container.decode(String.self, forKey: .rating)
    }
}

extension Movie {
    static let mock = Movie(id: "",
                            name: "Драйв",
                            description: "Великолепный водитель – при свете дня он выполняет каскадерские трюки на съёмочных площадках Голливуда, а по ночам ведет рискованную игру. Но один опасный контракт – и за его жизнь назначена награда. Теперь, чтобы остаться в живых и спасти свою очаровательную соседку, он должен делать то, что умеет лучше всего – виртуозно уходить от погони.",
                            posterURL: URL(string: "https://avatars.mds.yandex.net/get-kinopoisk-image/1773646/921089d1-4ebd-4b6f-be74-bfe29b21fad1/orig")!,
                            releaseYear: 2011,
                            duration: "1ч 40 мин",
                            genres: ["криминал", "драма", "триллер"],
                            rating: "7.8")
}

//
//  MovieGenresLabelTests.swift
//  MovieMateTests
//
//  Created by denis.beloshitsky on 15.02.2024.
//

import XCTest
import YYText
@testable import MovieMate

final class MovieGenresLabelTests: XCTestCase {
    private let viewModel = MovieCardViewModel(with: Movie.mock, canUndo: true)

    func testLabelSetup() {
        let given = MovieGenresLabel()
        given.setup(with: viewModel)

        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 17, weight: .medium, width: .expanded),
        ]

        let expected = NSAttributedString(string: "криминал • драма", attributes: attrs)

        XCTAssertNotNil(given.attributedText, "got attributed text nil")
        XCTAssertEqual(given.attributedText, expected)
    }
}

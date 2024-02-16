//
//  MovieInfoLabelTests.swift
//  MovieMateTests
//
//  Created by denis.beloshitsky on 15.02.2024.
//

import XCTest
import YYText
@testable import MovieMate

final class MovieInfoLabelTests: XCTestCase {
    private let viewModel = MovieCardViewModel(with: Movie.mock, canUndo: true)

    func testLabelSetup() {
        let given = MovieInfoLabel()
        given.setup(with: viewModel)

        let ratingAttrs: [NSAttributedString.Key : Any] = [
                .foregroundColor: UIColor(hex: 0xEFC944),
                .font: UIFont.systemFont(ofSize: 17, weight: .heavy, width: .expanded),
        ]

        let expected = NSMutableAttributedString(string: "7.8", attributes: ratingAttrs)

        let dividerAttrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 17, weight: .heavy, width: .expanded),
        ]

        let tailStr = NSAttributedString(string: " • 2011 • 1 ч 40 мин", attributes: dividerAttrs)
        expected.append(tailStr)

        let attrText = try! XCTUnwrap(given.attributedText)

        let substr = attrText.attributedSubstring(from: .init(location: 10,
                                                              length: attrText.length - 10))

        XCTAssertNotNil(given.attributedText, "got attributed text nil")
        XCTAssertEqual(substr, expected)
        XCTAssertEqual(given.textVerticalAlignment, .bottom)
    }
}

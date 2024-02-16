//
//  MovieActionsViewTests.swift
//  MovieMateTests
//
//  Created by denis.beloshitsky on 15.02.2024.
//

import XCTest
@testable import MovieMate

final class MovieActionsViewTests: XCTestCase {
    private let actionsView = MovieActionsView()

    override func setUp() {
        actionsView.onLikeTap = {}
        actionsView.onDislikeTap = {}
    }

    func testSetupHierarchy() {
        XCTAssertTrue(actionsView.subviews.count == 2)
    }

    func testSetupLikeButton() {
        let expected = UIButton(configuration: .filled())

        var conf = UIButton.Configuration.filled()

        conf.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 17, weight: .bold, width: .expanded)
            return outgoing
        }

        expected.configuration = conf

        expected.tintColor = UIColor(hex: 0x00C726)
        expected.setTitle("Нравится", for: .normal)
        expected.setTitleColor(.white, for: .normal)

        XCTAssertEqual(actionsView.likeButton.title(for: .normal),
                       expected.title(for: .normal))
        XCTAssertEqual(actionsView.likeButton.tintColor,
                       expected.tintColor)
        XCTAssertEqual(actionsView.likeButton.titleLabel?.font,
                       expected.titleLabel?.font)
        XCTAssertEqual(actionsView.likeButton.titleColor(for: .normal),
                       expected.titleColor(for: .normal))
        XCTAssertNotNil(actionsView.onLikeTap)
    }

    func testSetupDislikeButton() {
        let expected = UIButton(configuration: .filled())

        var conf = UIButton.Configuration.filled()

        conf.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 17, weight: .bold, width: .expanded)
            return outgoing
        }

        expected.configuration = conf

        expected.tintColor = UIColor(hex: 0xC71927)
        expected.setTitle("Не нравится", for: .normal)
        expected.setTitleColor(.white, for: .normal)

        XCTAssertEqual(actionsView.dislikeButton.title(for: .normal),
                       expected.title(for: .normal))
        XCTAssertEqual(actionsView.dislikeButton.tintColor,
                       expected.tintColor)
        XCTAssertEqual(actionsView.dislikeButton.titleLabel?.font,
                       expected.titleLabel?.font)
        XCTAssertEqual(actionsView.dislikeButton.titleColor(for: .normal),
                       expected.titleColor(for: .normal))
        XCTAssertNotNil(actionsView.onDislikeTap)
    }
}

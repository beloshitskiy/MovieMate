//
//  MovieCardViewTests.swift
//  MovieMateTests
//
//  Created by denis.beloshitsky on 16.02.2024.
//

import XCTest
@testable import MovieMate

final class MovieCardViewTests: XCTestCase {
    private let cardView = MovieCardView()
    private let viewModel = MovieCardViewModel(with: Movie.mock, canUndo: true)

    override func setUp() {
        MovieCardViewModel.onLikeTap = {}
        MovieCardViewModel.onDislikeTap = {}
        MovieCardViewModel.onUndoTap = {}
        cardView.configure(with: viewModel)
    }

    func testSetupHierarchy() {
        XCTAssertTrue(cardView.subviews.count == 6)
        XCTAssertTrue(cardView.substrateView.subviews.count == 4)
    }

    func testSetupTitle() {
        let expected = UILabel()

        expected.text = "Драйв"
        expected.textColor = .white
        expected.font = UIFont.systemFont(ofSize: 30, weight: .black, width: .expanded)
        expected.numberOfLines = 2

        XCTAssertEqual(cardView.titleLabel.text, expected.text)
        XCTAssertEqual(cardView.titleLabel.font, expected.font)
        XCTAssertEqual(cardView.titleLabel.textColor, expected.textColor)
        XCTAssertEqual(cardView.titleLabel.numberOfLines, expected.numberOfLines)
    }

    func testSetupDescriptionButton() {
        let expected = UIButton()

        var moreConf = UIButton.Configuration.filled()
        moreConf.title = "Подробнее о фильме"
        moreConf.titleAlignment = .leading

        moreConf.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 20, weight: .medium, width: .expanded)
            return outgoing
        }

        expected.configuration = moreConf

        expected.tintColor = UIColor(hex: 0xFF7E24)
        expected.setTitleColor(.white, for: .normal)

        XCTAssertEqual(cardView.descriptionButton.title(for: .normal),
                       expected.title(for: .normal))
        XCTAssertEqual(cardView.descriptionButton.tintColor,
                       expected.tintColor)
        XCTAssertEqual(cardView.descriptionButton.titleColor(for: .normal),
                       expected.titleColor(for: .normal))
    }

    func testSetupUndoButton() {
        let expected = UIButton()
        var conf = UIButton.Configuration.filled()
        conf.imagePlacement = .all

        expected.configuration = conf
        expected.tintColor = .black

        XCTAssertNotNil(cardView.undoButton.imageView)
        XCTAssertEqual(cardView.undoButton.configuration?.imagePlacement,
                       expected.configuration?.imagePlacement)
        XCTAssertEqual(cardView.undoButton.tintColor, expected.tintColor)
        XCTAssertFalse(cardView.undoButton.isHidden)
    }

    func testSetupActionsView() {
        XCTAssertNotNil(cardView.actionsView.onLikeTap)
        XCTAssertNotNil(cardView.actionsView.onDislikeTap)
    }
}

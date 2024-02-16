//
//  GoodResultPageTests.swift
//  MovieMateTests
//
//  Created by denis.beloshitsky on 16.02.2024.
//

import XCTest
@testable import MovieMate

final class GoodResultPageTests: XCTestCase {
    private var pageView: ResultPageView!
    private let viewModel = ResultPageViewModel(result: .good,
                                                matchedMovie: Movie.mock)
    override func setUp() {
        pageView = ResultPageView()
        pageView.configure(with: viewModel)
    }

    func testSetupHierarchy() {
        XCTAssertTrue(pageView.subviews.count == 6)
    }

    func testSetupTitle() {
        let expected = UILabel()
        expected.text = "Драйв"

        expected.font = .systemFont(ofSize: 43, weight: .black, width: .expanded)
        expected.textColor = .white
        expected.textAlignment = .left
        expected.numberOfLines = 2

        XCTAssertEqual(pageView.title.text, expected.text)
        XCTAssertEqual(pageView.title.font, expected.font)
        XCTAssertEqual(pageView.title.textColor, expected.textColor)
        XCTAssertEqual(pageView.title.numberOfLines, expected.numberOfLines)
        XCTAssertEqual(pageView.title.textAlignment, expected.textAlignment)
    }

    func testSetupSubtitle() {
        let expected = UILabel()
        expected.text = "🍿🍿🍿"

        expected.numberOfLines = 2
        expected.textColor = .white
        expected.font = .systemFont(ofSize: 40, weight: .medium, width: .expanded)

        XCTAssertEqual(pageView.subtitle.text, expected.text)
        XCTAssertEqual(pageView.subtitle.font, expected.font)
        XCTAssertEqual(pageView.subtitle.textColor, expected.textColor)
        XCTAssertEqual(pageView.subtitle.numberOfLines, expected.numberOfLines)
    }

    func testSetupRestartButton() {
        let expected = UIButton()

        var conf = UIButton.Configuration.filled()

        conf.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 20, weight: .bold, width: .expanded)
            return outgoing
        }

        expected.configuration = conf
        expected.tintColor = .white
        expected.setTitle("Попробовать еще раз", for: .normal)
        expected.setTitleColor(.black, for: .normal)

        XCTAssertEqual(pageView.restartButton.title(for: .normal)
                       , expected.title(for: .normal))
        XCTAssertEqual(pageView.restartButton.titleLabel?.font,
                       expected.titleLabel?.font)
        XCTAssertEqual(pageView.restartButton.titleColor(for: .normal),
                       expected.titleColor(for: .normal))
        XCTAssertEqual(pageView.restartButton.tintColor, 
                       expected.tintColor)
    }

    func testSetupLeaveSessionButton() {
        let expected = UIButton()

        var conf = UIButton.Configuration.plain()

        conf.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 17, weight: .semibold, width: .expanded)
            return outgoing
        }

        expected.configuration = conf
        expected.tintColor = .white
        expected.setTitle("Выйти", for: .normal)
        expected.setTitleColor(.white, for: .normal)

        XCTAssertEqual(pageView.leaveSessionButton.title(for: .normal)
                       , expected.title(for: .normal))
        XCTAssertEqual(pageView.leaveSessionButton.titleLabel?.font,
                       expected.titleLabel?.font)
        XCTAssertEqual(pageView.leaveSessionButton.titleColor(for: .normal),
                       expected.titleColor(for: .normal))
        XCTAssertEqual(pageView.leaveSessionButton.tintColor,
                       expected.tintColor)
    }
}

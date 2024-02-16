//
//  BadResultPageTests.swift
//  MovieMateTests
//
//  Created by denis.beloshitsky on 16.02.2024.
//

import XCTest
@testable import MovieMate

final class BadResultPageTests: XCTestCase {
    private var pageView: ResultPageView!
    private let viewModel = ResultPageViewModel(result: .bad)
    override func setUp() {
        pageView = ResultPageView()
        pageView.configure(with: viewModel)
    }

    func testSetupHierarchy() {
        XCTAssertTrue(pageView.subviews.count == 5)
    }

    func testSetupTitle() {
        let expected = UILabel()
        expected.text = "Сожалеем 😢"

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
        expected.text = "Найти фильм не удалось 🫠"

        expected.numberOfLines = 2
        expected.textColor = .white
        expected.font = .systemFont(ofSize: 40, weight: .medium, width: .expanded)

        XCTAssertEqual(pageView.subtitle.text, expected.text)
        XCTAssertEqual(pageView.subtitle.font, expected.font)
        XCTAssertEqual(pageView.subtitle.textColor, expected.textColor)
        XCTAssertEqual(pageView.subtitle.numberOfLines, expected.numberOfLines)
    }
}

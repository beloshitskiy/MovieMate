//
//  WaitingPageTests.swift
//  MovieMateTests
//
//  Created by denis.beloshitsky on 15.02.2024.
//

import XCTest
@testable import MovieMate

final class WaitingPageTests: XCTestCase {
    private let pageView = WaitingPageView()

    func testSetupHierarchy() {
        XCTAssertTrue(pageView.subviews.count == 3)
    }

    func testSetupTitle() {
        let expected = UILabel()
        expected.font = .systemFont(ofSize: 43, weight: .black, width: .expanded)
        expected.textColor = .white
        expected.text = "Отлично!"
        expected.textAlignment = .left

        XCTAssertEqual(pageView.title.text, expected.text)
        XCTAssertEqual(pageView.title.font, expected.font)
        XCTAssertEqual(pageView.title.textColor, expected.textColor)
        XCTAssertEqual(pageView.title.textAlignment, expected.textAlignment)
    }

    func testSetupSubtitle() {
        let expected = UILabel()
        expected.font = .systemFont(ofSize: 40, weight: .medium, width: .expanded)
        expected.textColor = .white
        expected.text = "Теперь ждем остальных"
        expected.numberOfLines = 2

        XCTAssertEqual(pageView.subtitle.text, expected.text)
        XCTAssertEqual(pageView.subtitle.font, expected.font)
        XCTAssertEqual(pageView.subtitle.textColor, expected.textColor)
        XCTAssertEqual(pageView.subtitle.numberOfLines, expected.numberOfLines)
    }
}

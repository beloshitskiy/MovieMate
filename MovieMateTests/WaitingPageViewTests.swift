//
//  JoinWaitingPageViewTests.swift
//  MovieMateTests
//
//  Created by denis.beloshitsky on 16.02.2024.
//

import XCTest
@testable import MovieMate

final class WaitingPageViewTests: XCTestCase {
    private let pageVC = WaitingPageViewController(type: .join)

    func testSetupHierarchy() {
        XCTAssertTrue(pageVC.pageView.subviews.count == 3)
    }

    func testSetupTitle() {
        let expected = UILabel()
        expected.text = "Отлично!"
        expected.font = .systemFont(ofSize: 43, weight: .black, width: .expanded)
        expected.textColor = .white
        expected.textAlignment = .left

        XCTAssertEqual(pageVC.pageView.title.text, expected.text)
        XCTAssertEqual(pageVC.pageView.title.font, expected.font)
        XCTAssertEqual(pageVC.pageView.title.textColor, expected.textColor)
        XCTAssertEqual(pageVC.pageView.title.textAlignment, expected.textAlignment)
    }

    func testSetupSubtitle() {
        let expected = UILabel()
        expected.text = "Теперь ждем остальных"
        expected.numberOfLines = 2
        expected.textColor = .white

        expected.font = .systemFont(ofSize: 40, weight: .medium, width: .expanded)

        XCTAssertEqual(pageVC.pageView.subtitle.text, expected.text)
        XCTAssertEqual(pageVC.pageView.subtitle.font, expected.font)
        XCTAssertEqual(pageVC.pageView.subtitle.textColor, expected.textColor)
        XCTAssertEqual(pageVC.pageView.subtitle.numberOfLines, expected.numberOfLines)
    }

    func testStartAnimating() {
        pageVC.pageView.startAnimating()
        XCTAssertNotNil(pageVC.cancellable)
    }
}

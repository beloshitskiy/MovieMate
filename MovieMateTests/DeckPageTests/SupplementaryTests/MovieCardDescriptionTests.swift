//
//  MovieCardDescriptionTests.swift
//  MovieMateTests
//
//  Created by denis.beloshitsky on 15.02.2024.
//

import XCTest
@testable import MovieMate

final class MovieCardDescriptionTests: XCTestCase {
    private let vc = MovieCardDescriptionViewController()

    override func setUp() {
        vc.movieDescription = Movie.mock.description
        vc.viewDidLoad()
    }

    func testSetupHierarchy() {
        XCTAssertTrue(vc.view.subviews.count == 3)
    }

    func testSetupTitle() {
        let expected = UILabel()

        expected.text = "О фильме"
        expected.font = UIFont.systemFont(ofSize: 28, weight: .black, width: .expanded)
        expected.textColor = .white
        expected.textAlignment = .left
        expected.backgroundColor = .clear

        XCTAssertEqual(vc.titleLabel.text, expected.text)
        XCTAssertEqual(vc.titleLabel.font, expected.font)
        XCTAssertEqual(vc.titleLabel.textColor, expected.textColor)
        XCTAssertEqual(vc.titleLabel.textAlignment, expected.textAlignment)
        XCTAssertEqual(vc.titleLabel.backgroundColor, expected.backgroundColor)
    }

    func testSetupText() {
        let expected = UITextView()

        expected.text = "Великолепный водитель – при свете дня он выполняет каскадерские трюки на съёмочных площадках Голливуда, а по ночам ведет рискованную игру. Но один опасный контракт – и за его жизнь назначена награда. Теперь, чтобы остаться в живых и спасти свою очаровательную соседку, он должен делать то, что умеет лучше всего – виртуозно уходить от погони."
        expected.isEditable = false
        expected.isSelectable = false
        expected.backgroundColor = .clear
        expected.font = UIFont.systemFont(ofSize: 17, weight: .semibold, width: .expanded)
        expected.textColor = .white

        XCTAssertEqual(vc.textView.text, expected.text)
        XCTAssertEqual(vc.textView.isEditable, expected.isEditable)
        XCTAssertEqual(vc.textView.isSelectable, expected.isSelectable)
        XCTAssertEqual(vc.textView.font, expected.font)
        XCTAssertEqual(vc.textView.backgroundColor, expected.backgroundColor)
        XCTAssertEqual(vc.textView.textColor, expected.textColor)
    }
}

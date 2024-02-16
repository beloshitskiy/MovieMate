//
//  GenrePageTests.swift
//  MovieMateTests
//
//  Created by denis.beloshitsky on 15.02.2024.
//

import XCTest
@testable import MovieMate

final class GenrePageTests: XCTestCase {
    private let pageVC = GenrePageViewController()

    func testSetupHierarchy() {
        XCTAssertTrue(pageVC.genreView.subviews.count == 5)
    }

    func testSetupTitle() {
        let expected = UILabel()
        expected.text = "Выберите жанр(ы)"
        expected.font = UIFont.systemFont(ofSize: 28, weight: .black, width: .expanded)
        expected.textColor = .white
        expected.textAlignment = .left

        XCTAssertEqual(pageVC.genreView.titleLabel.text, expected.text)
        XCTAssertEqual(pageVC.genreView.titleLabel.font, expected.font)
        XCTAssertEqual(pageVC.genreView.titleLabel.textColor, expected.textColor)
        XCTAssertEqual(pageVC.genreView.titleLabel.textAlignment, expected.textAlignment)
    }

    func testSetupTableView() {
        let expected = UITableView()
        expected.rowHeight = 60
        expected.separatorStyle = .none
        expected.allowsMultipleSelection = true
        expected.backgroundColor = .clear

        XCTAssertEqual(pageVC.genreView.tableView.rowHeight, expected.rowHeight)
        XCTAssertEqual(pageVC.genreView.tableView.separatorStyle, expected.separatorStyle)
        XCTAssertEqual(pageVC.genreView.tableView.allowsMultipleSelection, expected.allowsMultipleSelection)
        XCTAssertEqual(pageVC.genreView.tableView.backgroundColor, expected.backgroundColor)
    }

    func testSetupRandomGenreButton() {
        let expected = UIButton()
        var conf = UIButton.Configuration.filled()

        conf.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 20, weight: .bold, width: .expanded)
            return outgoing
        }

        expected.configuration = conf

        expected.tintColor = .white
        expected.setTitle("Случайный жанр", for: .normal)
        expected.setTitleColor(.black, for: .normal)

        XCTAssertEqual(pageVC.genreView.randomGenreButton.title(for: .normal)
                       , expected.title(for: .normal))
        XCTAssertEqual(pageVC.genreView.randomGenreButton.titleLabel?.font,
                       expected.titleLabel?.font)
        XCTAssertEqual(pageVC.genreView.randomGenreButton.titleColor(for: .normal),
                       expected.titleColor(for: .normal))
    }

    func testSetupConfirmButton() {
        let expected = UIButton()
        var conf = UIButton.Configuration.filled()

        conf.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 20, weight: .bold, width: .expanded)
            return outgoing
        }

        expected.configuration = conf

        expected.tintColor = .white
        expected.setTitle("Подтвердить", for: .normal)
        expected.setTitleColor(.black, for: .normal)

        XCTAssertEqual(pageVC.genreView.confirmButton.title(for: .normal)
                       , expected.title(for: .normal))
        XCTAssertEqual(pageVC.genreView.confirmButton.titleLabel?.font,
                       expected.titleLabel?.font)
        XCTAssertEqual(pageVC.genreView.confirmButton.titleColor(for: .normal),
                       expected.titleColor(for: .normal))
    }

    func testCellSetup() {
        let expected = GenreCell()
        expected.configure(with: "Комедия")
        XCTAssertEqual(expected.genre, "Комедия")

        expected.prepareForReuse()
        XCTAssertEqual(expected.genre, "")
        XCTAssertFalse(expected.isChosen)
    }
}

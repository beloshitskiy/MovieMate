//
//  DeckPageViewControllerTests.swift
//  MovieMateTests
//
//  Created by denis.beloshitsky on 16.02.2024.
//

import XCTest
@testable import MovieMate

final class DeckPageViewControllerTests: XCTestCase {
    private let pageVC = DeckPageViewController()

    override func setUp() {
        _ = UINavigationController(rootViewController: pageVC)
        pageVC.viewDidLoad()
    }
    
    func testDependenciesWereInjected() {
        XCTAssertNotNil(pageVC.dataSource.stack)
        XCTAssertNotNil(pageVC.deckView.dataSource)
        XCTAssertNotNil(pageVC.deckView.delegate)
    }
    
    func testStateChangedToFinished() {
        pageVC.handleStateChanged(.mock)
        XCTAssertEqual(pageVC.navigationController?.topViewController, pageVC)
    }

    func testCardStackSwipedRight() {
        pageVC.cardStack(pageVC.deckView,
                         didSwipeCardAt: 0,
                         with: .right)
        XCTAssertEqual(pageVC.navigationController?.topViewController, pageVC)
        XCTAssertTrue(pageVC.dataSource.movies.isEmpty)
    }

    func testCardStackSwipedLeft() {
        pageVC.cardStack(pageVC.deckView,
                         didSwipeCardAt: 0,
                         with: .left)
        XCTAssertEqual(pageVC.navigationController?.topViewController, pageVC)
        XCTAssertTrue(pageVC.dataSource.movies.isEmpty)
    }

    func testCardStackDidSwipedAll() {
        pageVC.didSwipeAllCards(pageVC.deckView)

        XCTAssertNotNil(pageVC.emptyDeckView.cancellable)
        XCTAssertTrue(pageVC.dataSource.movies.isEmpty)
    }
}

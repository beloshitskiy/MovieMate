//
//  WelcomePageTests.swift
//  MovieMateTests
//
//  Created by denis.beloshitsky on 15.02.2024.
//

import XCTest
import YYText
@testable import MovieMate

final class WelcomePageTests: XCTestCase {
    private let pageVC = WelcomePageViewController()

    override func setUp() {
        _ = UINavigationController(rootViewController: pageVC)
    }

    func testSetupHierarchy() {
        XCTAssertTrue(pageVC.welcomeView.subviews.count == 4)
    }

    func testSetupTitle() {
        let expected = YYLabel()
        expected.text = "Добро\nпожаловать\nв MovieMate"
        expected.font = .systemFont(ofSize: 43, weight: .black, width: .expanded)
        expected.textColor = .white
        expected.numberOfLines = 3
        expected.textAlignment = .left
        expected.textVerticalAlignment = .top

        XCTAssertEqual(pageVC.welcomeView.title.text, expected.text)
        XCTAssertEqual(pageVC.welcomeView.title.font, expected.font)
        XCTAssertEqual(pageVC.welcomeView.title.textColor, expected.textColor)
        XCTAssertEqual(pageVC.welcomeView.title.numberOfLines, expected.numberOfLines)
        XCTAssertEqual(pageVC.welcomeView.title.textVerticalAlignment, expected.textVerticalAlignment)
    }

    func testSetupCreateLobbyButton() {
        let expected = UIButton()

        var conf = UIButton.Configuration.filled()

        conf.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 20, weight: .bold, width: .expanded)
            return outgoing
        }

        expected.configuration = conf

        expected.tintColor = .white
        expected.setTitle("Создать лобби", for: .normal)
        expected.setTitleColor(.black, for: .normal)

        XCTAssertEqual(pageVC.welcomeView.createLobbyButton.tintColor,
                       expected.tintColor)
        XCTAssertEqual(pageVC.welcomeView.createLobbyButton.titleLabel?.text,
                       expected.titleLabel?.text)
        XCTAssertEqual(pageVC.welcomeView.createLobbyButton.titleLabel?.textColor,
                       expected.titleLabel?.textColor)
    }

    func testSetupJoinLobbyButton() {
        let expected = UIButton()

        var conf = UIButton.Configuration.plain()

        conf.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 17, weight: .semibold, width: .expanded)
            return outgoing
        }

        expected.configuration = conf

        expected.setTitle("Присоединиться к лобби", for: .normal)
        expected.setTitleColor(.white, for: .normal)
        expected.tintColor = .white

        XCTAssertEqual(pageVC.welcomeView.joinLobbyButton.tintColor,
                       expected.tintColor)
        XCTAssertEqual(pageVC.welcomeView.joinLobbyButton.titleLabel?.text,
                       expected.titleLabel?.text)
        XCTAssertEqual(pageVC.welcomeView.joinLobbyButton.titleLabel?.textColor,
                       expected.titleLabel?.textColor)
    }

    @MainActor 
    func testMoveToCreateLobbyPage() {
        pageVC.welcomeVM.moveToCreateLobbyPage()
        XCTAssertEqual(pageVC.navigationController?.topViewController, pageVC)
    }

    @MainActor
    func testMoveToJoinLobbyPage() {
        pageVC.welcomeVM.moveToJoinLobbyPage()
        XCTAssertEqual(pageVC.navigationController?.topViewController, pageVC)
    }
}

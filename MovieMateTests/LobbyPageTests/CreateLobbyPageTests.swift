//
//  CreateLobbyPageTests.swift
//  MovieMateTests
//
//  Created by denis.beloshitsky on 15.02.2024.
//

import XCTest
@testable import MovieMate

final class CreateLobbyPageTests: XCTestCase {
    private var viewModel: LobbyPageViewModel!
    private var pageVC: LobbyPageViewController!

    override func setUp() {
        viewModel = LobbyPageViewModel(action: .create)
        pageVC = LobbyPageViewController(with: viewModel)
        _ = UINavigationController(rootViewController: pageVC)
    }

    func testSetupHierarchy() {
        XCTAssertTrue(pageVC.lobbyView.subviews.count == 5)
    }

    static func setupExpectedHeaderLabel(with title: String) -> UILabel {
        let expected = UILabel()
        expected.text = title
        expected.textColor = .white
        expected.numberOfLines = 2
        expected.font = .systemFont(ofSize: 42, weight: .black, width: .expanded)
        return expected
    }

    static func setupExpectedContinueButton(with title: String) -> UIButton {
        let expected = UIButton()

        var conf = UIButton.Configuration.filled()
        conf.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 20, weight: .bold, width: .expanded)
            return outgoing
        }

        expected.configuration = conf
        expected.setTitle(title, for: .normal)
        expected.setTitleColor(.black, for: .normal)
        expected.setTitleColor(.white, for: .disabled)

        return expected
    }

    func testSetupHeaderLabel() {
        let expected = CreateLobbyPageTests.setupExpectedHeaderLabel(with: "Ваш Lobby ID")
        let unexpected = CreateLobbyPageTests.setupExpectedHeaderLabel(with: "ВашLobbyID")

        XCTAssertEqual(pageVC.lobbyView.headerLabel.text, expected.text)
        XCTAssertEqual(pageVC.lobbyView.headerLabel.font, expected.font)
        XCTAssertEqual(pageVC.lobbyView.headerLabel.textColor, expected.textColor)
        XCTAssertEqual(pageVC.lobbyView.headerLabel.numberOfLines, expected.numberOfLines)  

        XCTAssertNotEqual(pageVC.lobbyView.headerLabel.text, unexpected.text)
    }

    func testSetupContinueButton() {
        let expected = CreateLobbyPageTests.setupExpectedContinueButton(with: "Начать игру!")
        let unexpected = CreateLobbyPageTests.setupExpectedContinueButton(with: "Начать игру!")

        XCTAssertEqual(pageVC.lobbyView.continueButton.tintColor,
                       expected.tintColor)
        XCTAssertEqual(pageVC.lobbyView.continueButton.titleLabel?.text,
                       expected.titleLabel?.text)
        XCTAssertEqual(pageVC.lobbyView.continueButton.titleColor(for: .normal),
                       expected.titleColor(for: .normal))
        XCTAssertEqual(pageVC.lobbyView.continueButton.titleColor(for: .disabled),
                       expected.titleColor(for: .disabled))

        XCTAssertNotEqual(pageVC.lobbyView.continueButton.title(for: .normal), unexpected.title(for: .normal))
    }

    func testSetupRoomIDLabel() {
        let expected = UILabel()
        expected.font = .systemFont(ofSize: 65, weight: .black, width: .expanded)

        expected.textColor = .white
        expected.text = "YOURID"

        XCTAssertEqual(pageVC.lobbyView.roomIDLabel.text, expected.text)
        XCTAssertEqual(pageVC.lobbyView.roomIDLabel.font, expected.font)
        XCTAssertEqual(pageVC.lobbyView.roomIDLabel.textColor, expected.textColor)
    }

    func testSetupCancelRoomCreationButton() {
        let expected = UIButton()

        var conf = UIButton.Configuration.plain()
        conf.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 17, weight: .semibold, width: .expanded)
            return outgoing
        }
        expected.configuration = conf

        expected.tintColor = .white
        expected.setTitle("Распустить лобби", for: .normal)
        expected.setTitleColor(.white, for: .normal)

        XCTAssertEqual(pageVC.lobbyView.cancelRoomCreationButton.tintColor,
                       expected.tintColor)
        XCTAssertEqual(pageVC.lobbyView.cancelRoomCreationButton.title(for: .normal),
                       expected.title(for: .normal))
        XCTAssertEqual(pageVC.lobbyView.cancelRoomCreationButton.titleColor(for: .normal),
                       expected.titleColor(for: .normal))
    }

    func testCreateLobbyIfNeeded() {
        viewModel.createLobbyIfNeeded()
        XCTAssertEqual(pageVC.navigationController?.topViewController, pageVC)
    }
}

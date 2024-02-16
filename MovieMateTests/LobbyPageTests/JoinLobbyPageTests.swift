//
//  JoinLobbyPageTests.swift
//  MovieMateTests
//
//  Created by denis.beloshitsky on 15.02.2024.
//

import XCTest
@testable import MovieMate

final class JoinLobbyPageTests: XCTestCase {
    private var viewModel: LobbyPageViewModel!
    private var pageVC: LobbyPageViewController!

    override func setUp() {
        viewModel = LobbyPageViewModel(action: .join)
        pageVC = LobbyPageViewController(with: viewModel)
        _ = UINavigationController(rootViewController: pageVC)
    }

    func testSetupHierarchy() {
        XCTAssertTrue(pageVC.lobbyView.subviews.count == 4)
    }

    func testSetupHeaderLabel() {
        let expected = CreateLobbyPageTests.setupExpectedHeaderLabel(with: "Введите Lobby ID")
        XCTAssertEqual(pageVC.lobbyView.headerLabel.text, expected.text)
        XCTAssertEqual(pageVC.lobbyView.headerLabel.font, expected.font)
        XCTAssertEqual(pageVC.lobbyView.headerLabel.textColor, expected.textColor)
        XCTAssertEqual(pageVC.lobbyView.headerLabel.numberOfLines, expected.numberOfLines)
    }

    func testSetupContinueButton() {
        let expected = UIButton()

        var conf = UIButton.Configuration.filled()
        conf.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 20, weight: .bold, width: .expanded)
            return outgoing
        }

        expected.configuration = conf
        expected.setTitle("Присоединиться", for: .normal)
        expected.setTitleColor(.black, for: .normal)
        expected.setTitleColor(.white, for: .disabled)

        XCTAssertEqual(pageVC.lobbyView.continueButton.tintColor,
                       expected.tintColor)
        XCTAssertEqual(pageVC.lobbyView.continueButton.titleLabel?.text,
                       expected.titleLabel?.text)
        XCTAssertEqual(pageVC.lobbyView.continueButton.titleColor(for: .normal),
                       expected.titleColor(for: .normal))
        XCTAssertEqual(pageVC.lobbyView.continueButton.titleColor(for: .disabled),
                       expected.titleColor(for: .disabled))
    }

    func testSetupTextField() {
        let expected = UITextField()
        expected.placeholder = "Ваш Lobby ID"
        expected.font = .systemFont(ofSize: 40, weight: .medium, width: .expanded)
        expected.textColor = .white
        expected.autocapitalizationType = .allCharacters
        expected.autocorrectionType = .no
        expected.spellCheckingType = .no
        expected.keyboardType = .asciiCapable
        expected.returnKeyType = .join

        XCTAssertEqual(pageVC.lobbyView.textField.placeholder, expected.placeholder)
        XCTAssertEqual(pageVC.lobbyView.textField.font, expected.font)
        XCTAssertEqual(pageVC.lobbyView.textField.textColor, expected.textColor)
        XCTAssertEqual(pageVC.lobbyView.textField.autocapitalizationType,
                       expected.autocapitalizationType)
        XCTAssertEqual(pageVC.lobbyView.textField.spellCheckingType,
                       expected.spellCheckingType)
        XCTAssertEqual(pageVC.lobbyView.textField.keyboardType, expected.keyboardType)
        XCTAssertEqual(pageVC.lobbyView.textField.returnKeyType, expected.returnKeyType)
    }

    func testLobbyJoined() {
        viewModel.joinLobby(lobbyId: "id")
        XCTAssertEqual(pageVC.navigationController?.topViewController, pageVC)
    }

    @MainActor
    func testCancelRoomCreation() {
        viewModel.cancelRoomCreation()
        XCTAssertEqual(pageVC.navigationController?.topViewController, pageVC)
    }

    @MainActor
    func testOnTimeout() {
        viewModel.onTimeout()
        XCTAssertEqual(pageVC.navigationController?.topViewController, pageVC)
    }
}

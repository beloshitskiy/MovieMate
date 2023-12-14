//
//  LobbyPageView.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 30.10.2023.
//

import Combine
import CombineCocoa
import HandlersKit
import SkeletonView
import SnapKit
import UIKit

final class LobbyPageView: UIView {
    private var viewModel: LobbyPageViewModel?

    private let headerLabel = UILabel()
    private lazy var roomIDLabel = UILabel()
    private lazy var textField = UITextField()
    private let continueButton = UIButton()
    private lazy var cancelRoomCreationButton = UIButton()

    @Published
    private var probablyRoomID = ""
    private var cancellables: Set<AnyCancellable> = []

    func configure(with viewModel: LobbyPageViewModel) {
        guard self.viewModel == nil else { return }
        self.viewModel = viewModel
        setupLobby()

        self.backgroundColor = .red
    }
}

private extension LobbyPageView {
    // MARK: - Setup UI

    func setupLobby() {
        setupHierarchy()
        setupConstraints()
        setupUI()
    }

    func setupHierarchy() {
        guard let action = viewModel?.action else { return }

        self.addSubviews([
            headerLabel,
            continueButton,
        ])

        if action == .create {
            self.addSubviews([
                roomIDLabel,
                cancelRoomCreationButton
            ])
        } else {
            self.addSubview(textField)
            textField.delegate = self
        }
    }

    func setupConstraints() {
        guard let action = viewModel?.action else { return }
        registerAutomaticKeyboardConstraints()

        headerLabel.snp.prepareConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.32).keyboard(true, in: self)
        }

        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.58).keyboard(false, in: self)
            make.horizontalEdges.equalToSuperview().inset(LayoutConfig.horizontalInset)
        }

        if action == .create {
            roomIDLabel.snp.makeConstraints { make in
                make.top.equalTo(headerLabel.snp.bottom).offset(10)
                make.horizontalEdges.equalToSuperview().inset(LayoutConfig.horizontalInset)
            }
            cancelRoomCreationButton.snp.makeConstraints { make in
                make.top.equalTo(continueButton.snp.bottom).offset(10)
                make.height.equalTo(50)
                make.horizontalEdges.equalToSuperview().inset(LayoutConfig.horizontalInset)
                make.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            }
        } else {
            textField.snp.makeConstraints { make in
                make.top.equalTo(headerLabel.snp.bottom).offset(10)
                make.horizontalEdges.equalToSuperview().inset(LayoutConfig.horizontalInset)
            }
        }

        continueButton.snp.prepareConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(40).keyboard(true, in: self)
        }

        continueButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview().inset(LayoutConfig.horizontalInset)

            if action == .join {
                make.bottom.greaterThanOrEqualTo(self.safeAreaLayoutGuide).inset(20).keyboard(false, in: self)
            }
        }
    }

    func setupUI() {
        setupHeaderLabel()
        setupRoomIDLabel()
        setupTextField()
        setupContinueButton()
        setupCancelRoomCreationButton()
    }

    // MARK: - Setup separate views

    func setupHeaderLabel() {
        headerLabel.text = viewModel?.headerText
        headerLabel.textColor = .white

        headerLabel.numberOfLines = 2

        if #available(iOS 16.0, *) {
            headerLabel.font = .systemFont(ofSize: 42, weight: .black, width: .expanded)
        } else {
            headerLabel.font = .systemFont(ofSize: 50, weight: .black)
        }
    }

    func setupRoomIDLabel() {
        guard viewModel?.action == .create else { return }

        if #available(iOS 16.0, *) {
            roomIDLabel.font = .systemFont(ofSize: 65, weight: .black, width: .expanded)
        } else {
            roomIDLabel.font = .systemFont(ofSize: 60, weight: .black)
        }

        roomIDLabel.textColor = .white
        roomIDLabel.text = viewModel?.roomID
        roomIDLabel.isSkeletonable = true
        roomIDLabel.showAnimatedGradientSkeleton()

        viewModel?.$roomID
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let label = self?.roomIDLabel else { return }
                label.text = $0
                label.hideSkeleton()
            }.store(in: &cancellables)
    }

    func setupTextField() {
        guard viewModel?.action == .join else { return }

        textField.placeholder = viewModel?.textFieldPlaceholder

        if #available(iOS 16.0, *) {
            textField.font = .systemFont(ofSize: 40, weight: .medium, width: .expanded)
        } else {
            textField.font = .systemFont(ofSize: 40, weight: .black)
        }

        textField.textColor = .white
        textField.autocapitalizationType = .allCharacters
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.keyboardType = .asciiCapable
        textField.returnKeyType = .join

        textField.textPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] str in
                self?.probablyRoomID = str ?? ""
            }.store(in: &cancellables)

        textField.returnPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.viewModel?.joinLobby(lobbyId: self.probablyRoomID)
            }.store(in: &cancellables)
    }

    func setupContinueButton() {
        var conf = UIButton.Configuration.filled()
        conf.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            if #available(iOS 16.0, *) {
                outgoing.font = UIFont.systemFont(ofSize: 20, weight: .bold, width: .expanded)
            } else {
                outgoing.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            }
            return outgoing
        }
        continueButton.configuration = conf

        continueButton.tintColor = .white
        continueButton.setTitle(viewModel?.continueButtonTitle, for: .normal)
        continueButton.setTitleColor(.black, for: .normal)

        $probablyRoomID
            .receive(on: DispatchQueue.main)
            .sink { [weak self] str in
                guard let self else { return }
                self.continueButton.isEnabled = self.viewModel?.canContinue(str) ?? false
            }.store(in: &cancellables)

        continueButton.onTap { [weak self] in
            guard let vm = self?.viewModel else { return }
            if vm.action == .join {
                vm.joinLobby(lobbyId: self?.probablyRoomID ?? "")
            } else {
                vm.startLobby()
            }
        }
    }

    func setupCancelRoomCreationButton() {
        guard viewModel?.action == .create else { return }

        var conf = UIButton.Configuration.plain()
        conf.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            if #available(iOS 16.0, *) {
                outgoing.font = UIFont.systemFont(ofSize: 17, weight: .semibold, width: .expanded)
            } else {
                outgoing.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            }
            return outgoing
        }
        cancelRoomCreationButton.configuration = conf

        cancelRoomCreationButton.tintColor = .white
        cancelRoomCreationButton.setTitle("Распустить лобби", for: .normal)
        cancelRoomCreationButton.setTitleColor(.black, for: .normal)

        cancelRoomCreationButton.onTap { [weak self] in
            self?.viewModel?.cancelRoomCreation()
        }
    }

    // MARK: - Layout config

    enum LayoutConfig {
        static let horizontalInset: CGFloat = 20.0
    }
}

extension LobbyPageView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        let isLengthOK = updatedText.count <= 6

        let allowedSet = CharacterSet.letters.union(.decimalDigits)
        var charsAllowed = true

        updatedText.forEach { char in
            char.unicodeScalars.forEach { charsAllowed = allowedSet.contains($0) }
        }

        return isLengthOK && charsAllowed
    }
}

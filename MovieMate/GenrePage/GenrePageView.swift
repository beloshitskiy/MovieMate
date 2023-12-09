//
//  GenrePageView.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 30.10.2023.
//

import Combine
import HandlersKit
import UIKit

final class GenrePageView: UIView {
    private let titleLabel = UILabel()
    private let tableView = UITableView()
    private let randomGenreButton = UIButton()
    private let confirmButton = UIButton()

    private var cancellables: Set<AnyCancellable> = []

    private let viewModel: GenrePageViewModel

    init(viewModel: GenrePageViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension GenrePageView {
    func setupUI() {
        self.addSubviews([
            titleLabel,
            tableView,
            randomGenreButton,
            confirmButton,
        ])

        self.backgroundColor = .white

        setupConstraints()

        setupTitle()
        setupTableView()
        setupRandomGenreButton()
        setupConfirmButton()
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(LayoutConfig.horizontalInset)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(5)
            make.bottom.equalTo(randomGenreButton.snp.top).offset(-20)
        }

        randomGenreButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview().inset(LayoutConfig.horizontalInset)
        }

        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(randomGenreButton.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview().inset(LayoutConfig.horizontalInset)
            make.bottom.greaterThanOrEqualTo(self.safeAreaLayoutGuide).inset(10)
        }
    }

    func setupTitle() {
        titleLabel.text = "Выберите жанр(ы)"
        if #available(iOS 16.0, *) {
            titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .black, width: .expanded)
        } else {
            titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .black)
        }
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
    }

    func setupConfirmButton() {
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

        confirmButton.configuration = conf

        confirmButton.tintColor = .white
        confirmButton.setTitle("Подтвердить", for: .normal)
        confirmButton.setTitleColor(.black, for: .normal)

        viewModel.$selectedPaths
            .sink { [weak self] arr in
                self?.confirmButton.isEnabled = !arr.isEmpty
            }.store(in: &cancellables)

        confirmButton.onTap { [weak self] in
            guard let self else { return }
            self.viewModel.confirmSelected(self.tableView)
        }
    }

    func setupRandomGenreButton() {
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

        randomGenreButton.configuration = conf

        randomGenreButton.tintColor = .white
        randomGenreButton.setTitle("Случайный жанр", for: .normal)
        randomGenreButton.setTitleColor(.black, for: .normal)

        randomGenreButton.onTap { [weak self] in
            guard let self else { return }
            self.viewModel.chooseGenreRandomly()
        }
    }

    func setupTableView() {
        tableView.register(cellWithClass: GenreCell.self)
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = true
    }

    // MARK: - Layout config

    enum LayoutConfig {
        static let horizontalInset: CGFloat = 20.0
    }
}

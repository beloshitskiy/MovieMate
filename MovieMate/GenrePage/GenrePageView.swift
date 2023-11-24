//
//  GenrePageView.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 30.10.2023.
//

import UIKit
import HandlersKit

final class GenrePageView: UIView {
    private let tableView = UITableView()
    private let confirmButton = UIButton()

    private let viewModel: GenrePageViewModel

    init(viewModel: GenrePageViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel

        tableView.dataSource = viewModel.vc
        tableView.delegate = viewModel.vc
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension GenrePageView {

    func setupUI() {
        confirmButton.onTap { [weak viewModel] in
            viewModel?.confirmChosenGenres()
        }
    }

    // MARK: - Layout config

    enum LayoutConfig {}
}

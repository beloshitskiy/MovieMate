//
//  MovieCardView.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 24.11.2023.
//

import HandlersKit
import SnapKit
import UIKit

final class MovieCardView: UIView {
    private var viewModel: MovieCardViewModel? {
        didSet {
            updateCard()
        }
    }

    private let undoButton = BlurredButton()
    private let durationView = MovieDurationView()

    private let posterView = UIImageView()

    private let substrateView = UIView()
    private let ratingView = UIView()

    private let titleLabel = UILabel()
    private let genresView = MovieGenreView()

    private let descriptionLabel = UILabel()

    private let likeButton = UIButton()
    private let dislikeButton = UIButton()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func configure(with viewModel: MovieCardViewModel) {
        guard self.viewModel == nil else { return }
        self.viewModel = viewModel
    }

    func prepareForReuse() {
        durationView.duration = nil
        posterView.image = nil
        titleLabel.text = nil
        genresView.genres = nil
        descriptionLabel.text = nil

        undoButton.isHidden = true
    }
}

private extension MovieCardView {
    // MARK: - Create & setup UI

    func setupUI() {
        setupHierarchy()
        setupConstraints()

        setupTitle()
        setupDescription()
    }

    func setupHierarchy() {
        self.addSubviews([
            undoButton,
            durationView,
            posterView,
            substrateView,
        ])

        substrateView.addSubviews([
            ratingView,
            titleLabel,
            genresView,
            descriptionLabel,
            likeButton,
            dislikeButton,
        ])

        undoButton.isHidden = true
    }

    func setupConstraints() {
        undoButton.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(LayoutConfig.horizontalInset)
        }

        durationView.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(LayoutConfig.horizontalInset)
        }

        posterView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(LayoutConfig.posterSide)
        }

        substrateView.snp.makeConstraints { make in
            make.top.equalTo(posterView.snp.bottom).inset(LayoutConfig.substrateTopInset)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }

    func setupTitle() {
        titleLabel.font = .preferredFont(forTextStyle: .title1)
        titleLabel.textColor = Color.main
    }

    func setupDescription() {
        descriptionLabel.font = .preferredFont(forTextStyle: .footnote)
        descriptionLabel.textColor = Color.main
    }

    func setupSubstrateView() {
        substrateView.backgroundColor = Color.surface
    }

    // MARK: - Update card with viewModel

    func updateCard() {
        guard let viewModel else { return }

        if viewModel.canUndo {
            undoButton.image = viewModel.undoImage
            undoButton.isHidden = false
        }

        durationView.duration = viewModel.duration
        posterView.image = viewModel.posterImage

        titleLabel.text = viewModel.title

        genresView.genres = viewModel.genres
        descriptionLabel.text = viewModel.description
    }

    // MARK: - Layout config

    enum LayoutConfig {
        static let horizontalInset: CGFloat = 25.0
        static let substrateTopInset: CGFloat = 15.0
        static let posterSide: CGFloat = UIScreen.main.bounds.width
    }
}


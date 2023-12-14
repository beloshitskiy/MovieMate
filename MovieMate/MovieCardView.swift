//
//  MovieCardView.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 03.12.2023.
//

import AlamofireImage
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

    private let posterImageView = UIImageView()
    private let gradientView = GradientView()

    private let substrateView = UIView()

    private let titleLabel = UILabel()
    private let infoLabel = MovieInfoLabel()
    private let genresLabel = MovieGenresLabel()

    private let actionsView = MovieActionsView()

    private let moreAboutButton = UIButton()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        substrateView.roundCorners(radius: 25.0, corners: [.topLeft, .topRight])
    }

    // MARK: - Public

    func configure(with viewModel: MovieCardViewModel) {
        guard self.viewModel == nil else { return }
        self.viewModel = viewModel
    }

    func prepareForReuse() {

    }
}

private extension MovieCardView {
    // MARK: - Create & setup UI

    func setupUI() {
        setupHierarchy()
        setupConstraints()
        
        titleLabel.textColor = .white
        if #available(iOS 16.0, *) {
            titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .black, width: .expanded)
        } else {
            titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        }

        var moreConf = UIButton.Configuration.filled()
        moreConf.title = "Подробнее о фильме"
        moreConf.titleAlignment = .leading
        moreConf.imagePlacement = .trailing
        moreConf.imagePadding = 5.0
        moreConf.image = UIImage(systemName: "info.square.fill")

        moreConf.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            if #available(iOS 16.0, *) {
                outgoing.font = UIFont.systemFont(ofSize: 20, weight: .medium, width: .expanded)
            } else {
                outgoing.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            }
            return outgoing
        }

        moreAboutButton.configuration = moreConf

        moreAboutButton.tintColor = UIColor(hex: 0xEFC944)
        moreAboutButton.setTitleColor(.white, for: .normal)
    }

    func setupHierarchy() {
        self.addSubviews([
            posterImageView,
            gradientView,
            substrateView,
        ])

        substrateView.addSubviews([
            titleLabel,
            infoLabel,
            genresLabel,
            actionsView,
            moreAboutButton,
        ])
    }

    func setupConstraints() {
        posterImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        gradientView.snp.makeConstraints { $0.edges.equalToSuperview() }

        substrateView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.6)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.horizontalEdges.equalToSuperview().inset(LayoutConfig.horizontalInset)
        }

        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(LayoutConfig.horizontalInset)
        }

        genresLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(LayoutConfig.horizontalInset)
        }

        moreAboutButton.snp.makeConstraints { make in
            make.top.equalTo(genresLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(LayoutConfig.horizontalInset)
        }

        actionsView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(moreAboutButton.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(LayoutConfig.horizontalInset * 2)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(25)
        }
    }

    func setupGradientView() {
        gradientView.colors = Constants.gradientFade
        gradientView.alpha = Constants.gradientFadeAlpha
        gradientView.locations = Constants.gradientFadeLocations
        gradientView.isUserInteractionEnabled = false
    }

    func setupActionsView() {
        actionsView.onLikeTap = MovieCardViewModel.onLikeTap
        actionsView.onDislikeTap = MovieCardViewModel.onDislikeTap
    }

    // MARK: - Update card with viewModel

    func updateCard() {
        guard let viewModel else { return }

        if viewModel.canUndo {
            undoButton.image = viewModel.undoImage
            undoButton.onTap = MovieCardViewModel.onUndoTap
            undoButton.isHidden = false
        }

        if let posterURL = viewModel.posterURL {
            posterImageView.af.setImage(withURL: posterURL, placeholderImage: Constants.placeholderImage)
        }

        titleLabel.text = viewModel.title
        infoLabel.setup(with: viewModel)
        genresLabel.setup(with: viewModel)
        setupActionsView()

        setNeedsLayout()
    }

    // MARK: - Constants & layout config

    enum Constants {
        static let placeholderImage = UIImage(systemName: "photo")
        static let gradientFadeAlpha: CGFloat = 0.75
        static let gradientFadeLocations: [CGFloat] = [
            0.0, 0.5, 1.0,
        ]
        static let gradientFade: [UIColor] = [
            .clear,
            .black.withAlphaComponent(0.4),
            .black.withAlphaComponent(0.8),
        ]
    }

    enum LayoutConfig {
        static let horizontalInset: CGFloat = 20.0
    }
}

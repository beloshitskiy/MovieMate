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

    private let undoButton = UIButton()

    private let posterBlurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
    private let backgroundPosterView = UIImageView()
    private let mainPosterView = UIImageView()

    private let substrateView = UIView()

    private let titleLabel = UILabel()
    private let infoLabel = MovieInfoLabel()
    private let genresLabel = MovieGenresLabel()

    private let actionsView = MovieActionsView()

    private let descriptionButton = UIButton()

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
        mainPosterView.roundCorners(radius: 6.0)
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
        
        setupTitle()
        setupDescriptionButton()
        setupUndoButton()

        mainPosterView.contentMode = .scaleAspectFit
        mainPosterView.clipsToBounds = true
    }

    func setupHierarchy() {
        self.addSubviews([
            backgroundPosterView,
            posterBlurView,
            substrateView,
            actionsView,
            mainPosterView,
            undoButton,
        ])

        substrateView.addSubviews([
            titleLabel,
            infoLabel,
            genresLabel,
            descriptionButton,
        ])
    }

    func setupConstraints() {
        backgroundPosterView.snp.makeConstraints { $0.edges.equalToSuperview() }
        posterBlurView.snp.makeConstraints { $0.edges.equalToSuperview() }

        undoButton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.top.equalToSuperview().inset(70)
            make.leading.equalToSuperview().inset(15)
        }

        mainPosterView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalToSuperview().inset(2 * LayoutConfig.horizontalInset)
            make.bottom.equalTo(substrateView.snp.top).offset(-20)
        }

        substrateView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.61)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(actionsView.snp.top).offset(-10)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
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

        descriptionButton.snp.makeConstraints { make in
            make.top.equalTo(genresLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(LayoutConfig.horizontalInset)
        }

        actionsView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(LayoutConfig.horizontalInset)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(25)
        }
    }

    func setupTitle() {
        titleLabel.textColor = .white
        if #available(iOS 16.0, *) {
            titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .black, width: .expanded)
        } else {
            titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        }

        titleLabel.numberOfLines = 2
    }

    func setupDescriptionButton() {
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

        descriptionButton.configuration = moreConf

        descriptionButton.tintColor = UIColor(hex: 0xFF7E24)
        descriptionButton.setTitleColor(.white, for: .normal)

        descriptionButton.onTap { [weak self] in
            guard let description = self?.viewModel?.description else { return }
            MovieCardViewModel.onDescriptionTap?(description)
        }
    }

    func setupActionsView() {
        actionsView.onLikeTap = MovieCardViewModel.onLikeTap
        actionsView.onDislikeTap = MovieCardViewModel.onDislikeTap
    }

    func setupUndoButton() {
        var conf = UIButton.Configuration.filled()
        conf.image = Constants.undoButtonImage
        conf.imagePlacement = .all

        undoButton.configuration = conf
        undoButton.tintColor = .black

        undoButton.onTap {
            MovieCardViewModel.onUndoTap?()
        }
    }

    // MARK: - Update card with viewModel

    func updateCard() {
        guard let viewModel else { return }

        if viewModel.canUndo {
            undoButton.isHidden = false
        }

        if let posterURL = viewModel.posterURL {
            mainPosterView.af.setImage(withURL: posterURL, placeholderImage: Constants.placeholderImage)
            backgroundPosterView.af.setImage(withURL: posterURL, placeholderImage: Constants.placeholderImage)
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
        static let undoButtonImage = UIImage(systemName: "arrow.uturn.backward.square.fill")?
            .applyingSymbolConfiguration(.init(pointSize: 30))
    }

    enum LayoutConfig {
        static let horizontalInset: CGFloat = 20.0
    }
}

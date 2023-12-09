//
//  GenrePageViewController.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 30.10.2023.
//

import SnapKit
import UIKit

final class GenrePageViewController: UIViewController {
    private let genreView: GenrePageView
    private let genresPageVM: GenrePageViewModel

    init() {
        genresPageVM = GenrePageViewModel()
        genreView = GenrePageView(viewModel: genresPageVM)
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(genreView)
        genreView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

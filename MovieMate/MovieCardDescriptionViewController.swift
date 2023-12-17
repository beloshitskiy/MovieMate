//
//  MovieCardDescriptionViewController.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 17.12.2023.
//

import UIKit
import SnapKit

final class MovieCardDescriptionViewController: UIViewController {
    var movieDescription: String = ""

    private let titleLabel = UILabel()
    private let textView = UITextView()
    private let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews([
            blurredView,
            titleLabel,
            textView,
        ])

        blurredView.snp.makeConstraints { $0.edges.equalToSuperview() }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }

        textView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(5)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }

        setupTitle()
        setupText()
    }
}

private extension MovieCardDescriptionViewController {
    func setupTitle() {
        titleLabel.text = "О фильме"
        if #available(iOS 16.0, *) {
            titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .black, width: .expanded)
        } else {
            titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .black)
        }
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .clear
    }

    func setupText() {
        textView.text = movieDescription
        textView.isEditable = false
        textView.isSelectable = false
        textView.backgroundColor = .clear

        if #available(iOS 16.0, *) {
            textView.font = UIFont.systemFont(ofSize: 17, weight: .semibold, width: .expanded)
        } else {
            textView.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        }

        textView.textColor = .white
    }
}

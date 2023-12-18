//
//  WaitingPageView.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 17.12.2023.
//

import UIKit
import Combine

final class WaitingPageView: UIView {
    var useSolidBackground = false {
        didSet {
            backgroundImage.isHidden = useSolidBackground
        }
    }

    private let title = UILabel()
    private let subtitle = UILabel()
    private let backgroundImage = UIImageView(image: .init(named: "welcome_blurred_total"))

    private var cancellable: AnyCancellable?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimating() {
        cancellable = Timer.publish(every: 0.7, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                self.setNeedsLayout()
                UIView.animate(withDuration: 0.1) {
                    if self.subtitle.text?.count == 24 {
                        self.subtitle.text?.removeLast(3)
                    } else {
                        self.subtitle.text?.append(".")
                    }

                    self.layoutIfNeeded()
                }
            }
    }

    func stopAnimating() {
        cancellable = nil
    }
}

private extension WaitingPageView {
    func setupUI() {
        self.addSubviews([
            backgroundImage,
            title,
            subtitle,
        ])

        setupConstraints()
        setupLabels()
    }

    func setupLabels() {
        title.text = "Отлично!"
        if #available(iOS 16.0, *) {
            title.font = .systemFont(ofSize: 43, weight: .black, width: .expanded)
        } else {
            title.font = .systemFont(ofSize: 50, weight: .black)
        }
        title.textColor = .white
        title.textAlignment = .left

        subtitle.text = "Теперь ждем остальных"
        subtitle.numberOfLines = 2
        subtitle.textColor = .white

        if #available(iOS 16.0, *) {
            subtitle.font = .systemFont(ofSize: 40, weight: .medium, width: .expanded)
        } else {
            subtitle.font = .systemFont(ofSize: 40, weight: .black)
        }
    }

    func setupConstraints() {
        backgroundImage.snp.makeConstraints { $0.edges.equalToSuperview() }

        title.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.61)
            make.horizontalEdges.equalToSuperview().inset(20)
        }

        subtitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}

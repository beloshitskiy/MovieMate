//
//  GradientView.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 03.12.2023.
//

import UIKit

public final class GradientView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    public var colors: [UIColor] {
        get {
            guard let colors = typedLayer.colors as? [CGColor] else { return [] }
            return colors.map { UIColor(cgColor: $0) }
        }
        set {
            typedLayer.colors = newValue.map { $0.cgColor }
        }
    }

    public var locations: [CGFloat] {
        get {
            guard let locations = typedLayer.locations else { return [] }
            return locations.map { CGFloat($0.doubleValue) }
        }
        set {
            typedLayer.locations = newValue.map { NSNumber(value: Double($0)) }
        }
    }

    public var startPoint: CGPoint {
        get { typedLayer.startPoint }
        set { typedLayer.startPoint = newValue }
    }

    public var endPoint: CGPoint {
        get { typedLayer.endPoint }
        set { typedLayer.endPoint = newValue }
    }

    // MARK: - Layer

    public override class var layerClass: AnyClass {
        CAGradientLayer.self
    }

    private var typedLayer: CAGradientLayer {
        guard let layer = self.layer as? CAGradientLayer else {
            fatalError("unexpected layer type")
        }
        return layer
    }

    // MARK: - Private

    private func setup() {
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
        layer.drawsAsynchronously = true
    }
}

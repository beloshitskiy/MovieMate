//
//  Color.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 24.11.2023.
//

import UIKit

enum Color {
    static let main = color("main")
    static let secondary = color("secondary")
    static let background = color("background")

    static let surface = color("surface")
    static let onSurface = color("onSurface")

    private static func color(_ named: String) -> UIColor {
        UIColor(named: named) ?? .clear
    }
}

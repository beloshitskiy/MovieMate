//
//  ImageManager.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 24.11.2023.
//

import Alamofire
import UIKit

final class ImageManager {
    static let shared = ImageManager()

    func loadImage(url: URL?) -> UIImage? {
        guard let url else { return nil }
    }
}

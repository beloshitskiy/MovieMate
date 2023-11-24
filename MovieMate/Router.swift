//
//  Router.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 12.11.2023.
//

import UIKit

final class Router {
    static let shared = Router()

    func navigate(from vc: UIViewController, to page: Page) {
        vc.present(page.vc(), animated: true)
    }
}

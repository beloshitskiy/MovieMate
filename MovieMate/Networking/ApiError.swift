//
//  ApiError.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 12.11.2023.
//

import Foundation

struct ErrorInfo {
    let title: String
    let message: String
    let buttonTitle: String
    let action: (() -> Void)?

    init(_ title: String, _ message: String, _ buttonTitle: String, _ action: (() -> Void)?) {
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
        self.action = action
    }
}

enum ApiError: Error {
    case serverError
}

extension ApiError {
    var errorInfo: ErrorInfo {
        switch self {
        case .serverError:
            return ErrorInfo("title", "message", "ok", nil)
        }
    }
}

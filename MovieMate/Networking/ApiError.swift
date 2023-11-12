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
}

enum ApiError: Error {
    case serverError
}


extension ApiError {
    var errorInfo: ErrorInfo {
        switch self {
        case .serverError:

        }
    }
}

//
//  ApiErrorDecodingTests.swift
//  MovieMateTests
//
//  Created by denis.beloshitsky on 16.02.2024.
//

import XCTest
@testable import MovieMate

final class ApiErrorDecodingTests: XCTestCase {
    func testCases() {
        let error = ApiError.incorrectId
        let expectedErrorInfo = ErrorInfo("Некорректный ID", "Введите корректный ID комнаты", "Хорошо")
        XCTAssertEqual(error.errorInfo, expectedErrorInfo)
    }

    func testUnableToCreateLobby() throws {
        let error = ApiError.unableToCreateLobby
        let expectedErrorInfo = ErrorInfo("Не удалось создать лобби", "Проверьте интернет", "Хорошо")
        XCTAssertEqual(error.errorInfo, expectedErrorInfo)
    }

    func testUnableToDeleteLobby() throws {
        let error = ApiError.unableToDeleteLobby
        let expectedErrorInfo = ErrorInfo("Не удалось удалить лобби", "Проверьте интернет", "Хорошо")
        XCTAssertEqual(error.errorInfo, expectedErrorInfo)
    }

    func testUnableToStartLobby() throws {
        let error = ApiError.unableToStartLobby
        let expectedErrorInfo = ErrorInfo("Не удалось начать игру", "Проверьте интернет", "Хорошо")
        XCTAssertEqual(error.errorInfo, expectedErrorInfo)
    }

    func testUnableToRestartLobby() throws {
        let error = ApiError.unableToRestartLobby
        let expectedErrorInfo = ErrorInfo("Не удалось начать игру", "Проверьте интернет", "Хорошо")
        XCTAssertEqual(error.errorInfo, expectedErrorInfo)
    }

    func testUnableToGetGenres() throws {
        let error = ApiError.unableToGetGenres
        let expectedErrorInfo = ErrorInfo("Не удалось получить жанры", "Проверьте интернет", "Хорошо")
        XCTAssertEqual(error.errorInfo, expectedErrorInfo)
    }

    func testUnableToConfirmGenres() throws {
        let error = ApiError.unableToConfirmGenres
        let expectedErrorInfo = ErrorInfo("Не удалось подтвердить жанры", "Проверьте интернет", "Хорошо")
        XCTAssertEqual(error.errorInfo, expectedErrorInfo)
    }

    func testUnableToGetMovies() throws {
        let error = ApiError.unableToGetMovies
        let expectedErrorInfo = ErrorInfo("Не удалось получить фильмы", "Проверьте интернет", "Хорошо")
        XCTAssertEqual(error.errorInfo, expectedErrorInfo)
    }
}

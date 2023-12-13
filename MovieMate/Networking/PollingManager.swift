//
//  PollingManager.swift
//  MovieMate
//
//  Created by Denis Beloshitskiy on 12/7/23.
//

import Foundation
import Combine

final class PollingManager {
    private(set) var shouldStartPolling = false

    private var cancellable: AnyCancellable?

    func startPolling() {
        guard !shouldStartPolling else { return }
        shouldStartPolling = true

        cancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                Task {
                    await ApiClient.shared.updateLobbyInfo()
                }
            }
    }

    func stopPolling() {
        guard shouldStartPolling else { return }
        shouldStartPolling = false

        cancellable?.cancel()
    }
}

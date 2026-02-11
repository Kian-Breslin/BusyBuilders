//
//  TimerManager.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import SwiftUI
import Foundation
import Combine

class TimerManager: ObservableObject {
    @Published var timeElapsed: Int = 0
    @Published var isRunning: Bool = false

    private var timer: AnyCancellable?
    var onComplete: (() -> Void)?

    func start(duration: Int? = nil) {
        isRunning = true
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.timeElapsed += 1
            }
    }

    func pause() {
        isRunning = false
        timer?.cancel()
    }

    func stop() {
        isRunning = false
        timer?.cancel()
    }

    func reset() {
        stop()
        timeElapsed = 0
    }
}

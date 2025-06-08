//
//  TimerManager.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 08/05/2025.
//

import Foundation
import Combine

class TimerManager: ObservableObject {
    @Published var timeElapsed: Int = 0
    private var timer: AnyCancellable?
    private(set) var isRunning = false

    func start() {
        guard !isRunning else { return }
        isRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.timeElapsed += 1
            }
    }

    func pause() {
        timer?.cancel()
        isRunning = false
    }

    func reset() {
        pause()
        timeElapsed = 0
    }
}

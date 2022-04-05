//
//  ResultViewModel.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 30/03/22.
//

import SwiftUI

final class ResultViewModel: ObservableObject {
    
    @Published var viewState: ResultState
    
    init(viewState: ResultState) {
        self.viewState = viewState
    }
    
    var answeredCountFormatted: String {
        String(format: "%02d/%02d", viewState.answersCount, viewState.totalCount)
    }
    
    var timeRemainingFormatted: String {
        let (minutes, seconds) = viewState.secondsRemaining.toMinutesSeconds()
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var buttonTitle: String {
        viewState.timerState == .running ? L10n.ResultView.reset : L10n.ResultView.start
    }
    
    func triggerTimer() {
        if viewState.timerState == .running {
            viewState.timerState = .idle
        } else {
            viewState.timerState = .running
        }
    }
}

extension ResultViewModel {
    struct ResultState {
        @Binding var timerState: TimerState
        let answersCount: Int
        let totalCount: Int
        let secondsRemaining: Int
    }
}

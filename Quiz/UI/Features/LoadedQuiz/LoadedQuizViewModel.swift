//
//  LoadedQuizViewModel.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 29/03/22.
//

import Foundation

private let MAX_SECONDS = 30

final class LoadedQuizViewModel: ObservableObject {
    
    @Published var viewState: ViewState
    @Published var timerState: TimerState = .idle
    
    let question: String
    let wordsList: [String]
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(
        viewState: ViewState,
        question: String,
        wordsList: [String]
    ) {
        self.viewState = viewState
        self.question = question
        self.wordsList = wordsList
    }
    
    var isQuizTextFieldEnabled: Bool {
        timerState == .runningTimer
    }
    
    func handleTimerTick() {
        if timerState == .runningTimer {
            viewState.secondsRemaining -= 1
            if viewState.secondsRemaining == 0 {
                timerState = .paused
                viewState.activeAlert = .failureAlert(got: viewState.answeredList.count, outOf: wordsList.count)
            }
        }
    }
    
    func handleTimerStateChange() {
        if timerState == .idle {
            viewState.secondsRemaining = MAX_SECONDS
            viewState.answeredList = []
        }
    }
    
    func restartQuiz() {
        timerState = .idle
    }
    
    func submitWord() {
        if canAddWordToAnswers {
            viewState.answeredList.append(viewState.word.capitalized)
            viewState.word = ""
        }
    }
    
    func checkForVictory() {
        if wordsList.count == viewState.answeredList.count {
            timerState = .paused
            viewState.activeAlert = .successAlert
        }
    }
    
    private var canAddWordToAnswers: Bool {
        wordsList.caseInsensitiveContains(viewState.word) && !viewState.answeredList.caseInsensitiveContains(viewState.word)
    }
    
}

extension LoadedQuizViewModel {
    struct ViewState {
        var word: String = ""
        var secondsRemaining: Int = MAX_SECONDS
        var answeredList: [String] = []
        var activeAlert: AlertInfo? = nil
    }
}

extension AlertInfo {
    static let successAlert: AlertInfo = {
        AlertInfo(id: .success,
                  title: L10n.ResultViewSuccessAlert.title,
                  message: L10n.ResultViewSuccessAlert.message,
                  button: L10n.ResultViewSuccessAlert.button)
    }()
    
    static func failureAlert(got answersCount: Int, outOf wordsCount: Int) -> AlertInfo {
        AlertInfo(id: .failure,
                  title: L10n.ResultViewFailureAlert.title,
                  message: String(format: L10n.ResultViewFailureAlert.message, answersCount, wordsCount),
                  button: L10n.ResultViewFailureAlert.button)
    }
}

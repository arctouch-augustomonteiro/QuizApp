//
//  ResultViewModel+Preview.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 30/03/22.
//

import Foundation

extension ResultViewModel {
    static let preview = ResultViewModel(viewState: .init(timerState: .constant(.idle),
                                                          answersCount: 7,
                                                          totalCount: 50,
                                                          secondsRemaining: 150))
}

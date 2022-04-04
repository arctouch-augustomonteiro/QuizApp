//
//  ResultViewModel+Preview.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 30/03/22.
//

import Foundation

extension LoadedQuizViewModel {
    static let preview = LoadedQuizViewModel(viewState: .init(),
                                             question: "Question",
                                             wordsList: ["Anwser"])
}

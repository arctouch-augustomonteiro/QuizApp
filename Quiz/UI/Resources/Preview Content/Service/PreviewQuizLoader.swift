//
//  QuizLoader.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 30/03/22.
//

import Foundation

class PreviewQuizLoader: QuizLoader {
    func load(completion: @escaping (QuizLoader.Result) -> Void) {
        completion(.success(.init(question: "Question",
                                  answer: ["Answer1", "Answer2"])))
    }
}

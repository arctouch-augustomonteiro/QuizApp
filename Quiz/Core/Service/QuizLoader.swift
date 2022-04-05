//
//  ImageLoader.swift
//  Thinking in SwiftUI
//
//  Created by Augusto Monteiro on 21/03/22.
//

import Foundation

protocol QuizLoader {
    typealias Result = Swift.Result<Quiz, Error>
    func load(completion: @escaping (Result) -> Void)
}

final class FakeQuizLoader: QuizLoader, ObservableObject {
    
    public func load(completion: @escaping (QuizLoader.Result) -> Void) {
        completion(.success(Quiz(question: "Question", answer: ["Answer1", "Answer2"])))
    }
    
}

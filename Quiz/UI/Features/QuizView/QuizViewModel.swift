//
//  QuizViewModel.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 30/03/22.
//

import Foundation

final class QuizViewModel: ObservableObject {
    
    @Published var state: ViewState = .loading
    
    let quizLoader: QuizLoader
    
    init(quizLoader: QuizLoader) {
        self.quizLoader = quizLoader
    }
    
    func fetchWordsList() {
        state = .loading
        quizLoader.load { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(model):
                self.state = .loaded(model)
            case .failure:
                self.state = .error
            }
        }
    }
}

extension QuizViewModel {
    enum ViewState: Equatable {
        case loading
        case error
        case loaded(Model)
    }
    
    struct Environment {
        let quizLoader: QuizLoader
    }
}
//
//  ContentView.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 22/03/22.
//

import SwiftUI

struct QuizView: View {
    
    @StateObject var viewModel: QuizViewModel
    
    var body: some View {
        content
            .onAppear { viewModel.fetchWordsList() }
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
    
    @ViewBuilder var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView(L10n.QuizView.loading)
            
        case let .loaded(model):
            LoadedQuizView(viewModel: .init(viewState: .init(),
                                            question: model.question,
                                            wordsList: model.answer))
            
        case .error:
            Button(L10n.QuizView.loadError) { viewModel.fetchWordsList() }
        }
    }
    
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(viewModel: .preview)
    }
}

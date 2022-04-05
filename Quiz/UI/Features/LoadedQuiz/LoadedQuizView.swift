//
//  LoadedQuizView.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 24/03/22.
//

import SwiftUI

struct LoadedQuizView: View {
    
    @ObservedObject var viewModel: LoadedQuizViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.question)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .layoutPriority(1)
            
            TextField(L10n.LoadedQuizView.textFieldPlaceholder,
                      text: $viewModel.viewState.word)
            .font(.title2)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            .disabled(!viewModel.isQuizTextFieldEnabled)
            .onSubmit {
                viewModel.submitWord()
            }
            
            List(viewModel.viewState.answeredList.sorted(), id: \.self) {
                Text($0)
            }
            .listStyle(PlainListStyle())
            
            ResultView(viewModel:
                    .init(
                        viewState: .init(
                            timerState: $viewModel.timerState,
                            answersCount: viewModel.viewState.answeredList.count,
                            totalCount: viewModel.wordsList.count,
                            secondsRemaining: viewModel.viewState.secondsRemaining)
                    )
            )
            .overlay(Divider(), alignment: .top)
        }
        .onReceive(viewModel.timer) { _ in
            viewModel.handleTimerTick()
        }
        .onChange(of: viewModel.viewState.answeredList) { _ in
            viewModel.checkForVictory()
        }
        .onChange(of: viewModel.timerState) { _ in
            viewModel.handleTimerStateChange()
        }
        .alert(item: $viewModel.viewState.activeAlert) { info in
            Alert(title: Text(info.title), message: Text(info.message), dismissButton: .default(Text(info.button)) {
                viewModel.restartQuiz()
            })
        }
    }
    
}

struct LoadedQuizView_Previews: PreviewProvider {
    static var previews: some View {
        LoadedQuizView(viewModel: .preview)
            .previewLayout(.sizeThatFits)
    }
}

//
//  LoadedQuizView.swift
//  QuizApp
//
//  Created by Augusto Monteiro on 24/03/22.
//

import SwiftUI

struct LoadedQuizView: View {
    
    @AppStorage(wrappedValue: "", AppStorageKeys.username.rawValue) var username
    
    @StateObject var viewModel: LoadedQuizViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            textField
            listView
            resultView
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
    
    var header: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            if !username.isEmpty {
                HStack {
                    Text("Hello, " + username)
                    Spacer()
                    Button("Logout") {
                        username = ""
                    }
                }
                .font(.body)
            } else {
                HStack {
                    Spacer()
                    Button("Login") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            
            Text(viewModel.question)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .padding()
        .layoutPriority(1)
    }
    
    var textField: some View {
        TextField(L10n.LoadedQuizView.textFieldPlaceholder,
                  text: $viewModel.viewState.word)
        .font(.title2)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.horizontal)
        .disabled(!viewModel.isQuizTextFieldEnabled)
        .onSubmit {
            viewModel.submitWord()
        }
    }
    
    var listView: some View {
        List(viewModel.viewState.answeredList.sorted(), id: \.self) {
            Text($0)
        }
        .listStyle(PlainListStyle())
    }
    
    var resultView: some View {
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
    
}

struct LoadedQuizView_Previews: PreviewProvider {
    static var previews: some View {
        LoadedQuizView(viewModel: .preview)
            .previewLayout(.sizeThatFits)
    }
}
